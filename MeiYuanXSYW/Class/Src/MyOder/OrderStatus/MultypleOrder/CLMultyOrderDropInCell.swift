//
//  CLMultyOrderDropInCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/17.
//

import UIKit

class CLMultyOrderDropInCell: XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let title = UILabel().then{
        $0.text = "上门信息"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let inTime  = CLMyOrderDetailReuseView()
    let serviceAddress = CLMyOrderDetailReuseView()
    let contactPhone  = CLMyOrderDetailReuseView()

    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.contentView.addSubview(baseView)
        baseView.addSubviews(views: [title,line,inTime,serviceAddress,contactPhone])
        
        inTime.setting("上门时间","2010-03-15 (周三) 16:33:33",true)
        serviceAddress.setting("服务地点","深圳市罗湖区城市天地广场",true)
        contactPhone.setting("联系人信息","小黑谢谢 12345678910",true)

        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(25)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(title.snp.bottom).offset(15)
            make.height.equalTo(0.5)
        }
        
        inTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(line.snp.bottom).offset(15)
            make.height.equalTo(34)
        }
        serviceAddress.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(inTime.snp.bottom)
            make.height.equalTo(34)
        }
        contactPhone.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(serviceAddress.snp.bottom)
            make.height.equalTo(34)
        }
        
    }

}
