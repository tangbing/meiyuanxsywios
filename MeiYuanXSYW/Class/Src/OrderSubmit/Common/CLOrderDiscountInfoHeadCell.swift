//
//  CLOrderDiscountInfoHeadCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/8.
//

import UIKit

class CLOrderDiscountInfoHeadCell: XSBaseTableViewCell {
        
    let baseView = UIView().then{
        $0.backgroundColor  = .white
    }

    let title = UILabel().then{
        $0.text = "优惠信息"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let underLine = UIView().then{
        $0.backgroundColor = .borad
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [title,underLine])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        underLine.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
