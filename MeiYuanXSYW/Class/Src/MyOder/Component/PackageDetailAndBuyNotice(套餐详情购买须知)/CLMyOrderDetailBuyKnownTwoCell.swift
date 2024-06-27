//
//  CLMyOrderDetailBuyKnownTwoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

class CLMyOrderDetailBuyKnownTwoCell: XSBaseTableViewCell {
    
    var height = 26.5
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }

    let label = UILabel().then{
        $0.text = "2020.8.17至2022.9.10(周末法定节假日通用)"
        $0.textColor = .text
        $0.font = MYFont(size: 12)
    }
    
    override func configUI() {
        contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [label])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(36.5)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(4)
        }
        
    }
}
