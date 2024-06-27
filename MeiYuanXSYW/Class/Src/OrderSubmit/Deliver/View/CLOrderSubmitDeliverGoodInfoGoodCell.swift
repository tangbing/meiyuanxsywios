//
//  CLOrderSubmitDeliverGoodInfoGoodCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/7.
//

import UIKit

class CLOrderSubmitDeliverGoodInfoGoodCell: XSBaseTableViewCell {
    
    var type:CLMyOrderShopType = .deliver(status: .waitPay,title: "") {
        didSet{
            switch type {
            case .deliver:
                des.isHidden = true
            case .groupBuy:
                des.isHidden = false
            case .privateKitchen:
                des.isHidden = false
            default:
                return
            }
        }
    }
    
    var model:CLOrderGoodsDetailVOList? {
        didSet {
            guard let newModel = model else { return }
            goodName.text = newModel.goodsName
            goodImage.xs_setImage(urlString: newModel.topPic)
            num.text = "x\(newModel.account)"
            price.text = "￥\(newModel.salePrice)"
            price.jk.setsetSpecificTextFont("￥", font: MYBlodFont(size: 12))

            orgrinPrice.text = "￥\(newModel.originalPrice)"
            
            discountLabel.text = newModel.discountRate
        }
        
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let goodImage = UIImageView().then{
        $0.image = UIImage(named: "order_img20")
    }
    
    let goodName = UILabel().then{
        $0.text = "菜品名称"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let des = UILabel().then{
        $0.text = "周一至周日 免预约 过期退 随时退"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
        $0.isHidden = true
    }
    
    let discountDes = UILabel().then{
        $0.text = "促销 2件8折，3件7折 "
        $0.textColor = .king
        $0.font = MYFont(size: 12)
        $0.isHidden = true

    }
    
    let price = UILabel().then{
        $0.text = "￥28.5"
        $0.font = MYBlodFont(size: 16)
        $0.textColor = UIColor.qmui_color(withHexString: "#E61016")!
    }
    
    let num = UILabel().then{
        $0.text  = "x1"
        $0.textColor  = .twoText
        $0.font = MYFont(size: 15)
    }
    
    
    let orgrinPrice = UILabel().then{
        $0.text = "￥110"
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let orgrinPriceLine = UIView().then{
        $0.backgroundColor = .twoText
    }
    
    let discountLabel = UILabel().then{
        $0.text = "3.3折"
        $0.textColor = UIColor.qmui_color(withHexString: "#F11F16")
        $0.font = MYFont(size: 12)
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.qmui_color(withHexString: "#F11F16")?.cgColor
        $0.textAlignment = .center
        $0.layer.cornerRadius = 2
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        baseView.addSubviews(views: [goodImage,goodName,price,orgrinPriceLine,orgrinPrice,discountLabel,num,des,discountDes])
        
        
        goodImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(90)
            make.height.equalTo(90)
        }
        
        goodName.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(goodImage.snp.top)
        }
        des.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(goodName.snp.bottom).offset(10)
        }
        
        discountDes.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.top.equalTo(des.snp.bottom).offset(10)
        }
        
        price.snp.makeConstraints { make in
            make.left.equalTo(goodImage.snp.right).offset(10)
            make.bottom.equalTo(goodImage.snp.bottom)
        }
        
        orgrinPrice.snp.makeConstraints { make in
            make.left.equalTo(price.snp.right).offset(2)
            make.centerY.equalTo(price.snp.centerY)
        }
        
        orgrinPriceLine.snp.makeConstraints { make in
            make.left.equalTo(orgrinPrice.snp.left)
            make.right.equalTo(orgrinPrice.snp.right)
            make.centerY.equalTo(orgrinPrice.snp.centerY)
            make.height.equalTo(0.5)
        }
        
        discountLabel.snp.makeConstraints { make in
            make.left.equalTo(orgrinPrice.snp.right).offset(8)
            make.centerY.equalTo(orgrinPrice.snp.centerY)
            make.width.equalTo(35)
            make.height.equalTo(13)
        }

        num.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(price.snp.centerY)
        }
        
    }
}
