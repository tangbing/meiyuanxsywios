//
//  CLMyOrderDetailDeliverInfoView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/24.
//

import UIKit

class CLMyOrderDetailDeliverInfoView: TBBaseView {
    
    let label = UILabel().then{
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let name = UILabel().then{
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let phone = UILabel().then{
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let address = UILabel().then{
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    public func setting(_ label:String,_ name:String,_ phone:String,_ address:String,_ hideLine:Bool = false){
        self.label.text = label
        self.name.text = name
        self.phone.text = phone
        self.address.text = address
        line.isHidden = hideLine
    }
    
    override func configUI() {
        self.addSubviews(views: [label,name,phone,address,line])
        line.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
        label.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(line.snp.bottom).offset(14)
        }
        
        phone.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(label.snp.centerY)
        }
        
        name.snp.makeConstraints { make in
            make.right.equalTo(phone.snp.left).offset(-5)
            make.centerY.equalTo(label.snp.centerY)
        }
        
        address.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalTo(phone.snp.bottom).offset(10)
        }
        
    }

}
