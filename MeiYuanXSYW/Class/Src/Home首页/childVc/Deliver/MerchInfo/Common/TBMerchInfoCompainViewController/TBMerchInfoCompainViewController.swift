//
//  TBMerchInfoCompainViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/10.
//

import UIKit
import HandyJSON


class FeedbackModel {
    var title: String = ""
    var isSelect: Bool = false
    init(title: String, isSelect: Bool) {
        self.title = title
        self.isSelect = isSelect
    }
}


class TBMerchInfoCompainViewController: XSBaseViewController {

    let compainSections = ["商家名称","举报内容","特别不爽，必须吐糟",""]
    let compains = ["商家不让使用优惠券/优惠买单","商家说可以以优惠价支付现金","商家说写好评可以优惠/送礼","资质问题",
                    "超经营范围","违规商品","虚假门店","资质问题","刷销量","刷好评"]
    
    var compainModels = [FeedbackModel]()
    var detailModel: TBDelieveMerchatInfoModel?
    
    var merchantId: String = ""
    
    let maxUploadNum = 6
    var uploadImageUrls = [UIImage]()
    var remark: String = ""
    var compainTypes = [Int]()
    
    
    lazy var compainTableView: TBBaseTableView = {
        let exendTableView = TBBaseTableView(frame: .zero, style: .plain)
        exendTableView.register(cellType: TBMerchInfoDetailAddressCell.self)
        exendTableView.register(cellType: XSQuestSelectTypeTableViewCell.self)
        exendTableView.register(cellType: TBMerchInfoCompainTextViewCell.self)
        exendTableView.register(cellType: TBMerchInfoCompainUploadPicCell.self)
        exendTableView.backgroundColor = .background
        exendTableView.estimatedRowHeight = 80
        exendTableView.dataSource = self
        exendTableView.delegate = self
        //exendTableView.tableFooterView = footerView
        return exendTableView
    }()
    
    lazy var inputButton: UIButton = {
        let input = UIButton(type: .custom)
        input.setTitle("提交举报", for: .normal)
        input.setTitleColor(.white, for: .normal)
        input.hg_setAllCornerWithCornerRadius(radius: 22)
        input.addTarget(self, action: #selector(inputBtnClick), for: .touchUpInside)
        return input
    }()
    
    init(merchantId: String) {
        self.merchantId = merchantId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationTitle = "商家投诉"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        inputButton.hg_addGradientColor([UIColor(red: 0.94, green: 0.8, blue: 0.61, alpha: 1),
                                         UIColor(red: 0.91, green: 0.75, blue: 0.54, alpha: 1)],
                                        size: CGSize(width: screenWidth - 10 - 22, height: 44),
                                        startPoint: CGPoint(x: 0.5, y: 0),
                                        endPoint: CGPoint(x: 1, y: 1))
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(inputButton)
        inputButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.usnp.bottom).offset(-30)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-22)
            make.height.equalTo(44)
        }
        
        self.view.addSubview(compainTableView)
        compainTableView.snp.makeConstraints { make in
            make.bottom.equalTo(inputButton.snp_top).offset(-30)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(self.view.usnp.top)
        }
    }
    
    
    override func initData() {
        compainModels = compains.map { title -> FeedbackModel in
            let model = FeedbackModel(title: "注册相关", isSelect: false)
            model.title = title
            return model
        }
       
        
    }
    
    @objc func inputBtnClick() {
        
        if compainTypes.count <= 0 {
            XSTipsHUD.showError("请选择投诉内容")
            return
        }

        if remark.count <= 10 {
            XSTipsHUD.showError("请输入10字以上的投诉描述")
            return
        }
        
        if uploadImageUrls.count == 0 {
            XSTipsHUD.showLoading("正在上传", inView: self.view)
            MerchantInfoProvider.request(.saveMerchantComplaint(_merchantId: merchantId, uploadPicStr: nil, remark: remark, complaintContent: compainTypes), model: XSMerchInfoHandlerModel.self) { returnData in
                XSTipsHUD.hideAllTips(inView: self.view)

                if (returnData?.trueOrFalse ?? 0 == 0) {
                    XSTipsHUD.showText("举报提交成功，感谢您的帮助，后续信息会以消息的方式提醒您")
                    self.compainTypes.removeAll()
                    
                }

            } errorResult: { errorMsg in
                XSTipsHUD.hideAllTips(inView: self.view)
                uLog(errorMsg)
                XSTipsHUD.showText(errorMsg)
            }
            
        } else {
            XSTipsHUD.showLoading("正在上传", inView: self.view)
            MerchantInfoProvider.request(.batchUpload(uploadImageUrls), model: [TBUploadResultModel].self) { returnData in
                if let model = returnData {
                    let urls = model.map { uploadMoes -> String in
                        return uploadMoes.url
                    }
                    XSTipsHUD.hideAllTips(inView: self.view)
                    XSTipsHUD.showLoading("正在上传", inView: self.view)

                    MerchantInfoProvider.request(.saveMerchantComplaint(_merchantId: self.merchantId, uploadPicStr: urls, remark: self.remark, complaintContent: self.compainTypes), model: XSMerchInfoHandlerModel.self) { returnData in
                        XSTipsHUD.hideAllTips(inView: self.view)

                        if (returnData?.trueOrFalse ?? 0 == 0) {
                            XSTipsHUD.showSucceed("举报提交成功，感谢您的帮助，后续信息会以消息的方式提醒您")
                            self.compainTypes.removeAll()
                            self.uploadImageUrls.removeAll()
                        }

                    } errorResult: { errorMsg in
                        uLog(errorMsg)
                        XSTipsHUD.hideAllTips(inView: self.view)
                        XSTipsHUD.showText(errorMsg)
                    }
                    
                    
                    
                }
                
            } errorResult: { errorMsg in
                uLog(errorMsg)
                XSTipsHUD.showText(errorMsg)
            }
            
        }
            
    }

}

