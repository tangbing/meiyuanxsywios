//
//  CLMyOrderDetailCouponCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/25.
//

import UIKit

class CLMyOrderDetailCouponCell: XSBaseTableViewCell {
        
    let image = UIImageView().then{
        $0.image = UIImage(named: "coupon")
    }
    let title = UILabel().then{
        $0.text = "商品劵"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    let info = UILabel().then{
        $0.text = "满100减5"
        $0.textColor = .fourText
        $0.font = MYFont(size: 14)
    }
    let price = UILabel().then{
        $0.text = "-￥5.0"
        $0.textColor = .twoText
        $0.font = MYFont(size: 16)
    }
    override func configUI() {
        self.contentView.addSubviews(views: [image,title,info,price])
        
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
        
        title.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(7)
            make.centerY.equalTo(image.snp.centerY)
        }
        
        info.snp.makeConstraints { make in
            make.left.equalTo(title.snp.right).offset(10)
            make.centerY.equalTo(image.snp.centerY)
        }
        
        price.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(image.snp.centerY)
        }
        
    }

}
