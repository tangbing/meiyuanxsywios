//
//  CLMyOrderDetailDiscountTitleCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/14.
//

import UIKit

class CLMyOrderDetailDiscountTitleCell:XSBaseTableViewCell {
    

    let discountTitle = UILabel().then{
        $0.text = "优惠信息"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let totalDiscountLabel = UILabel().then{
        $0.text = "多件折扣"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let questionButton = UIButton().then{
        $0.setImage(UIImage(named: "icon_question"), for: .normal)
    }
    
    let totalDiscount = UILabel().then{
        $0.text = "-￥27.5"
        $0.textColor = .twoText
        $0.font = MYFont(size: 16)
    }
    
    override func configUI() {
        
        self.contentView.addSubviews(views: [discountTitle,line,totalDiscountLabel,totalDiscount,questionButton])
        
        discountTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(discountTitle.snp.bottom).offset(15)
            make.height.equalTo(0.5)
        }
        
        totalDiscountLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(line.snp.bottom).offset(15)
        }
        questionButton.snp.makeConstraints { make in
            make.left.equalTo(totalDiscountLabel.snp.right).offset(4)
            make.centerY.equalTo(totalDiscountLabel.snp.centerY)
            make.width.height.equalTo(16)
        }
        totalDiscount.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(totalDiscountLabel)
        }
        
    }
}
