//
//  XSEditPhoneCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/2.
//

import UIKit
import QMUIKit
class XSEditPhoneCell: XSBaseTableViewCell {

    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 16)
        lab.textColor = .text
        lab.text = "手机号"
        return lab
    }()
    
    var textF : QMUITextField={
        let textF = QMUITextField()
        textF.placeholder = "请输入手机号"
        textF.font = MYFont(size: 14)
        textF.maximumTextLength = 11
        textF.textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 4)
        return textF
    }()
    
    

    override func configUI() {
        contentView.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(14)
            make.width.equalTo(65)
            make.centerY.equalToSuperview()
        }
        contentView.addSubview(textF)
        textF.hg_setAllCornerWithCornerRadius(radius: 3)
        textF.jk.addBorder(borderWidth: 1, borderColor: .borad)
        textF.snp_makeConstraints { make in
            make.left.equalTo(tipLab.snp_right).offset(0)
            make.right.equalTo(-10)
            make.height.equalTo(35)
            make.centerY.equalToSuperview()
        }
    }
    
}
