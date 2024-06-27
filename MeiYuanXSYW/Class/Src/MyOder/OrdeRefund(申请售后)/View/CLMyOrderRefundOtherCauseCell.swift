//
//  CLMyOrderRefundOtherCauseCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit
import Kingfisher
import QMUIKit

class CLMyOrderRefundOtherCauseCell: XSBaseTableViewCell {

    let title = UILabel().then{
        $0.text = "其它补充"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }

    let reasonTextView = QMUITextView()
    
    let desLabel = UILabel().then{
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
        $0.text = "0/140"
    }
    
    override func configUI() {
        self.selectionStyle = .none
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(title)
        contentView.addSubview(baseView)
        baseView.addSubview(reasonTextView)
        baseView.addSubview(desLabel)
        
        reasonTextView.setValue(140, forKeyPath: "maximumTextLength")
        reasonTextView.setValue(UIColor.twoText, forKeyPath: "placeholderColor")
        reasonTextView.setValue("其他补充说明(140字以内)", forKeyPath: "placeholder")
        reasonTextView.setValue(MYFont(size: 14), forKeyPath: "font")

        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(15)
        }
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(title.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
        reasonTextView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        desLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
}
