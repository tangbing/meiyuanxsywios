//
//  XSLoginCodeController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/17.
//

import UIKit
import QMUIKit
import JKSwiftExtension
import SVProgressHUD
class XSLoginCodeController: XSBaseViewController {
    
    var phone = String()
    
    
    @IBOutlet weak var backBtnTopConst: NSLayoutConstraint!
    @IBOutlet weak var tipLab: UILabel!
    @IBOutlet weak var desLab: UILabel!
    
    @IBOutlet weak var contView: UIView!
    @IBOutlet weak var contBackView: UIView!
    
    @IBOutlet weak var codeTipLab: UILabel!
    @IBOutlet weak var phoneLab: UILabel!
    
    
    @IBOutlet weak var numView: UIView!

    @IBOutlet weak var timeBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
        
    lazy var codeView: TDWVerifyCodeView = {
        let codeView = TDWVerifyCodeView.init(inputTextNum: 6)
        self.view.addSubview(codeView)
        return codeView
    }()

    override func initSubviews() {
        backBtnTopConst.constant = 44
        tipLab.textColor = UIColor.text
        tipLab.font = MYBlodFont(size: 21)
        desLab.textColor = UIColor.twoText
        desLab.font = UIFont.myFont28
        
        codeTipLab.textColor = UIColor.text
        phoneLab.textColor = UIColor.twoText
        
        phoneLab.text = "验证码已发送至:".appending( phone.jk
                                                            .hidePhone(combine: "****"))
        
        timeBtn.setTitleColor(UIColor.king, for: UIControl.State.normal)
        timeBtn.setTitle("60s", for: UIControl.State.normal)
        timeBtn.countDown(60, timering: { (number) in
            //print("\(number)")
        }, complete: {
           // print("完成")
        }, timeringPrefix: "", completeText: "重新获取")
        timeBtn.add(self, action: #selector(reGetCode))
        
        
        contView.backgroundColor = UIColor.clear
        contView.addShadow(shadowColor: UIColor.borad, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 1,shadowRadius: 5)
        contBackView.hg_setCornerOnTopWithRadius(radius: 10)
        

        numView.addSubview(codeView)
        codeView.textFiled.becomeFirstResponder()
        // 监听验证码输入完成
        codeView.inputFinish = { str in
            // 要做的事情
            self.login(code: str)
        }
        
        loginSendSms()
        
    }
    
    private func loginSendSms() {
        MerchantInfoProvider.request(.sendsms(mobile: phone), model: XSMerchInfoHandlerModel.self) { returnData in
            if (returnData?.trueOrFalse ?? -1) == 0 {
                XSTipsHUD.showSucceed("已成功发送验证码，请注意查收")
            }
        }errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showInfo(errorMsg)
        }
    }
    
    private func login(code: String) {
        
        var params = [String : Any]()
        params["authCode"] = code
        params["clientChannel"] = 0
        params["mobile"] = phone
        
        MerchantInfoProvider.request(.loginAuthCode(params: params), model: XSMineHomeUserInfoModel.self) { returnData in
            
            uLog(returnData)
            if let userInfo = returnData {
                
                XSMineHomeUserInfoModel.saveAccountData(userInfoModel: userInfo) {

                    self.navigationController?.popToRootViewController(animated: true)

//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                        uLog("post........")
//                        NotificationCenter.default.post(name: NSNotification.Name.XSLoginEndNotification, object: self, userInfo:nil)
//                        self.dismiss(animated: true, completion: nil)
//
//                    }


                }
                
            }
            
        }  errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }
        
    }
    
    
    ///重新获取验证码
    @objc func reGetCode(sender:UIButton) {
        if sender.isTiming {
            return
        }
        timeBtn.countDown(60, timering: { (number) in
            print("\(number)")
        }, complete: {
            print("完成")
        }, timeringPrefix: "", completeText: "重新获取")

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        codeView.snp_makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
    
    @IBAction func clickBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func clickGetCodeAction(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
