//
//  CLOrderRefundAlertController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/31.
//

import UIKit

class CLOrderRefundAlertController: XSBaseViewController {
    
    var isHasDesLabel:Bool = false {
        didSet{
            if isHasDesLabel {
                des.isHidden = false
            }else{
                des.isHidden = true
            }
        }
    }
    
    let titleLabel = UILabel().then{
        $0.text = "确定取消退款申请吗?"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let messege = UILabel().then{
        $0.text = "取消后无法再次申请"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    
    let des = UILabel().then{
        $0.text = "确定继续退款吗?"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    
    let line1 = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let line2 = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let continueButton = UIButton().then{
        $0.setTitle("继续退款", for: .normal)
        $0.setTitleColor(.text, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.addTarget(self, action: #selector(continueAction), for: .touchUpInside)
    }
    
    let dismissButton = UIButton().then{
        $0.setTitle("暂时不退", for: .normal)
        $0.setTitleColor(.king, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    
    @objc func continueAction(){
        //发通知
    }
    @objc func dismissAction(){
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubviews(views: [titleLabel,messege,des,line1,line2,continueButton,dismissButton])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        messege.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        des.snp.makeConstraints { make in
            make.top.equalTo(messege.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        line1.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(-48)
        }
        
        line2.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalTo(1)
            make.centerX.equalToSuperview()
        }
        
        continueButton.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalTo(self.view.snp.centerX)
            make.top.equalTo(line1.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.centerX)
            make.right.equalToSuperview()
            make.top.equalTo(line1.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}
