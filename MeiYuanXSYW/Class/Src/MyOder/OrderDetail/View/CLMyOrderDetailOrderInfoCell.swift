//
//  CLMyOrderDetailOrderInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/24.
//

import UIKit
import Kingfisher

class CLMyOrderDetailOrderInfoCell: XSBaseTableViewCell {
    
    var model:CLMyOrderListModel?{
        didSet{
            guard let cellModel = model else { return }
            orderNum.setting("订单号",cellModel.orderSn,false)
            orderTime.setting("下单时间",cellModel.orderTime,false)
            orderDes.setting("订单备注",cellModel.remark,false)
        }
    }
    
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

    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.contentView.addSubview(baseView)
        baseView.addSubviews(views: [title,orderNum,orderTime,orderDes])
        
        orderNum.setting("订单号","MFHSD23232842892",false)
        orderTime.setting("下单时间","2021-12-25 12:12:23",false)
        orderDes.setting("订单备注","不要辣",false)
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(181)
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
        
    }

}
