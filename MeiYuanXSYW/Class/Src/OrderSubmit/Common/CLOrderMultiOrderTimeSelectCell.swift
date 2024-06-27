//
//  CLOrderMultiOrderTimeSelectCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/8.
//

import UIKit

class CLOrderMultiOrderTimeSelectCell: XSBaseTableViewCell {
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    let containerView = UIView().then{
        $0.backgroundColor = .white
    }
    let line = UIView().then{
        $0.backgroundColor = UIColor.borad
    }
    
    let deliverLabel = UILabel().then{
        $0.text = "预约上门时间"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let timeLabel = UILabel().then{
        $0.text = "大约20:20送达"
        $0.textColor = .king
        $0.font = MYFont(size: 12)
    }

    let timeSelectImage = UIImageView().then{
        $0.image = UIImage(named: "icon_more1")
    }
    
    let label = UILabel().then{
        $0.text = "备注"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let des = UILabel().then{
        $0.text = "推荐使用无接触配送"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    
    let accessImage = UIImageView().then{
        $0.image = UIImage(named: "mine_arrow")
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        baseView.addSubview(containerView)
        containerView.addSubviews(views: [deliverLabel,timeLabel,timeSelectImage,label,des,accessImage,line])
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        deliverLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(line.snp.bottom).offset(15)
        }
        
        timeSelectImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-6)
            make.centerY.equalTo(deliverLabel.snp.centerY)
            make.width.height.equalTo(11)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.right.equalTo(timeSelectImage.snp.left).offset(-3)
            make.centerY.equalTo(deliverLabel.snp.centerY)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(line.snp.bottom).offset(14.5)
        }
        accessImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(line.snp.bottom).offset(14.5)
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        des.snp.makeConstraints { make in
            make.right.equalTo(accessImage.snp.left).offset(-5)
            make.top.equalTo(line.snp.bottom).offset(14.5)
        }
    }
}
