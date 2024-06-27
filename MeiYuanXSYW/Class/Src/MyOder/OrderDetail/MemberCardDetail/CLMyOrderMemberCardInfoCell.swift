//
//  CLMyOrderMemberCardInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit

class CLMyOrderMemberCardInfoCell: XSBaseTableViewCell {
    
    var descriptionString = """
1.红包有效期
2.限行膳有味会员使用，若会员本月服务周期失效加量包也将失效
3.限在线支付时使用
4.可升级为更高价值的商家红包
5.不限外卖/到店套餐订单业务
6.限XX账户使用
"""
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let title = UILabel().then{
        $0.text = "行善有味会员卡详情"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let label = UILabel().then{
        $0.numberOfLines = 0
    }
        
    override func configUI() {
        contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
    
        label.attributedText =         descriptionString.attributedString(font: MYFont(size: 14), textColor: .twoText, lineSpaceing:8.5, wordSpaceing: 0)
        
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [title,label])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-21.5)
            make.top.equalTo(title.snp.bottom).offset(8.5)
        }
        
        
    }
}
