//
//  XSSettingFeedbackViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/9.
//

import UIKit
import QMUIKit
import SVProgressHUD




class XSSettingFeedbackViewController: XSBaseViewController {
    
    @IBOutlet weak var selectFbTypeButton: UIButton!
    
    @IBOutlet weak var questionTitleTFView: UIView!
    @IBOutlet weak var questionTitleTF: UITextField!
    
    @IBOutlet weak var detailDescView: UIView!
    
    @IBOutlet weak var detailDescTextView: QMUITextView!
    
    
    @IBOutlet weak var detailDescTextViewLenLabel: UILabel!
    
    @IBOutlet weak var uploadPicCollectionView: UICollectionView!
    
    
    let MaxUploadPicNum = 4
    
    var typeListTitles = [XSFeedbackTypeListModel]()
    
//    [FeedbackModel(title: "功能建议", isSelect: true),
//                      FeedbackModel(title: "注册相关", isSelect: false),
//                      FeedbackModel(title: "订单相关", isSelect: false),
//                      FeedbackModel(title: "技术服务相关", isSelect: false),
//                      FeedbackModel(title: "其他", isSelect: false)]

    
    var selectFeedBackType: Int?
    var selectFeedBackTypeTitle: String?

    
    lazy var backView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .lightGray
        iv.alpha = 0.3
        iv.frame = self.view.bounds
        iv.jk.addGestureTap {[weak self] _ in
            self?.closeQuestView()
        }
        return iv
    }()
    
    lazy var questTypeMenu: UITableView = {
        let iv = UITableView()
        iv.separatorStyle = .none
        iv.dataSource = self
        iv.delegate = self
        iv.tableFooterView = UIView()
        iv.register(cellType: XSQuestSelectTypeTableViewCell.self)
        iv.hg_setAllCornerWithCornerRadius(radius: 4)
        return iv
    }()
    
    
    var selectedPhotos = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        title = "意见反馈"
    }
   
    
    
    override func initSubviews() {
        
        selectFbTypeButton.jk.addBorder(borderWidth: 1.0, borderColor: .borad)
        
        questionTitleTFView.layer.cornerRadius = 4
        questionTitleTFView.layer.borderWidth = 1
        questionTitleTFView.layer.borderColor = UIColor.borad.cgColor
        questionTitleTF.jk.setPlaceholderAttribute(font: .myFont28, color: .fourText)
        questionTitleTF.placeholder = "请输入反馈标题"
        

        detailDescView.layer.cornerRadius = 10
        detailDescView.layer.borderWidth = 1
        detailDescView.layer.borderColor = UIColor.borad.cgColor

        let flowLayout = UICollectionViewFlowLayout()
        let itemWidth: CGFloat = 85.0
        let itemLineSpaceing: CGFloat = ((screenWidth - 20) - CGFloat(MaxUploadPicNum) * itemWidth) / (CGFloat)(MaxUploadPicNum - 1)
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = itemLineSpaceing
        flowLayout.minimumInteritemSpacing = 0
        uploadPicCollectionView.collectionViewLayout = flowLayout
        uploadPicCollectionView.register(cellType: XSUploadPicCollectionViewCell.self)
        
    }
    
    /// mark - 点击弹出反馈类别选择view
    @IBAction func selectQuestType(_ sender: UIButton) {
        
        XSTipsHUD.showLoading("", inView: self.view)
        MerchantInfoProvider.request(.userFeedbackTypeList, designatedPath: "data", model: XSFeedbackTypeListModel.self) { returnData in
            
        } pathCompletion: { returnData in
            XSTipsHUD.hideAllTips(inView: self.view)
            
            DispatchQueue.main.async {
                for (idx, typeModel) in returnData.enumerated() {
                    typeModel.isSelect = (idx == 0)
                    self.typeListTitles.append(typeModel)
                }
                self.view.addSubview(self.backView)
                
                self.view.addSubview(self.questTypeMenu)
                self.questTypeMenu.snp.makeConstraints {
                    $0.top.equalTo(sender.snp.bottom)
                    $0.left.right.equalTo(sender)
                    $0.height.equalTo(44 * self.typeListTitles.count)
                }
                
                self.questTypeMenu.reloadData()
            }
            
            
            
        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips(inView: self.view)
            XSTipsHUD.showText(errorMsg)
        }

        
        
    }
    
    @objc func closeQuestView(){
        backView.removeFromSuperview()
        questTypeMenu.removeFromSuperview()
    }
    
    @IBAction func inputFeedBackBunClick(_ sender: UIButton) {
        
        guard let _ = selectFeedBackType else {
            SVProgressHUD.showError(withStatus: "请选择反馈类别")
            return
        }
        
        let textLength = detailDescTextView.text.qmui_lengthWhenCountingNonASCIICharacterAsTwo
        if textLength < 10 {
            SVProgressHUD.showError(withStatus: "请输入10字以上的详细说明")
            return
        }
        
        if selectedPhotos.count > 0 {
            
            XSTipsHUD.showLoading("正在上传", inView: self.view)
            MerchantInfoProvider.request(.batchUpload(selectedPhotos), model: [TBUploadResultModel].self) { returnData in
                if let model = returnData {
                    let urls = model.map { uploadMoes -> String in
                        return uploadMoes.url
                    }
                    self.fetchFeedback(uploadUrls: urls)
                }
                
            } errorResult: { error in
                uLog(error)
                XSTipsHUD.showText(error)
            }
        } else {
            fetchFeedback(uploadUrls: nil)
        }
    
    }
    
    func fetchFeedback(uploadUrls: [String]?) {
        var params = [String : Any]()
        params["typeId"] = selectFeedBackType
        params["title"] = selectFeedBackTypeTitle
        params["content"] = detailDescTextView.text

        if let uploadUrls = uploadUrls {
            params["picUrl"] = uploadUrls
        }

        MerchantInfoProvider.request(.userFeedbackAdd(params: params), designatedPath: nil, model: XSMerchInfoHandlerModel.self) { returnData in
            
            
            if (returnData?.trueOrFalse ?? -1) == 0 {
                DispatchQueue.main.async {
                   
                    let alert = TbAlertController(textTitle: "温馨提示", message: "意见反馈已经提交成功，我们的进步离不开大家的帮助和支持，行膳有味深表感谢！(3后关闭页面)", preferredStyle: .preferredStyleAlert)
                    alert.titleFont = .systemFont(ofSize: 16, weight: .semibold)
                    alert.titleColor = UIColor.hex(hexString: "#060607")
                    alert.separatorlLneColor = UIColor.hex(hexString: "#D8D8D8")
                    alert.contentWidth = FMScreenScaleFrom(311)
                    alert.contentViewRadius = 10
                    
                    let alertAction = TbAlertAction(textTitle: "关闭页面", alertActionStyle: .TbAlertActionStyleDefault) { action in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alertAction.setTitleColor(titleColor: UIColor.king, forState: .normal)
                    alert.addAction(action: alertAction)

                    self.present(alert, animated: true, completion: nil)
                    
                   // DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        alert.dismiss(animated: true, delay: 3.0) {
                            self.navigationController?.popViewController(animated: true)
                        }
                   // }
                }
               

            }
        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips(inView: self.view)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
}

extension XSSettingFeedbackViewController: QMUITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //uLog(textView.text)
        let textLength = textView.text.qmui_lengthWhenCountingNonASCIICharacterAsTwo
        //uLog(textView.text + "size:\(textLength)")
        detailDescTextViewLenLabel.text = "\(textLength)/200"
    }
}

