//
//  CLAllTypeTimeSelectCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/15.
//

import UIKit

class CLAllTypeTimeSelectCell:  XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let content = UIView().then{
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#FCFCFC")
        $0.layer.cornerRadius = 5
    }
    
    let deliverLabel = UILabel().then{
        $0.text = "立即送出"
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
    
    let line = UIView().then{
        $0.backgroundColor = UIColor.borad
    }
    
    
    let markLabel = UILabel().then{
        $0.text = "备注"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let mark = UILabel().then{
        $0.text = "暂无备注"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }

    
    let accessImage = UIImageView().then{
        $0.image = UIImage(named: "icon_right")
    }

    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubview(content)
        content.addSubviews(views: [accessImage,line,deliverLabel,timeLabel,timeSelectImage,mark,markLabel])
                
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        content.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        deliverLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(15)
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
            make.top.equalTo(deliverLabel.snp.bottom).offset(15.5)
            make.height.equalTo(0.5)
        }
        
        markLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(line.snp.bottom).offset(14.5)
        }
        
        accessImage.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(markLabel.snp.centerY)
            make.width.height.equalTo(22)
        }
        
        mark.snp.makeConstraints { make in
            make.right.equalTo(accessImage.snp.left).offset(-2)
            make.centerY.equalTo(accessImage.snp.centerY)
        }
        

    }
}
