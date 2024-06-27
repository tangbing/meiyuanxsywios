//
//  CLDeliverRefundReasonRejectCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/3.
//

import UIKit

class CLDeliverRefundReasonRejectCell: XSBaseTableViewCell {
    let title = UILabel().then{
        $0.text = "驳回原因"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }

    let reasonLabel = UILabel().then{
        $0.text  = "原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因原因"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
        $0.numberOfLines = 4
    }
    
    override func configUI(){
        contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        
        contentView.addSubviews(views: [title,baseView])
        baseView.addSubview(reasonLabel)
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
        }
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(title.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(105)
        }
        
        reasonLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-21)
            make.top.equalToSuperview().offset(15)
        }
    }
    
}
