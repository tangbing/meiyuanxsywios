//
//  CLMyOrderMemberCardPayDetailCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit

class CLMyOrderMemberCardPayDetailCell: XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    let label = UILabel().then{
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#312534")!
        $0.layer.cornerRadius = 2
        $0.text = "会员"
        $0.textColor = .white
        $0.font = MYFont(size: 9)
        $0.textAlignment = .center
        $0.layer.cornerRadius = 2
    }
    
    let shopName = UILabel().then{
        $0.text = "行善有味"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }

    let line = UIView().then{
        $0.backgroundColor = .borad
    }

    let goodImage = UIImageView().then{
        $0.image = UIImage(named: "test")
    }
    
    let goodName = UILabel().then{
        $0.text = "行善有味会员(月卡)"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let price = UILabel().then{
        $0.text = "￥28.5"
        $0.textColor = .priceText
        $0.font = MYFont(size: 16)
    }
    
    let num = UILabel().then{
        $0.text  = "x1"
        $0.textColor  = .twoText
        $0.font = MYFont(size: 15)
    }
    
    let disscountInfo = UILabel().then{
        $0.text = "优惠信息"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let line2 = UIView().then{
        $0.backgroundColor = .borad
    }

    let disscountDes = UILabel().then{
        $0.text = "平台会员红包"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let disscountPrice = UILabel().then{
        $0.text = "-￥28.5"
        $0.textColor = UIColor.qmui_color(withHexString: "#E61016")!
        $0.font = MYFont(size: 16)
    }
    
    let totalLabel = UILabel().then{
        $0.text = "实际支付:"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }

    let total = UILabel().then{
        $0.text = "￥5859.5"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    override func configUI() {
        contentView.backgroundColor = .lightBackground
        selectionStyle = .none
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [label,shopName,line,goodImage,goodName,price,num,disscountInfo,line2,disscountDes,disscountPrice,totalLabel,total])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(12)
            make.width.equalTo(30)
            make.height.equalTo(15)
        }
        
        shopName.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(5)
            make.centerY.equalTo(label.snp.centerY)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        goodImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(line.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(60)
        }
        
        goodName.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(goodImage.snp.top)
        }
        
        price.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.bottom.equalTo(goodImage.snp.bottom)
        }

        num.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(price.snp.centerY)
        }
        
        disscountInfo.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.left)
            make.top.equalTo(goodImage.snp.bottom).offset(20)
        }
        
        line2.snp.makeConstraints { make in
            make.left.equalTo(disscountInfo.snp.left)
            make.top.equalTo(disscountInfo.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(0.5)
        }
        disscountDes.snp.makeConstraints { make in
            make.left.equalTo(line2.snp.left)
            make.top.equalTo(line2.snp.bottom).offset(15)
        }
        
        disscountPrice.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(disscountDes.snp.centerY)
        }
        
        total.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(disscountDes.snp.bottom).offset(16)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.right.equalTo(total.snp.left)
            make.centerY.equalTo(total)
        }
        
    }

}
