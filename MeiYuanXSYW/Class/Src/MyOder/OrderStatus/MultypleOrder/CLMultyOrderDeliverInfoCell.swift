//
//  CLMultyOrderDeliverInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/17.
//

import UIKit

class CLMultyOrderDeliverInfoCell:XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let title = UILabel().then{
        $0.text = "配送信息"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let deliverType   = CLMyOrderDetailReuseView()
    let deliverTime   = CLMyOrderDetailReuseView()
    let deliverInfo   = CLMyOrderDetailDeliverInfoView()

    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.contentView.addSubview(baseView)
        baseView.addSubviews(views: [title,deliverType,deliverTime,deliverInfo])
        
        deliverType.setting("配送方式", "骑手配送", false)
        deliverTime.setting("预计送达时间", "2020-04-10 12:22:22", true)
        deliverInfo.setting("收货信息", "小黑", "17729378922", "深圳市罗湖区城市天地广场",true)

        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(18)
        }
        
        deliverType.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(title.snp.bottom).offset(15)
            make.height.equalTo(34)
        }
        
        deliverTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(deliverType.snp.bottom)
            make.height.equalTo(34)
        }
        deliverInfo.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(deliverTime.snp.bottom)
            make.height.equalTo(62)
        }
        
    }
}
