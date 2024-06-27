//
//  CLMyOrderRefundProgressTitleCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

class CLMyOrderRefundProgressTitleCell: XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let shopName = UILabel().then{
        $0.text = "订单进度"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    override func configUI() {
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.hg_setCornerOnTopWithRadius(radius: 10)
        baseView.addSubviews(views: [shopName,line])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        shopName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(shopName.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
    }

}
