//
//  CLMyOrderDetailGoodViewCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/24.
//

import UIKit

class CLMyOrderDetailGoodViewCell: XSBaseTableViewCell {

    let goodImage = UIImageView().then{
        $0.image = UIImage(named: "test")
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    let goodName = UILabel().then{
        $0.text = "商品名称"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let noticeLabel = UILabel().then{
        $0.text = "加入英特尔社区提交报名表单，表示您确认您已年满18岁"
        $0.textColor = .twoText
        $0.numberOfLines = 2
        $0.backgroundColor = .lightBackground
        $0.font = MYFont(size: 12)
        $0.layer.cornerRadius = 2

    }
    
    let goodPrice = UILabel().then{
        $0.text = "￥28.5"
        $0.textColor =  UIColor.hex(hexString: "#E61016")
        $0.font = MYBlodFont(size: 16)
    }
    
    let goodNum = UILabel().then{
        $0.text = "x1"
        $0.textColor = .twoText
        $0.font = MYFont(size: 16)
    }

    override func configUI() {
        self.contentView.addSubviews(views: [goodImage,goodName,noticeLabel,goodPrice,goodNum])
        
        goodImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(90)
        }
        
        goodName.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(goodImage.snp.top)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(goodName.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(37)
        }
        
        goodPrice.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.bottom.equalTo(goodImage.snp.bottom)
        }
        
        goodNum.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(goodImage.snp.bottom)
        }
    }

}
