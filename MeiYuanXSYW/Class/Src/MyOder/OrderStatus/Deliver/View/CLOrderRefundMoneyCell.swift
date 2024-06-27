//
//  CLOrderRefundMoneyCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/29.
//

import UIKit

class CLOrderRefundMoneyCell: XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.hg_setAllCornerWithCornerRadius(radius: 10)
    }
    
    let preLabel = UILabel().then{
        $0.text = "退款金额"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let moneylabel = UILabel().then{
        $0.text = "￥0.0"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .lightBackground
        
        self.contentView.addSubview(baseView)
        baseView.addSubviews(views: [preLabel,moneylabel])
        
        baseView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
        preLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12.5)
            make.centerY.equalToSuperview()
        }
        
        moneylabel.snp.makeConstraints { make in
            make.left.equalTo(preLabel.snp.right).offset(2)
            make.centerY.equalToSuperview()
        }
    }
}