extension TBMerchInfoCompainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return compainSections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return compainModels.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoDetailAddressCell.self)
            cell.configCompain()
            if let detailModel = detailModel {
                cell.merchLogo.xs_setImage(urlString: detailModel.merchantLogo)
                cell.merchNameLab.text = detailModel.merchantName
                cell.merchAddressLab.text = detailModel.merchantAddress
            }
          
            return cell
        } else if(indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSQuestSelectTypeTableViewCell.self)
            let model = compainModels[indexPath.row]
            cell.merchantFeedBackModel = model
            
            cell.backgroundColor = .white
            
            if indexPath.row == 0 {
                cell.hg_setCornerOnTopWithRadius(radius: 10)
            }
            
            if indexPath.row == compainModels.count - 1 {
                cell.hg_setCornerOnBottomWithRadius(radius: 10)
            }
            return cell
        } else if(indexPath.section == 2) {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoCompainTextViewCell.self)
            cell.textViewDidChange = { [weak self] cell in
                self?.remark = cell.textView.text
            }
           
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoCompainUploadPicCell.self)
            cell.selectPicCompleteBlock = { [weak self] selectImages in
                self?.uploadImageUrls = selectImages
            }
            cell.superVc = self
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 66
        } else if (indexPath.section == 1) {
            return 44
        } else if (indexPath.section == 2) {
            return 240
        } else {
            return 180
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let compain = compainModels[indexPath.row]
            compain.isSelect = !compain.isSelect
            
            if compain.isSelect {
                compainTypes.append(indexPath.row)
            } else {
                if(compainTypes.contains(indexPath.row)) {
                    compainTypes.remove(indexPath.row)
                }
            }
            
            compainTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .background
        
        let lab = UILabel()
        lab.font = MYBlodFont(size: 14)
        lab.textColor = .text
        lab.text = compainSections[section]
        
        view.addSubview(lab)
        lab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        return view
    }
    
    
}
