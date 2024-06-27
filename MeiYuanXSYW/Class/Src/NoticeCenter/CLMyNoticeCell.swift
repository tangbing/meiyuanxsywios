//
//  CLMyNoticeCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/16.
//

import UIKit

class CLMyNoticeCell: XSBaseTableViewCell {
    
    let logo = UIImageView().then{
        $0.image = UIImage(named: "activity")
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    let title = UILabel().then{
        $0.text = "商品名称"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let des = UILabel().then{
        $0.text = "成功领取30元优惠券成功领取30元优惠券成功领取30元优惠券成功领取30元优惠券"
        $0.textColor = .threeText
        $0.font = MYFont(size: 14)
        $0.numberOfLines = 2
    }
    
    let time = UILabel().then{
        $0.text = "04:22"
        $0.textColor = .threeText
        $0.font = MYBlodFont(size: 12)
    }
    
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .white
        
        contentView.addSubviews(views: [logo,title,des,time])
        
        logo.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(50)
            make.top.equalToSuperview().offset(15)
        }
        
        title.snp.makeConstraints { make in
            make.left.equalTo(logo.snp.right).offset(11.5)
            make.centerY.equalTo(logo.snp.centerY)
        }
        
        des.snp.makeConstraints { make in
            make.left.equalTo(title.snp.left)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(title.snp.bottom).offset(8)
        }
        
        time.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(title.snp.top).offset(5)
        }
        
    }
}
