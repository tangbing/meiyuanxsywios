//
//  XSPayAddressEditViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/22.
//

import UIKit
import BRPickerView
import SVProgressHUD
import JKSwiftExtension
import SwiftyJSON
import Moya


struct XSEditAddress {
    var title: String = ""
    var contentText: String?
    var placeholderText: String?
    // 0 女， 1 南
    var checkSex: Int = -1
    // 0 女， 1 南
    var checkAddressSign: Int = -1
}

class XSPayAddressEditViewController: XSBaseViewController {

    var selectLocation: CLReceiverAddressModel?
    var nameCell: XSPayAdressHeaderTableViewCell!
    
    
    let maxInputLimit: Int = 12
    var editTitles = [XSEditAddress(title: "联系人", contentText: nil, placeholderText: "请输入姓名"),
                      XSEditAddress(title: "手机号", contentText: nil, placeholderText: "请输入手机号"),
                      XSEditAddress(title: "所在地区", contentText: nil, placeholderText: "请选择所在区域"),
                      XSEditAddress(title: "详细地址", contentText: nil, placeholderText: "请输入详细地址"),
                      XSEditAddress(title: "地址标签", contentText: nil, placeholderText: nil)] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
//    、、[["title" : "联系人", "plcheholder" : "请输入姓名","text"],
//                       ["title"  : "手机号","plcheholder" : "请输入手机号"],
//                       ["title"  : "所在地区","plcheholder" : "请选择所在区域"],
//                       ["title"  : "详细地址","plcheholder" : "请输入详细地址"],
//                       ["title"  : "地址标签","plcheholder" : ""]]
    
    var footerSignalTableCell: XSPayAddressFooterTableViewCell?
    
    
    /// 联系人
    var userNameTextField: UITextField!
    /// 所在地区
    var areaTextField: UITextField!
    /// 联系电话
    var phoneTextField: UITextField!
    /// 详细地址
    var detailAddressTextField: UITextField!
    
    
    var addAddrestn :UIButton={
        let btn = UIButton()
        btn.titleLabel?.font = MYBlodFont(size: 16)
        btn.setTitleColor(.white, for: UIControl.State.normal)
        btn.setTitle("确认新增", for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage(named: "btnBackImg"), for: UIControl.State.normal)
        btn.hg_setAllCornerWithCornerRadius(radius: 22)
        btn.addTarget(self, action: #selector(sureAddAddress), for: .touchUpInside)
        return btn
    }()
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.dataSource = self
        tableV.delegate = self
        tableV.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableV.separatorColor = UIColor.hex(hexString: "#E5E5E5")
        tableV.register(cellType: XSPayAdressHeaderTableViewCell.self)
        tableV.register(cellType: XSPayAddressFooterTableViewCell.self)
        tableV.register(cellType: XSPayAdressTextFieldTableViewCell.self)

        let iv = UIView()
        iv.backgroundColor = .clear
        iv.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 74)
        
        iv.addSubview(addAddrestn)
        addAddrestn.frame = CGRect(x: 10, y: 30, width: screenWidth - 32, height: 44)
        
