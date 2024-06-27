//
//  CLMyOrderDetailShopName2Cell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/2.
//

import UIKit

class CLMyOrderDetailShopName2Cell:  XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.hg_setCornerOnTopWithRadius(radius: 10)
    }
    
    let shopName = UILabel().then{
        $0.text = "AAA商(商家名称)"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [shopName,line])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        shopName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-1)
            make.height.equalTo(0.5)
        }
        
    }

}
