//
//  XSLoginController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/17.
//

import UIKit
import QMUIKit
import JKSwiftExtension
import SVProgressHUD


class XSLoginController: XSBaseViewController, QMUITextFieldDelegate {
    
    @IBOutlet weak var backBtnTopConst: NSLayoutConstraint!
    @IBOutlet weak var tipLab: UILabel!
    @IBOutlet weak var desLab: UILabel!
    
    @IBOutlet weak var contView: UIView!
    @IBOutlet weak var contBackView: UIView!
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginBackView: UIView!
    
    @IBOutlet weak var numBtn: QMUIButton!
    
    @IBOutlet weak var numLineView: UIView!
    @IBOutlet weak var textField: QMUITextField!
    @IBOutlet weak var phoneFormatErrorLab: UILabel!
    
    @IBOutlet weak var checkBtn: UIButton!
    
    @IBOutlet weak var checkLab: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    lazy var popupByAddSubview : QMUIPopupContainerView = {
        // 使用方法 1，以 addSubview: 的形式显示到界面上
        let subview = QMUIPopupContainerView()
        subview.textLabel.text = "请先阅读并同意协议书";
        subview.textLabel.textColor = UIColor.white;
        subview.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.7)
        subview.sourceView = checkBtn;// 相对于 button1 布局
        // 使用方法 1 时，显示浮层前需要先手动隐藏浮层，并自行添加到目标 UIView 上
        subview.isHidden = false;
        view.addSubview(subview);
        return subview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    
    override func initSubviews() {
        backBtnTopConst.constant = 44
        tipLab.textColor = UIColor.text
        tipLab.font = MYBlodFont(size: 21)
        desLab.textColor = UIColor.twoText
        desLab.font = UIFont.myFont28
        
        contView.backgroundColor = UIColor.clear
        contView.addShadow(shadowColor: UIColor.borad, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 1,shadowRadius: 5)
        contBackView.hg_setCornerOnTopWithRadius(radius: 10)

        loginView.backgroundColor = UIColor.clear
        loginView.addShadow(shadowColor: UIColor.borad, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 1,shadowRadius: 5)
        loginBackView.hg_setAllCornerWithCornerRadius(radius: 6)

        
        numBtn.setTitleColor(UIColor.twoText, for: UIControl.State.normal)
        numBtn.imagePosition = QMUIButtonImagePosition.right;
        numBtn.spacingBetweenImageAndTitle = 6
        numLineView.backgroundColor = UIColor.twoText
        
        textField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledTextDidChange(noti:)), name: UITextField.textDidChangeNotification, object: textField)

        
        phoneFormatErrorLab.isHidden = true;
        phoneFormatErrorLab.textColor = UIColor.error
        
        nextBtn.hg_setAllCornerWithCornerRadius(radius: 22)
        nextBtn.setBackgroundImage(UIColor.borad.image(), for: UIControl.State.disabled)
        nextBtn.isEnabled = false
        nextBtn.setBackgroundImage(UIImage(named: "btnBackImg"), for: UIControl.State.normal)
        
        checkLab.jk.setSpecificTextColor("《隐私政策》", color: .king)
        checkLab.jk.setSpecificTextColor("《注册协议》", color: .king)

        clickCheckBoxAction(checkBtn)
        
    }
    @objc func textFiledTextDidChange(noti:Notification) {
        let textField = noti.object as! QMUITextField
        if textField.text?.count != 11 {
            nextBtn.isEnabled = false
        }
        else{
            nextBtn.isEnabled = true
        }
        if textField.text?.count ?? 0 > 11 {
            textField.text = textField.text?.jk.sub(to: 11)
        }
    }

    
    
    @IBAction func clickBackAction(_ sender: UIButton) {
//        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func clickCheckBoxAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            self.popupByAddSubview.hideWith(animated: true)
        }
    }
    @IBAction func clickProtocolAction(_ sender: UIButton) {
        if sender.tag == 100 {
            print("点击隐私政策")
        }
        else{
            print("点击注册协议")
        }
    }
    

    @IBAction func clickNextAction(_ sender: UIButton) {
        //勾选协议
        if !checkBtn.isSelected {
            popupByAddSubview.showWith(animated: true)
            DispatchQueue.main.after(5, execute: {
                self.popupByAddSubview.hideWith(animated: true)
            })
            return
        }
        //本地校验手机号
        let result = JKRegexHelper.validateTelephoneNumber(textField.text ?? "")
        if !result {
            SVProgressHUD.showInfo(withStatus: "请输入正确的手机号")
            SVProgressHUD.dismiss(withDelay: 1.5)
            return
        }

        
        let logingCode = XSLoginCodeController()
        logingCode.phone = textField.text ?? String()
        navigationController?.pushViewController(logingCode, animated: true)
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

