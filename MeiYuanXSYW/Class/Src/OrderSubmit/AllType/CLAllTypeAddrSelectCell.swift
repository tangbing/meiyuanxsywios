//
//  CLAllTypeAddrSelectCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/15.
//

import UIKit

class CLAllTypeAddrSelectCell: XSBaseTableViewCell {
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let addrImage = UIImageView().then{
        $0.image = UIImage(named: "home_location")
    }
    
    let addrDetailLabel = UILabel().then{
        $0.text = "城市天地广场东卓6楼626"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let personName = UILabel().then{
        $0.text = "张先生"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let phone = UILabel().then{
        $0.text = "17623727382"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    
    let accessImage = UIImageView().then{
        $0.image = UIImage(named: "home_hot_arow_right")
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [addrImage,addrDetailLabel,personName,phone,accessImage])
        
        baseView.hg_setAllCornerWithCornerRadius(radius: 10)
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        addrImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(12.5)
        }
        
        addrDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(addrImage.snp.right).offset(7)
            make.top.equalTo(addrImage.snp.top)
        }
        
        personName.snp.makeConstraints { make in
            make.left.equalTo(addrDetailLabel.snp.left)
            make.top.equalTo(addrDetailLabel.snp.bottom).offset(6)
        }
        
        phone.snp.makeConstraints { make in
            make.left.equalTo(personName.snp.right).offset(10)
            make.centerY.equalTo(personName.snp.centerY)
        }
        
        accessImage.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(24)
            make.width.height.equalTo(22)
        }
       
    }
}
