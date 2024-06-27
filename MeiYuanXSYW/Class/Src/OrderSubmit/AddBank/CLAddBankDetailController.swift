//
//  CLAddBankDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/14.
//

import UIKit

class CLAddBankDetailController: XSBaseViewController {

    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let bankNumField = UITextField().then{
        $0.borderStyle = .none
        $0.keyboardType = .numberPad
        $0.placeholder = "请输入银行卡号"
        $0.font = MYFont(size: 14)
        $0.textColor = .text
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let bankNameField = UITextField().then{
        $0.borderStyle = .none
        $0.keyboardType = .numberPad
        $0.placeholder = "请选择银行"
        $0.font = MYFont(size: 14)
        $0.textColor = .text
    }
    
    let nextStep = UIButton().then{
        $0.setTitle("下一步", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
    }
    
    @objc func nextAction(){
        let vc = CLVerifyBankController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "添加银联卡"
        self.view.addSubview(baseView)
        self.view.backgroundColor = .lightBackground
        
        self.view.addSubviews(views: [bankNumField,line,bankNameField,nextStep])
        
        baseView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(104)
            make.top.equalTo(self.view.usnp.top)
        }
        
        bankNumField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(52)
            make.top.equalTo(self.view.usnp.top)
        }
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8.5)
            make.right.equalToSuperview().offset(-11.5)
            make.height.equalTo(0.5)
            make.top.equalTo(bankNumField.snp.bottom)
        }
        bankNameField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(52)
            make.top.equalTo(line.snp.bottom)
        }
        nextStep.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
