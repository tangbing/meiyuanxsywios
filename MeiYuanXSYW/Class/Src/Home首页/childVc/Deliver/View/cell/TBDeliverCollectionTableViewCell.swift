//
//  TBDeliverCollectionTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/25.
//

import UIKit
import QMUIKit

class TBDeliverCollectionCell: XSBaseCollectionViewCell {
    
    
    var secondKillGoodsModel :SecKillGoodsVos? {
        didSet {
            guard let goodsModel = secondKillGoodsModel else { return }
            
            shopImageView.xs_setImage(urlString: goodsModel.topPic, placeholder: UIImage.bannerPlaceholder)
            nameLabel.text = goodsModel.goodsName
            priceView.finalPriceLabel.text = "¥\(goodsModel.seckillPrice)"
            priceView.previousPriceLabel.text = "¥\(goodsModel.originalPrice)"
            priceView.reduceDownPriceLabel.text = "\(goodsModel.discount)折"
            priceView.previousPriceLabel.jk.setSpecificTextDeleteLine("¥\(goodsModel.originalPrice)", color: UIColor.hex(hexString: "BBBBBB"))
                /// 0:外卖;1:团购;2:私厨
                var signal = "外卖"
                if goodsModel.goodsType == 1 {
                    signal = "团购"
                } else if(goodsModel.goodsType == 2) {
                    signal = "私厨"
                }
            signLabel.text = signal

        }
    }

//    let bgContainer: UIView = {
//        let iv = UIView()
//        iv.backgroundColor = .clear
//        return iv
//    }()
    
    let shopImageView: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "test_icon")
        imageV.hg_setAllCornerWithCornerRadius(radius: 4)
        return imageV
    }()
    
    let signLabel: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.textColor = .white
        lab.font = MYFont(size: 9)
        lab.backgroundColor = UIColor.hex(hexString: "#518DFF")
        lab.text = "外卖"
        lab.hg_setAllCornerWithCornerRadius(radius: 4)
        return lab
    }()
    
    let nameLabel: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 1
        lab.textColor = .text
        lab.text = "行膳食界火锅"
        lab.font = MYBlodFont(size: 14)
        return lab
    }()
    
    let priceView: XSCollectPriceView = {
       return XSCollectPriceView()
    }()
    
    override func configUI() {
//        self.contentView.addSubview(bgContainer)
//        bgContainer.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
        self.contentView.addSubview(shopImageView)
        shopImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 112, height: 84))
        }
        
        self.contentView.addSubview(signLabel)
        signLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 15))
        }
        
        self.contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalTo(shopImageView)
            make.top.equalTo(shopImageView.snp_bottom).offset(5)
            make.height.equalTo(20)
        }

        
        self.contentView.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.left.right.equalTo(shopImageView)
            make.top.equalTo(nameLabel.snp_bottom).offset(2)
            make.height.equalTo(22)
        }
        
    }

}
