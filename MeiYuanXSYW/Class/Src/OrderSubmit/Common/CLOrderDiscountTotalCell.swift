//
//  CLOrderDiscountTotalCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/8.
//

import UIKit

class CLOrderDiscountTotalCell: XSBaseTableViewCell {
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.hg_setCornerOnBottomWithRadius(radius: 10)
    }
    
    let priceLabel = UILabel().then{
        $0.textColor = UIColor.qmui_color(withHexString: "#E61016")!
        $0.font = MYBlodFont(size: 16)
    }
    
    let totalLabel = UILabel().then{
        $0.text = "合计优惠:"
        $0.font = MYFont(size: 14)
        $0.textColor = .text
    }

    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [priceLabel,totalLabel])
                
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.right.equalTo(priceLabel.snp.left).offset(-2)
            make.centerY.equalTo(priceLabel.snp.centerY)
        }
    }
}
