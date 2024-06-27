//
//  XSInfoEditNickCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/2.
//

import UIKit
import QMUIKit
class XSInfoEditNickCell: XSBaseTableViewCell {

    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 16)
        lab.textColor = .text
        lab.text = "用户名："
        return lab
    }()
    
    var textF : QMUITextField={
        let textF = QMUITextField()
        textF.placeholder = "请输入昵称"
        textF.font = MYFont(size: 14)
        textF.maximumTextLength = 20
        textF.clearButtonMode = UITextField.ViewMode.always;
        return textF
    }()
    
    var lineView : UIView={
        let view = UIView()
        view.backgroundColor = .borad
        return view
    }()

    var desLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .fourText
        lab.text = "4-20字符,限中、英文数字"
        return lab
    }()

    

    override func configUI() {
        contentView.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(14)
        }
        contentView.addSubview(textF)
        textF.snp_makeConstraints { make in
            make.left.equalTo(tipLab.snp_left)
            make.right.equalTo(-16)
            make.top.equalTo(tipLab.snp_bottom).offset(14)
        }
        contentView.addSubview(lineView)
        lineView.snp_makeConstraints { make in
            make.left.equalTo(tipLab.snp_left)
            make.right.equalTo(textF.snp_right)
            make.top.equalTo(textF.snp_bottom).offset(5)
            make.height.equalTo(1)
        }
        contentView.addSubview(desLab)
        desLab.snp_makeConstraints { make in
            make.left.equalTo(tipLab.snp_left)
            make.top.equalTo(lineView.snp_bottom).offset(5)
        }
        

    }
    
}
