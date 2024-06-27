//
//  CLGroupBuyWaitPayOrderInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/6.
//

import UIKit

class CLGroupBuyWaitPayOrderInfoCell:  XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let title = UILabel().then{
        $0.text = "订单信息"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let orderNum  = CLMyOrderDetailReuseView()
    let orderTime = CLMyOrderDetailReuseView()

    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.contentView.addSubview(baseView)
        baseView.addSubviews(views: [title,orderNum,orderTime])
        
        orderNum.setting("订单号","WM2021003150001",false)
        orderTime.setting("下单时间","2010-03-15 16:33:33",false)

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
        orderNum.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(title.snp.bottom).offset(15)
            make.height.equalTo(44)
        }
        orderTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(orderNum.snp.bottom)
            make.height.equalTo(44)
        }
    }

}
