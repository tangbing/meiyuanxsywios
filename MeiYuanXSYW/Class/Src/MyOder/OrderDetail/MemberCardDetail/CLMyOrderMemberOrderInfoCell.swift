//
//  CLMyOrderMemberOrderInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit

class CLMyOrderMemberOrderInfoCell: XSBaseTableViewCell {
    
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
    let orderDes  = CLMyOrderDetailReuseView()
    let orderType = CLMyOrderDetailReuseView()


    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.contentView.addSubview(baseView)
        baseView.addSubviews(views: [title,orderNum,orderTime,orderDes,orderType])
        
        orderNum.setting("订单号","WM2021003150001",false)
        orderTime.setting("下单时间","2010-03-15 16:33:33",false)
        orderDes.setting("支付时间","2010-03-15 16:33:33",false)
        orderType.setting("支付方式","微信支付",false)

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
        orderDes.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(orderTime.snp.bottom)
            make.height.equalTo(44)
        }
        orderType.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(orderDes.snp.bottom)
            make.height.equalTo(44)
        }
        
    }

}
