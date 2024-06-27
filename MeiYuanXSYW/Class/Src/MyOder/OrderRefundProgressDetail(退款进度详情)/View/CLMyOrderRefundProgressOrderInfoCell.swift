//
//  CLMyOrderRefundProgressOrderInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

class CLMyOrderRefundProgressOrderInfoCell: XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let title = UILabel().then{
        $0.text = "订单未消费，交易支持退款"
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
        
        orderNum.setting("退款金额","￥28.5",false)
        orderTime.setting("退款账户","原支付账号",false)
        orderDes.setting("退款单号","TKY203743778299",false)
        orderType.setting("到账时间","请联系客户退款",false)

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
