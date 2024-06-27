//
//  CLOrderTotalPriceCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/8.
//

import UIKit

class CLOrderTotalPriceCell: XSBaseTableViewCell {
    
    var height = 37
    
    let baseView  = UIView().then{
        $0.backgroundColor = .white
    }
    
    let totalPrice = UILabel().then{
        $0.textColor = UIColor.qmui_color(withHexString: "#E61016")
        $0.font = MYBlodFont(size: 16)
    }
    
    let totalPriceLabel  = UILabel().then{
        $0.text = "金额小计:"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    let num = UILabel().then{
        $0.text = "共2件"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        baseView.addSubviews(views: [totalPrice,totalPriceLabel,num])
        
        totalPrice.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        totalPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(totalPrice.snp.left).offset(-2)
            make.centerY.equalTo(totalPrice.snp.centerY)
        }
        num.snp.makeConstraints { make in
            make.right.equalTo(totalPriceLabel.snp.left).offset(-10)
            make.centerY.equalTo(totalPriceLabel.snp.centerY)
        }
    }
}
