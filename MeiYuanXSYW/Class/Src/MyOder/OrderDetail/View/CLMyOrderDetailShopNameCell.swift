//
//  CLMyOrderDetailShopNameCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/24.
//

import UIKit
import Kingfisher

class CLMyOrderDetailShopNameCell: XSBaseTableViewCell {

    let shopName = UILabel().then{
        $0.text = "AAA商(商家名称)"
        $0.textColor = UIColor.text
        $0.font = MYBlodFont(size: 16)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    override func configUI() {
        
        self.contentView.addSubviews(views: [shopName,line])
        
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