        tableV.tableFooterView = iv
        return tableV
    }()

    
    var model: CLReceiverAddressModel!
    
    var addressId: Int?
    
    init(addressId: Int?) {
        self.addressId = addressId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func initSubviews() {
      
        self.view.addSubview(tableView)
        tableView.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(self.view.usnp.top).offset(17)
            make.bottom.equalTo(self.view.usnp.bottom)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _ = addressId else {
            navigationTitle = "添加地址"
            addAddrestn.setTitle("确认新增", for: .normal)
            return
        }
        navigationTitle = "编辑地址"
        addAddrestn.setTitle("编辑新增", for: .normal)
        loadEditData()
    }

    
   
    private func loadEditData() {
        
        let dic = ["id":self.addressId ?? -1]
        
        XSTipsHUD.showLoading("", inView: self.view)
        
        myOrderProvider.request(MyOrderService.getUserReceiverById(dic)) { result in
            
            XSTipsHUD.hideAllTips()

            switch result {
                
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                uLog("jsonData:\(jsonData)")

                if  jsonData["resp_code"].intValue == 0{
                    
                    if let model = CLReceiverAddressModel.init(jsonData:jsonData["data"]){
                        self.updateAddressInfo(infoModel: model)
                        self.model = model
                    }
                    
                    
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

            case .failure(_):
                //网络连接失败，提示用户
                XSTipsHUD.hideAllTips()
                XSTipsHUD.showText("网络连接失败")
            }
        }
    }
    
    private func updateAddressInfo(infoModel: CLReceiverAddressModel) {
        
        let selectSpace = infoModel.receiverProvince + infoModel.receiverCity + infoModel.receiverRegion
        self.editTitles = [XSEditAddress(title: "联系人", contentText: infoModel.receiverName, placeholderText: nil,checkSex: infoModel.receiverSex),
                          XSEditAddress(title: "手机号", contentText: infoModel.receiverPhone, placeholderText: nil),
                          XSEditAddress(title: "所在地区", contentText:selectSpace, placeholderText: nil),
                          XSEditAddress(title: "详细地址", contentText:infoModel.receiverDetailAddress, placeholderText: nil),
                           XSEditAddress(title: "地址标签", contentText:nil, placeholderText: nil, checkAddressSign: infoModel.receiverLabel)
                        ]
        
    }
    
    func editAddressRequest(params: [String : Any]) {
        XSTipsHUD.showLoading("", inView: self.view)
        myOrderProvider.request(MyOrderService.saveOrUpdateReceiverAddress(params)) { result in
            XSTipsHUD.hideAllTips()
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                uLog("jsonData:\(jsonData)")

                if  jsonData["resp_code"].intValue == 0{
                    let flage = jsonData["data"]["trueOrFalse"].intValue
                    if flage == 0 {
                        XSTipsHUD.showText("操作成功！")
                    }

                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }
                
            case .failure(_):
                //网络连接失败，提示用户
                XSTipsHUD.hideAllTips()
                XSTipsHUD.showText("网络连接失败")
            }
        }
    }
    
    @objc func sureAddAddress(){
        
        
        if userNameTextField.text?.isEmpty ?? false {
            SVProgressHUD.showInfo(withStatus: "请输入联系人")
            SVProgressHUD.dismiss(withDelay: 1.5)
            return
        }
        
        //本地校验手机号
        let result = JKRegexHelper.validateTelephoneNumber(phoneTextField.text ?? "")
        if !result {
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号")
            SVProgressHUD.dismiss(withDelay: 1.5)
            return
        }
        
        if areaTextField.text?.isEmpty ?? false {
            SVProgressHUD.showInfo(withStatus: "请选择地区")
            SVProgressHUD.dismiss(withDelay: 1.5)
            return
        }
        
        if detailAddressTextField.text?.isEmpty ?? false {
            SVProgressHUD.showInfo(withStatus: "请输入详细地址")
            SVProgressHUD.dismiss(withDelay: 1.5)
            return
        }
        
        guard let _ = addressId else {
           
            
            // 新增
            var params = [String : Any]()
            params["receiverName"] = userNameTextField.text
            params["receiverSex"] = nameCell.womanBtn.isSelected ? 0 : 1
            params["receiverPhone"] = phoneTextField.text
            params["receiverProvince"] = self.selectLocation?.receiverProvince
            params["receiverCity"] =  self.selectLocation?.receiverCity
            params["receiverRegion"] =   self.selectLocation?.receiverRegion
            params["lat"] = self.selectLocation?.lat
            params["lng"] = self.selectLocation?.lng
            params["receiverDetailAddress"] = detailAddressTextField.text
            params["receiverLabel"] = getReceiverLabel()
            editAddressRequest(params: params)
            
            return
        }
        

        // 编辑
        var params = [String : Any]()
        params["receiverName"] = userNameTextField.text
        params["receiverSex"] = nameCell.womanBtn.isSelected ? 0 : 1
        params["receiverPhone"] = phoneTextField.text
        params["receiverLabel"] = getReceiverLabel()
        params["receiverDetailAddress"] = detailAddressTextField.text
        params["id"] = self.model.id

        params["receiverProvince"] = self.selectLocation?.receiverProvince
        params["receiverCity"] =  self.selectLocation?.receiverCity
        params["receiverRegion"] =   self.selectLocation?.receiverRegion
        params["lat"] = self.selectLocation?.lat
        params["lng"] = self.selectLocation?.lng
        editAddressRequest(params: params)
        
    }
    
    func getReceiverLabel() -> Int {
        if (footerSignalTableCell!.schoolTagBtn.isSelected) {
            return 2
        }
        if (footerSignalTableCell!.homeTagBtn.isSelected) {
            return 0
        }
        if (footerSignalTableCell!.companyTagBtn.isSelected) {
            return 1
        }
        return 0
    }

}

