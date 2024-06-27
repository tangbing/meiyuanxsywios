//
//  CLInputVerifyCodeController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/14.
//

import UIKit

class CLInputVerifyCodeController: XSBaseViewController {
    
    let notice = UILabel().then{
        $0.text = "请输入六位验证码"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 18)
    }
    
    let des = UILabel().then{
        $0.text = "验证码已发送至:".appending( "17603078066".jk.hidePhone(combine: "****"))
        $0.textColor = .twoText
        $0.font = MYFont(size: 18)
    }
    
    let codeView = TDWVerifyCodeView.init(inputTextNum: 6)
    
    let nextStep = UIButton().then{
        $0.setTitle("添加并确认支付", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    let reSendButton = UIButton().then{
        $0.setTitle("重新获取", for: .normal)
        $0.setTitleColor(.king, for: .normal)
        $0.titleLabel?.font = MYFont(size:  14)
    }
    
    @objc func nextAction(){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationTitle = "请输入验证码"
        self.view.addSubviews(views: [notice,des,codeView,reSendButton,nextStep])
        
        codeView.becomeFirstResponder()
        codeView.inputFinish = { str in
            // 要做的事情
        }
        
        notice.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(30)
        }
        
        des.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(notice.snp.bottom).offset(10)
        }
        
        codeView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(des.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        reSendButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(codeView.snp.bottom).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        
        nextStep.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
