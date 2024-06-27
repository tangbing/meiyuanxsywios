//
//  CLMyOrderDetailAddressInfo.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/24.
//

import UIKit

class CLDeliverTypeDeliverCell: XSBaseTableViewCell {
    

    var model:CLMyOrderListModel?{
        didSet{
            guard let cellModel = model else { return }
            deliverType.setting("配送方式", cellModel.distributionWay == "0" ? "商家配送":"骑手配送", false)
            deliverTime.setting("送达时间", cellModel.arriveTime, false)
            deliverInfo.setting("收货信息", cellModel.receiverName, cellModel.receiverPhone, cellModel.receiverDetailAddress)
            deliverRider.setting("配送骑手", cellModel.riderName, false)
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
    let deliverInfo   = CLMyOrderDetailDeliverInfoView()
    let deliverRider  = CLMyOrderDetailReuseView()

    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.contentView.addSubview(baseView)
        baseView.addSubviews(views: [title,deliverType,deliverTime,deliverInfo,deliverRider])
        
        deliverType.setting("配送方式", "骑手配送", false)
        deliverTime.setting("送达时间", "2020-04-10 12:22:22", false)
        deliverInfo.setting("收货信息", "小黑", "17729378922", "深圳市罗湖区城市天地广场")
        deliverRider.setting("配送骑手", "小黑", false)

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
        deliverInfo.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(deliverTime.snp.bottom)
            make.height.equalTo(62)
        }
        deliverRider.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(deliverInfo.snp.bottom)
            make.height.equalTo(44)
        }
        
    }
}