/// UITableViewDataSource & UITableViewDelegate
extension XSPayAddressEditViewController: UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let address = editTitles[indexPath.row]

        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSPayAdressHeaderTableViewCell.self)
            cell.backView.backgroundColor = .clear
            cell.backgroundColor = .white
            cell.userNameTextField.tag = indexPath.row
            cell.userNameTextField.delegate = self
            cell.hg_setCornerOnTopWithRadius(radius: 10)
            cell.userNameTextField.text = address.contentText
            userNameTextField = cell.userNameTextField
            nameCell = cell
            if address.checkSex == 0{
                cell.BtnClick(cell.womanBtn)
            } else {
                cell.BtnClick(cell.manBtn)
            }
            
            return cell
      
        case editTitles.count - 1:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSPayAddressFooterTableViewCell.self)
            footerSignalTableCell = cell
            cell.backgroundColor = .white
            cell.hg_setCornerOnBottomWithRadius(radius: 10)
            
            // 0 家， 1 公司 2学校
            if address.checkAddressSign == 0{
                cell.homeTagBtn.isSelected = true
                cell.companyTagBtn.isSelected = false
                cell.schoolTagBtn.isSelected = false
            } else if (address.checkAddressSign == 1) {
                cell.companyTagBtn.isSelected = true
                cell.homeTagBtn.isSelected = false
                cell.schoolTagBtn.isSelected = false
            } else {
                cell.schoolTagBtn.isSelected = true
                cell.companyTagBtn.isSelected = false
                cell.homeTagBtn.isSelected = false
            }
          
            return cell
        default:
            
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSPayAdressTextFieldTableViewCell.self)
     
            cell.payAddressTextField.delegate = self
            cell.payAddressTextField.tag = indexPath.row
            cell.accessoryType = indexPath.row == 2 ?  .disclosureIndicator : .none
            
            if indexPath.row == 1 { /// 手机号
                phoneTextField = cell.payAddressTextField
            } else if(indexPath.row == 3) {
                detailAddressTextField = cell.payAddressTextField
            } else if(indexPath.row == 2) {
                areaTextField = cell.payAddressTextField
            }
            cell.payAddressTextField.placeholder = address.placeholderText
            cell.payAddressTextField.text = address.contentText
            cell.payAddressNameLabel.text = address.title
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 94
        }
        return 54
    }
    
    /// UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 0 {
            uLog("Str:" + string + "text:" + textField.text!)
            uLog(range)
            let text = textField.text!
            let len = text.count + string.count - range.length
            return len <= maxInputLimit
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 2 {
            
            let mapView = XSMapViewSelectLocationViewController()
            mapView.selectLocationCompleteBlock = {
                self.selectLocation = $0
                self.areaTextField.text = $0.receiverDetailAddress
            }
            self.navigationController?.pushViewController(mapView, animated: true)
            
            
//            let addressSeletct = BRAddressPickerView()
//            addressSeletct.resultBlock = {province,city,area in
////                print(province?.code, city?.code!, area?.code!)
////                print(province?.name, city?.name!, area?.name!)
//                self.provinceStr = province?.name ?? ""
//                self.cityStr     = city?.name ?? ""
//                self.areaStr     = area?.name ?? ""
//
//                let result = (province?.name ?? "") + (city?.name ?? "") + (area?.name ?? "")
//                self.areaTextField.text = result
//            }
//            addressSeletct.show()
            
            return false
        }
        return true
    }
    
}

