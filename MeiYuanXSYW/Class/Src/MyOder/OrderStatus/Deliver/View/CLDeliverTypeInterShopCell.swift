//
//  CLDeliverInterShopCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/3.
//

import UIKit

class CLDeliverTypeInterShopCell:  XSBaseTableViewCell {
    
    var model:CLMyOrderListModel?{
        didSet{
            guard let cellModel = model else { return }
            deliverType.setting("配送方式", "到点自取", false)
            deliverTime.setting("取餐时间", "2020-04-10 12:22:22", false)
            deliverAddr.setting("自取地址", "深圳市罗湖区城市天地广场", false)
        }
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let title = UILabel().then{
        $0.text = "配送信息"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let deliverType   = CLMyOrderDetailReuseView()
    let deliverTime   = CLMyOrderDetailReuseView()
    let deliverAddr  = CLMyOrderDetailReuseView()

    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.contentView.addSubview(baseView)
        baseView.addSubviews(views: [title,deliverType,deliverTime,deliverAddr])
        
        deliverType.setting("配送方式", "到点自取", false)
        deliverTime.setting("取餐时间", "2020-04-10 12:22:22", false)
        deliverAddr.setting("自取地址", "深圳市罗湖区城市天地广场", false)

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
        
        deliverType.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(title.snp.bottom).offset(15)
            make.height.equalTo(44)
        }
        
        deliverTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(deliverType.snp.bottom)
            make.height.equalTo(44)
        }

        deliverAddr.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(deliverTime.snp.bottom)
            make.height.equalTo(44)
        }
        
    }
}
