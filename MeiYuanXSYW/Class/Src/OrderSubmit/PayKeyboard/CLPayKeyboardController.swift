//
//  CLPayKeyboardController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/11.
//

import UIKit
import QMUIKit

class CLPayTextFieldView : TBBaseView{
    
    var finishBlock:((_ pwd:String)->())?
    
    let textField = UITextField().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 4
        $0.layer.borderColor = UIColor.fourText.cgColor
        $0.layer.borderWidth = 0.5
        $0.isUserInteractionEnabled = false
        $0.textColor = .clear
    }
    
    var dotArr:[UIView] = []
    
    func textFieldChanged(_ newValue:String){
        self.textField.text = newValue
        self.textFieldDidChange(textField)
    }
    
    func textFieldDidChange(_ textField:UITextField){
        for dotView in dotArr {
            dotView.isHidden = true
        }

        for i in 0 ..< textField.text!.count {
            dotArr[i].isHidden = false
        }
        
        if textField.text!.count == 6 {
            guard let action = finishBlock else {return}
            action(textField.text!)
        }
    }
    
    override func configUI() {
        let width:CGFloat = (screenWidth - 80)/6;
        
        self.addSubview(textField)
        textField.delegate = self
        textField.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        for i in 0 ..< 5 {
            
            let line = UIView().then{
                $0.backgroundColor = .fourText
            }
            self.addSubview(line)
            line.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(0.5)
                make.left.equalToSuperview().offset(CGFloat(i + 1) * width)
            }
        }
        for i in 0 ..< 6 {
            let dot = UIView().then{
                $0.backgroundColor = .text
                $0.hg_setAllCornerWithCornerRadius(radius: 5)
                $0.isHidden = true
            }
            self.addSubview(dot)
            dot.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset((width - 10.0)/2 + width * CGFloat(i))
                make.width.height.equalTo(10)
            }
            dotArr.append(dot)
        }
        
    }
}
extension CLPayTextFieldView : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
            return false
        } else if string.count == 0 {
            return true
        } else if textField.text!.count >= 6 {
            return false
        } else {
            return true
        }
    }
}


class CLKeyboardView : TBBaseView{
    
    var numberClick:((_ sender:UIButton)->())?
    
    let row = 4
    let colum = 3
    let rowSpace:CGFloat = 6
    let columSpace:CGFloat = 6

   @objc func click(_ sender:UIButton){
        guard let action = numberClick else {return}
        action(sender)
    }
    
    override func configUI() {
        self.backgroundColor = .lightBackground
        let width:CGFloat =  (screenWidth - 4 * rowSpace)/3
        let height:CGFloat = 47
        
        for i in 0 ..< 4 {
            for j in 0 ..< 3{
                let button = UIButton()
                self.addSubview(button)
                button.tag = i * 3 + j
                button.backgroundColor = .white
                button.hg_setAllCornerWithCornerRadius(radius: 4)
                button.titleLabel?.font = MYBlodFont(size: 24)
                button.setTitleColor(.text, for: .normal)
                button.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
                button.snp.makeConstraints { make in
                    make.left.equalToSuperview().offset(rowSpace + (width + rowSpace) * CGFloat(j))
                    make.top.equalToSuperview().offset(columSpace + (height + columSpace) * CGFloat(i))
                    make.width.equalTo(width)
                    make.height.equalTo(height)
                }
                
                if  button.tag == 9 {
                    
                }else if button.tag == 10 {
                    button.setTitle("0", for: .normal)
                }else if button.tag == 11{
                    button.setImage(UIImage(named: "we-icon-keyboard-delete"), for: .normal)
                }else{
                    button.setTitle(String(button.tag + 1), for: .normal)
                }
            }
        }
    }
}

class CLPayKeyboardController: XSBaseViewController {

    
    let keyboardView = CLKeyboardView()
    
    let payField = CLPayTextFieldView()
    
    let closeButton = UIButton().then{
        $0.setImage(UIImage(named: "merchinfo_ticket_closure"), for: .normal)
    }
    
    let titleLabel = UILabel().then{
        $0.text = "请输入支付密码"
        $0.textColor = .text
        $0.font = MYFont(size: 16)
    }
    
    let moneyPre = UILabel().then{
        $0.text = "￥"
        $0.textColor = .priceText
        $0.font = MYFont(size: 16)
    }
    
