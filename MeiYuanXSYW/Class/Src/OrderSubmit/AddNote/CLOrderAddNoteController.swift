//
//  CLOrderAddNoteController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/8.
//

import UIKit
import  QMUIKit
import SwiftyJSON
import Moya

class CLOrderAddNoteController: XSBaseViewController {
    var modelDate:[CLAddNoteModel] = []
    
    /// 传值B->A
    var valueBlock:((_ text:String)->())?
    /// 最大行5行
    var numberOfLine:Int = 0

    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.hg_setAllCornerWithCornerRadius(radius: 10)
    }

    let reasonTextView = QMUITextView()
    
    let desLabel = UILabel().then{
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
        $0.text = "0/50"
    }
    
    let markLabel = UILabel().then{
        $0.text  = "备注信息"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let editButton = UIButton().then{
        $0.setTitle("编辑", for: .normal)
        $0.setTitleColor(.twoText, for: .normal)
        $0.titleLabel?.font = MYFont(size: 12)
        $0.addTarget(self, action: #selector(editAction), for: .touchUpInside)
    }
    
    let labelBaseView = UIView().then{
        $0.backgroundColor = .lightBackground
    }
    
    var model:[String] = ["请电话联系我","放门口","放前台","挂门把手上","不要辣","少辣","多辣","少油","加醋","不要香菜","不要葱","不要汤","多点汤"]{
        didSet{
            self.setUpLabels()
        }
    }
            
    var noteLabelArray:[CLOrderSubmitNoteView] = []
    
    var flag:Bool = false
    
    var text:String = ""
    
    @objc func editAction(){
        if editButton.title(for: .normal) == "编辑"{
            self.flag = true //进入编辑状态
            editButton.setTitle("完成", for: .normal)
            for i in 0 ..< model.count {
                noteLabelArray[i].close.isHidden = false
            }
        }
        else if editButton.title(for: .normal) == "完成"{
            //TODO 调用接口保存数据
            XSTipsHUD.showText("保存成功")
            self.flag = false //退出编辑状态
            editButton.setTitle("编辑", for: .normal)
            for i in 0 ..< model.count {
                noteLabelArray[i].close.isHidden = true
            }
        }
    }
    
    @objc func tapClick(sender:UIGestureRecognizer){
        let appendString = text == "" ? self.model[sender.view!.tag]:"," + self.model[sender.view!.tag]
        text = text + appendString
        
        let textLength = text.qmui_lengthWhenCountingNonASCIICharacterAsTwo
        if textLength > 50 {
            return
        }
        
        reasonTextView.text = text
    }
    
    @objc func finish(){
        
        guard let action = self.valueBlock else { return }
        action(reasonTextView.text!)
        self.navigationController?.popViewController(animated: true)
        
//        self.model.insertFirst("这是一个自定义标签这是一个自定义标签这是一个自定义标签")
//        self.labelBaseView.subviews.forEach{ $0.removeFromSuperview()}
//        setUpLabels()
    }
    
    func setUpLabels(){
        
        numberOfLine = 0
        noteLabelArray.removeAll()
        
        var leftWidth:CGFloat = screenWidth - 45
        var topHeight:CGFloat = 10
        var left:CGFloat = 10
        
        var markHeight:CGFloat = 0
        
        for i in 0 ..< model.count {

            let noteLabel = CLOrderSubmitNoteView()
            noteLabelArray.append(noteLabel)
            noteLabel.tag = i
            noteLabel.closeBlock = {[unowned self] in
                self.model.remove(at: noteLabel.tag)
                self.noteLabelArray.remove(at: noteLabel.tag)
                self.labelBaseView.subviews.forEach{ $0.removeFromSuperview()}
                self.setUpLabels()
            }
            
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick(sender:)))
            noteLabel.addGestureRecognizer(tap)
            
            noteLabel.title.text = model[i]
            if flag {
                noteLabel.close.isHidden = false
            }else{
                noteLabel.close.isHidden = true
            }
            
            let width  = model[i].boundingRect(font: MYFont(size: 14), limitSize: CGSize(width: screenWidth - 45, height: CGFloat(MAXFLOAT))).width
            let height = model[i].boundingRect(font: MYFont(size: 14), limitSize: CGSize(width: screenWidth - 45, height: CGFloat(MAXFLOAT))).height
            
//            uLog("width:\(width)====leftWidth:\(leftWidth)")
            
            if width < leftWidth  {
                self.labelBaseView.addSubview(noteLabel)
                noteLabel.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(left)
                    make.top.equalToSuperview().offset(topHeight)
                    make.width.equalTo(width + 25)
                    make.height.equalTo(height + 25)
                }
                
                leftWidth =  leftWidth -  (width + 25)
                left = left + width + 25
                
                markHeight = height
                                
            }else{
                //换行
                numberOfLine += 1
                
                if numberOfLine > 5 {
                    self.showAlert(title: "提示", message: "最多保存5行", alertType: .alert, sureBlock: nil, cancelBlock: nil)
                }
                
                self.labelBaseView.addSubview(noteLabel)
                left = 10

                topHeight = topHeight + markHeight + 25 + 10

                noteLabel.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(10)
                    make.top.equalToSuperview().offset(topHeight)
                    make.width.equalTo(width + 25)
                    make.height.equalTo(height + 25)
                }
                
                markHeight = height
                leftWidth = screenWidth - width - 45
                left = left + width + 25
            }
        }
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        let item = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(finish))
        item.tintColor = .text
        self.navigationItem.rightBarButtonItems = [item]
    }
    
    
    func loadData(){
        
        myOrderProvider.request(.getOrderRemark) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    uLog(jsonData["data"])
                    self.modelDate = jsonData["data"].arrayValue.compactMap{
                        return CLAddNoteModel.init(jsonData: $0)
                    }
                    
                    var tempModel:[String] = []
                    for item in self.modelDate {
                        tempModel.append(item.remark)
                    }
                    
                    DispatchQueue.main.async {
                        self.model = tempModel
                    }
                    
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

             case let .failure(error):
                //网络连接失败，提示用户
                print("网络连接失败\(error)")
            }
        }
    }
    override func viewDidLoad() {
        loadData()
        super.viewDidLoad()
        self.navigationTitle = "添加备注"
        view.backgroundColor = .lightBackground
        view.addSubview(baseView)
        view.addSubviews(views: [markLabel,editButton,labelBaseView])
        baseView.addSubview(reasonTextView)
        baseView.addSubview(desLabel)
        
//        reasonTextView.setValue(50, forKeyPath: "maximumTextLength")
        reasonTextView.setValue(UIColor.twoText, forKeyPath: "placeholderColor")
        reasonTextView.setValue("请添加备注消息", forKeyPath: "placeholder")
        reasonTextView.setValue(MYFont(size: 14), forKeyPath: "font")
        reasonTextView.delegate = self

        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(200)
        }
        reasonTextView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        desLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        markLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(baseView.snp.bottom).offset(15)
        }
        
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(markLabel.snp.centerY)
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
        
        labelBaseView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(markLabel.snp.bottom).offset(15)
            make.bottom.equalTo(self.view.usnp.bottom)
        }
        
//        setUpLabels()
        
    }
}
extension CLOrderAddNoteController: QMUITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        uLog(textView.text)
        self.text = textView.text
        let textLength = textView.text.qmui_lengthWhenCountingNonASCIICharacterAsTwo
        if textLength > 50 {
            return
        }
        desLabel.text = "\(textLength)/50"
    }
}
