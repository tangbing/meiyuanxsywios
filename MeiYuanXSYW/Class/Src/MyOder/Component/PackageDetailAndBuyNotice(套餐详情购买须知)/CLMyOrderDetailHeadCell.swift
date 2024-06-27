//
//  CLMyOrderDetailHeadView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

class CLMyOrderDetailHeadCell: XSBaseTableViewCell {
    

    let height = 40.0
    
    let image = UIImageView().then{
        $0.image = UIImage(named: "图标")
    }
    
    let title = UILabel().then{
        $0.text = "套餐详情"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 18)
    }
    
    override func configUI() {
        contentView.backgroundColor = .lightBackground
        contentView.addSubviews(views: [image,title])
        
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15)
        }
        
        title.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
    }

}
