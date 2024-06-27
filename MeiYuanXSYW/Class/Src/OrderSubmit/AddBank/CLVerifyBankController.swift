//
//  CLVerifyBankController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/14.
//

import UIKit

class CLVerifyBankController: XSBaseViewController {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let bankNumLabel = UILabel().then{
        $0.font = MYFont(size: 14)
        $0.textColor = .text
        $0.text = "6236723728232392"
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let bankNameLabel = UILabel().then{
        $0.font = MYFont(size: 14)
        $0.textColor = .text
        $0.text = "招商银行"
    }
    
    let phoneBaseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let phoneField = UITextField().then{
        $0.placeholder = "请输入银行预留手机号"
        $0.font = MYFont(size: 14)
        $0.textColor = .text
    }
    
    let agreeButton = UIButton().then{
        $0.setImage(UIImage(named: "payAddress_selector_unchecked"), for: .normal)
        $0.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    var isAgree:Bool = false {
        didSet{
            if self.isAgree == true {
                agreeButton.setImage(UIImage(named: "payAddress_selector_selected"), for: .normal)
            }else{
                agreeButton.setImage(UIImage(named: "payAddress_selector_unchecked"), for: .normal)
            }
        }
    }
    
    let agreeLabel = UILabel().then{
        $0.text = "我已阅读并同意"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let agreeAccess = UIButton().then{
        $0.setTitle("《用户协议》", for: .normal)
        $0.setTitleColor(.king, for: .normal)
        $0.titleLabel?.font = MYFont(size: 12)
        $0.addTarget(self, action: #selector(enterAgreement), for: .touchUpInside)
    }
    
    let nextStep = UIButton().then{
        $0.setTitle("同意协议并验证", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    @objc func nextAction(){
        let vc = CLInputVerifyCodeController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func click(){
        self.isAgree = !self.isAgree
    }
    @objc func enterAgreement(){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "添加银联卡"
        self.view.addSubview(baseView)
        self.view.backgroundColor = .lightBackground
        
        self.view.addSubviews(views: [bankNumLabel,line,bankNameLabel,phoneBaseView,phoneField,agreeButton,agreeLabel,agreeAccess,nextStep])
        
        baseView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(104)
            make.top.equalTo(self.view.usnp.top)
        }
        
        bankNumLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(52)
            make.top.equalTo(self.view.usnp.top)
        }
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8.5)
            make.right.equalToSuperview().offset(-11.5)
            make.height.equalTo(0.5)
            make.top.equalTo(bankNumLabel.snp.bottom)
        }
        bankNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(52)
            make.top.equalTo(line.snp.bottom)
        }
        
        phoneBaseView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(baseView.snp.bottom).offset(10)
            make.height.equalTo(52)
        }
        
        phoneField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13.5)
            make.centerY.equalTo(phoneBaseView.snp.centerY)
            make.right.equalToSuperview().offset(-12)
        }
        
        agreeButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(13.5)
            make.top.equalTo(phoneBaseView.snp.bottom).offset(10)
            make.height.width.equalTo(14)
        }
        agreeLabel.snp.makeConstraints { make in
            make.left.equalTo(agreeButton.snp.right).offset(5)
            make.centerY.equalTo(agreeButton.snp.centerY)
        }
        agreeAccess.snp.makeConstraints { make in
            make.left.equalTo(agreeLabel.snp.right)
            make.centerY.equalTo(agreeButton.snp.centerY)
        }
        
        nextStep.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
