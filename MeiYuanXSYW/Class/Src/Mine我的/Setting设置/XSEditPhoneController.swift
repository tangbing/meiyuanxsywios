//
//  XSEditPhoneController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
import JKSwiftExtension

class XSEditPhoneController: XSBaseTableViewController {
    typealias XSInfoEditBlock = (_ nick:String) ->Void
    var editBlock:XSInfoEditBlock?
    var codeBtn : UIButton!
    var updateMobileTextF: QMUITextField!
    var updateMobileCodeTextF: QMUITextField!

    var nick:String? = ""
    
    var countDown: Int = 60
    lazy var timer: Timer = {
        let tim = Timer.xs_scheduledTimer(timeInterval: 1.0, repeats: true) {
            self.countDown -= 1
            if self.countDown <= 0 {
                $0.invalidate()
                self.codeBtn.setTitle("获取验证码", for: UIControl.State.normal)
            }
            self.codeBtn.setTitle("获取验证码(\(self.countDown)S)", for: .normal)
        }
        RunLoop.current.add(tim, forMode: .common)
        return tim
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "修改绑定手机号"
    }
//    override func setupNavigationItems() {
//        super.setupNavigationItems()
//        title = "修改绑定手机号"
//    }
        
    override func initSubviews() {
        super.initSubviews()
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(cellType: XSEditPhoneCell.self)
        tableView.register(cellType: XSEditPhoneCodeCell.self)
        tableView.register(cellType: XSSetLogoutCell.self)
        tableView.register(cellType: XSBaseTableViewCell.self)

    }
    var dataSource = [XSSetViewModel]()
                    
    override func initData() {
        let vModel0 = XSSetViewModel()
        vModel0.style = .ViewModeStyleDefault
        vModel0.height = 52
        dataSource.append(vModel0)
        
        let vModel1 = XSSetViewModel()
        vModel1.style = .ViewModeStyleCode
        vModel1.height = 52
        dataSource.append(vModel1)

        let vModel2 = XSSetViewModel()
        vModel2.style = .ViewModeStyleLogout
        vModel2.height = 104
        dataSource.append(vModel2)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }
    
    @objc func startTimer() {
        self.codeBtn.setTitle("获取验证码(\(countDown)S)", for: .normal)
        self.timer.fire()
        sendCode()
        
    }
    
    @objc func sureUpdateMobile() {
        
        let code = self.updateMobileCodeTextF.text ?? ""
        let result = JKRegexHelper.match(code, pattern: JKRegexDigitalType.type1.rawValue)

        if !result {
            XSTipsHUD.showError("请输入正确的验证码")
            return
        }
        
        var paramers = [String : Any]()
        paramers["mobile"] = self.updateMobileTextF.text
        paramers["verificationCode"] = code

        MerchantInfoProvider.request(.updateUserMobile(params: paramers), model: XSMerchInfoHandlerModel.self) { returnData in
            if (returnData?.trueOrFalse ?? -1) == 0 {
                XSTipsHUD.showSucceed("操作成功")
                self.navigationController?.popViewController(animated: true)
            }
        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showInfo(errorMsg)
        }

    }
    
    func sendCode() {
        
        //本地校验手机号
        let mobile = self.updateMobileTextF.text ?? ""
        let result = JKRegexHelper.validateTelephoneNumber(mobile)
        if !result {
            XSTipsHUD.showError("请输入正确的手机号")
            return
        }
        
        MerchantInfoProvider.request(.sendsms(mobile: mobile), model: XSMerchInfoHandlerModel.self) { returnData in
            if (returnData?.trueOrFalse ?? -1) == 0 {
                XSTipsHUD.showSucceed("已成功发送验证码，请注意查收")
            }
        }errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showInfo(errorMsg)
        }

    }
    
}
// - 代理
extension XSEditPhoneController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.row].height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vModel = dataSource[indexPath.row]
        switch vModel.style {
        case .ViewModeStyleDefault:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSEditPhoneCell.self)
            self.updateMobileTextF = cell.textF
            return cell
        case .ViewModeStyleCode:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSEditPhoneCodeCell.self)
            self.codeBtn = cell.codeBtn
            self.updateMobileCodeTextF = cell.textF
            cell.codeBtn.addTarget(self, action: #selector(startTimer), for: .touchUpInside)
            
            return cell
        case .ViewModeStyleLogout:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSSetLogoutCell.self)
            cell.outBtn.setTitle("确定修改", for: UIControl.State.normal)
            cell.outBtn.addTarget(self, action: #selector(sureUpdateMobile), for: .touchUpInside)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let vModel = dataSource[indexPath.row]
        if vModel.style == .ViewModeStyleDefault{
            let ccell : XSBaseTableViewCell = cell as! XSBaseTableViewCell
            ccell.addLine(frame: CGRect(x: 10, y: cell.frame.height-1, width: cell.frame.width-20, height: 1), color: .borad)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vModel = dataSource[indexPath.row]
        if vModel.style == .ViewModeStyleLogout {
            let pcell : XSEditPhoneCell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! XSEditPhoneCell
            let ccell : XSEditPhoneCodeCell = tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! XSEditPhoneCodeCell
            let phone = pcell.textF.text ?? ""
            let code = ccell.textF.text ?? ""

            if phone.jk.isValidNickName{
                editBlock?(phone)
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
}

