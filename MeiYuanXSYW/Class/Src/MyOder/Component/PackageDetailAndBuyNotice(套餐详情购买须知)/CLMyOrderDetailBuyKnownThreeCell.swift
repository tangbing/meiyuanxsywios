//
//  CLMyOrderDetailBuyKnownThreeCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

class CLMyOrderDetailBuyKnownThreeCell: XSBaseTableViewCell {
    
    var height = 26.5
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let dot = UIView().then{
        $0.backgroundColor = .text
        $0.layer.cornerRadius = 1.5
    }

    let label = UILabel().then{
        $0.text = "2020.8.17至2022.9.10(周末法定节假日通用)2020.8.17至2022.9.10(周末法定节假日通用)"
        $0.textColor = .text
        $0.font = MYFont(size: 12)
        $0.numberOfLines = 2
    }
    
    override func configUI() {
        contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [dot,label])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        dot.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.top.equalToSuperview().offset(11)
            make.height.width.equalTo(3)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(31.5)
            make.top.equalToSuperview().offset(3)
            make.right.equalToSuperview().offset(-23.5)
        }
    }
}
