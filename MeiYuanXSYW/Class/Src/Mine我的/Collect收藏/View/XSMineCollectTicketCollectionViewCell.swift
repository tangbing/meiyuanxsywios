//
//  XSMineCollectTicketCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/16.
//

import UIKit
import SwiftUI

class XSMineCollectTicketCollectionViewCell: UICollectionViewCell {
    /*
     var goodsId: String = ""
     var goodsName: String = ""
     var topPic: String = ""
     var picAddress: String = ""
     ///  售价
     var minPrice: Double = 0.0
     
     var originalPrice: Double = 0.0
     /// 商品类型 0：外卖 1：团购 2：私厨
     var goodsType: Int = 0
     */
    
    var detailModel: Detail? {
        didSet {
            guard let model = detailModel else { return }
            
            goodsNameLab.text = model.goodsName
            picImageView.xs_setImage(urlString: model.topPic)
            minPriceLab.text = "￥\(model.minPrice)"
            originalPriceLab.text = "￥\(model.originalPrice)"
            originalPriceLab.jk.setSpecificTextDeleteLine("￥\(model.originalPrice)", color: UIColor.hex(hexString: "B3B3B3"))
        }
    }
    
    
    var goods: CLGoodsDetailsVo? {
        didSet {
            guard let model = goods else { return }
            
            goodsNameLab.text = model.goodsName
            picImageView.xs_setImage(urlString: model.topPic)
            minPriceLab.text = "￥\(model.minPrice)"
            originalPriceLab.text = "￥\(model.originalPrice)"
            originalPriceLab.jk.setSpecificTextDeleteLine("￥\(model.originalPrice)", color: UIColor.hex(hexString: "B3B3B3"))
        }
    }
    
    @IBOutlet weak var goodsNameLab: UILabel!
    @IBOutlet weak var minPriceLab: UILabel!
    @IBOutlet weak var originalPriceLab: UILabel!
    
    @IBOutlet weak var picImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picImageView.contentMode = .scaleAspectFill
        picImageView.layer.cornerRadius = 5
        picImageView.clipsToBounds = true
    }

}
