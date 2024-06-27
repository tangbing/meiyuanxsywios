//
//  CLEmptyAddressCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/3/13.
//

import UIKit

class CLEmptyAddressView: TBBaseView {

    let addrImage = UIImageView().then{
        $0.image = UIImage(named: "home_location")
    }
    
    let addrDetailLabel = UILabel().then{
        $0.text = "请选择地址"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let accessImage = UIImageView().then{
        $0.image = UIImage(named: "home_hot_arow_right")
    }
    
    let line = UIView().then{
        $0.backgroundColor = UIColor.borad
    }
    
    override func configUI() {
        super.configUI()
        
        self.addSubviews(views: [addrImage,addrDetailLabel,accessImage,line])
        
        addrImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        addrDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(addrImage.snp.right).offset(3)
            make.centerY.equalToSuperview()
        }
        accessImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(22)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        

    }
}
