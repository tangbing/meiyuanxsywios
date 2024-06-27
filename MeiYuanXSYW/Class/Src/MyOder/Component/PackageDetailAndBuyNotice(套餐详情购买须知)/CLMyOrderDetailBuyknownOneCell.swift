//
//  CLMyOrderDetailPackageDetailCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

class CLMyOrderDetailBuyknownOneCell: XSBaseTableViewCell {
    
    var height  =  27.0
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let image = UIImageView().then{
        $0.image = UIImage(named: "shopInfo_validTime_icon")
    }
    
    let title = UILabel().then{
        $0.text = "有效期"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    override func configUI() {
     
        contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [image,title])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(3)
            make.width.height.equalTo(22)
        }
        
        title.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(4.5)
            make.centerY.equalTo(image.snp.centerY)
        }
    }


}
