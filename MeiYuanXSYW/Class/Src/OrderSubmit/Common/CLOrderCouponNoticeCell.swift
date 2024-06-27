//
//  CLOrderCouponNoticeCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/8.
//

import UIKit

class CLOrderCouponNoticeCell: XSBaseTableViewCell {

    var height = 26
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    let title = UILabel().then{
        $0.text = "满减优惠与折扣商品不能共享"
        $0.textColor = .king
        $0.font = MYFont(size: 14)
    }
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubview(title)
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
}
