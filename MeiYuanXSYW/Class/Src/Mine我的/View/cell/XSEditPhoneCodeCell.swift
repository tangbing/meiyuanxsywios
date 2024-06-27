//
//  XSEditPhoneCodeCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/2.
//

import UIKit
import QMUIKit
class XSEditPhoneCodeCell: XSBaseTableViewCell {

   
    
    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 16)
        lab.textColor = .text
        lab.text = "短信验证码"
        return lab
    }()
    
    var codeView : UIView={
        let view = UIView()
        return view
    }()

    var textF : QMUITextField={
        let textF = QMUITextField()
        textF.placeholder = "6位数验证码"
        textF.font = MYFont(size: 13)
        textF.maximumTextLength = 6
        textF.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 4)
        return textF
    }()
    
    var codeBtn : UIButton={
        let btn = UIButton()
        btn.setTitle("获取验证码", for: UIControl.State.normal)
        btn.setTitleColor(.white, for: UIControl.State.normal)
        btn.titleLabel?.font = MYFont(size: 14)
        btn.setBackgroundImage(UIImage(named: "btnBackImg"), for: UIControl.State.normal)
        return btn
    }()
    


  

    override func configUI() {
        contentView.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(14)
            make.width.equalTo(100)

            make.centerY.equalToSuperview()
        }
        contentView.addSubview(codeView)
        codeView.hg_setAllCornerWithCornerRadius(radius: 3)
        codeView.jk.addBorder(borderWidth: 1, borderColor: .borad)
        codeView.snp_makeConstraints { make in
            make.left.equalTo(tipLab.snp_right).offset(0)
            make.right.equalTo(-10)
            make.height.equalTo(35)
            make.centerY.equalToSuperview()
        }
        
        codeView.addSubview(codeBtn)
        codeBtn.snp_makeConstraints { make in
            make.top.right.bottom.equalTo(0)
            make.width.equalTo(130)
        }

        codeView.addSubview(textF)
        textF.snp_makeConstraints { make in
            make.left.top.bottom.equalTo(0)
            make.right.equalTo(codeBtn.snp_left)
        }


    }
    
}
