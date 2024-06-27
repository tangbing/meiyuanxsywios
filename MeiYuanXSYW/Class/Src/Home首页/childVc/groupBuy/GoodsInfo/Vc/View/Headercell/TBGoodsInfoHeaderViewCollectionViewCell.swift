//
//  TBGoodsInfoHeaderViewCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/15.
//

import UIKit

class TBGoodsInfoHeaderViewCollectionViewCell: XSBaseCollectionViewCell {
    
    lazy var bgShopImageView: UIImageView = {
        let shop = UIImageView()
        shop.image = UIImage(named: "details_Picture")
        //shop.contentMode = .scaleToFill
        return shop
    }()
    
    override func configUI() {
        self.contentView.addSubview(bgShopImageView)
        bgShopImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