extension XSSettingFeedbackViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (selectedPhotos.count >=  MaxUploadPicNum ) {
            return selectedPhotos.count;
        }
        return selectedPhotos.count + 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSUploadPicCollectionViewCell.self)
        if indexPath.item == selectedPhotos.count {
            cell.picImagView.image = #imageLiteral(resourceName: "mine_upload_add")
            cell.deleteButton.isHidden = true
            cell.msgLabel.isHidden = false
        } else {
            cell.picImagView.image = selectedPhotos[indexPath.item]
            cell.deleteButton.isHidden = false
            cell.msgLabel.isHidden = true
        }
        cell.msgLabel.text = "上传图片最多\(MaxUploadPicNum)张"
        cell.tagIdx = indexPath.item
        cell.delegate = self
        return cell
    }

}

extension XSSettingFeedbackViewController: UICollectionViewDelegate,XSSelectImgManageDelegate,XSUploadPicCollectionViewCellDeleDelegate {
    func deleteIndexOfPic(idx: NSInteger) {
        selectedPhotos.remove(at: idx)
        uploadPicCollectionView.reloadData()
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imgManage = XSSelectImgManage()
        imgManage.delegate = self
        imgManage.showImagePicker(controller: self, soureType: .XSSelectImgTypeDefault,maxItemCount: 4)
    }
    
    func XSSelectImgManageFinsh(images: [UIImage]) {
        selectedPhotos.appends(images)
        uploadPicCollectionView.reloadData()
    }
    
}

extension XSSettingFeedbackViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.typeListTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "XSQuestSelectTypeTableViewCell", for: indexPath) as! XSQuestSelectTypeTableViewCell
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSQuestSelectTypeTableViewCell.self)
        let feedBackModel = typeListTitles[indexPath.row]
        cell.feedBackModel = feedBackModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for index in 0..<typeListTitles.count {
            let model = typeListTitles[index]
            model.isSelect = (index == indexPath.row ?  true :  false)
        }
 
        
        let feedBackModel = typeListTitles[indexPath.row]
        selectFeedBackType = feedBackModel.id
        selectFeedBackTypeTitle = feedBackModel.name

        questTypeMenu.reloadData()
        closeQuestView()
    }
}