    let money = UILabel().then{
//        $0.text = "￥23.5"
        $0.textColor = .priceText
        let attributedString = NSMutableAttributedString(string: "￥23.5")
        attributedString.addAttribute(NSAttributedString.Key.font, value: MYFont(size: 16), range: NSMakeRange(0, 0))
        attributedString.addAttribute(NSAttributedString.Key.font, value: MYFont(size: 30), range: NSMakeRange(1, attributedString.length - 1))

        let style = NSMutableParagraphStyle()
        style.paragraphSpacing = -2
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle : style], range: NSMakeRange(0, attributedString.length))
        $0.attributedText = attributedString
    }
    
    let line = UIView().then{
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#DCDEE0")
    }
    
    let payTypeLabel = UILabel().then{
        $0.text = "支付方式"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let control = UIControl().then{
        $0.addTarget(self, action: #selector(selectPayType), for: .touchUpInside)
    }
    
    let payType = UILabel().then{
        $0.text = "零钱"
        $0.textColor = .text
        $0.font = MYFont(size: 12)
    }
    
    let accessImage = UIImageView().then{
        $0.image = UIImage(named: "mine_arrow")
        $0.contentMode = .scaleToFill
    }
    
    @objc func selectPayType(){
        uLog("选择支付方式")
    }
    
    func itemAction(_ sender: UIButton) {
        var oldStr:String = payField.textField.text!
        var newStr:String = ""
        if sender.tag == 11 {
            //删除
            if oldStr.count > 1 {
                newStr =  oldStr.substring(to: oldStr.index(oldStr.startIndex, offsetBy: oldStr.count - 1))
            }
        }else if sender.tag == 9{
            self.dismiss(animated: true, completion: nil)
        }else{
            
            oldStr.append(sender.currentTitle!)
            newStr = oldStr
        }
        
        self.payField.textFieldChanged(newStr)
    }
    
    func updateMoneyStyle(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubviews(views: [closeButton,titleLabel,moneyPre,money,line,payTypeLabel,control])
        
        control.addSubviews(views: [payType,accessImage])
        
        self.view.addSubview(keyboardView)
        self.view.addSubview(payField)
        keyboardView.numberClick = {[unowned self] sender in
            self.itemAction(sender)
        }
        payField.finishBlock = {[unowned self] pwd in
            uLog("输入的密码是\(pwd)")
                //发通知
            if pwd == "111111"{
                let NotifMycation = NSNotification.Name(rawValue:"submit")
                NotificationCenter.default.post(name: NotifMycation, object: pwd)
                self.dismiss(animated: true, completion: nil)

            }else{
                self.payField.textFieldChanged("") //清空

                self.showCustomAlert(title: "", message: "支付密码不正确", actionTitle1: "忘记密码", actionTitle2: "重新输入", alertType: .alert, sureBlock: nil) {
                    uLog("忘记密码")
                }
            }
        }
        
        closeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(closeButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        money.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.centerX.equalToSuperview()
        }
        
//        moneyPre.snp.makeConstraints { make in
//            make.right.equalTo(money.snp.left)
//            make.bottom.equalTo(money.snp.bottom)
//        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(0.5)
            make.top.equalTo(money.snp.bottom).offset(10)
        }
        
        payTypeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25)
            make.top.equalTo(line.snp.bottom).offset(10)
        }
        
        control.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(payTypeLabel.snp.centerY)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        accessImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
        payType.snp.makeConstraints { make in
            make.right.equalTo(accessImage.snp.left)
            make.centerY.equalToSuperview()
        }
        
        keyboardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(216)
        }
        
        payField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(44)
            make.bottom.equalTo(keyboardView.snp.top).offset(-30)
        }
        
    }
}
extension UIViewController {
    
    func showCustomAlert(title: String?, message: String? = nil, actionTitle1:String,actionTitle2:String,alertType: AlertType, sureBlock: (() -> Void)?,cancelBlock: (() -> Void)? ) {
      
        let alert = TbAlertController(textTitle: title ?? "", message: message ?? "", preferredStyle: .preferredStyleAlert)
        alert.titleColor = UIColor.hex(hexString: "#060607")
        alert.titleFont = .systemFont(ofSize: 16, weight: .semibold)
        alert.separatorlLneColor = UIColor.hex(hexString: "#D8D8D8")
        alert.contentWidth = FMScreenScaleFrom(311)
        alert.contentViewRadius = 10
        

        let alertAction = TbAlertAction(textTitle: actionTitle2, alertActionStyle: .TbAlertActionStyleDefault) { action in
            guard let sureBlock = sureBlock else { return }
            sureBlock()
        }
        alertAction.setTitleColor(titleColor: UIColor.king, forState: .normal)

        
        let cancelAction = TbAlertAction(textTitle: actionTitle1, alertActionStyle: .TbAlertActionStyleCancel) { action in
            guard let cancelBlock = cancelBlock else { return }
            cancelBlock()
        }
        cancelAction.setTitleColor(titleColor: UIColor.hex(hexString: "#262626"), forState: .normal)

        alert.addAction(action: cancelAction)
        alert.addAction(action: alertAction)

        self.present(alert, animated: true, completion: nil)
    }
    
}
