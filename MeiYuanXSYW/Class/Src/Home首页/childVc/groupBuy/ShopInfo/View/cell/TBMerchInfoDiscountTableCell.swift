//
//  TBMerchInfoDiscountTableCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/1.
//

import UIKit

class TBMerchInfoDiscountTableCell: XSBaseXIBTableViewCell {
    
    @IBOutlet weak var rushToPurBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var discountNameLabel: UILabel!
    
    @IBOutlet weak var discountLimitLabel: UILabel!
    @IBOutlet weak var curPriceLabel: UILabel!
    @IBOutlet weak var reducePriceLabel: UILabel!
    
    var discountModel: TBCouponDetails? {
        didSet {
            guard let model = discountModel else { return }
            
            discountNameLabel.text = model.goodsName
            discountLimitLabel.text = model.availableDays + ":" + model.startTime + "-" + model.endTime
            
            curPriceLabel.text = "￥\(model.price)"
            reducePriceLabel.text = "\(model.discount)折"
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        containerView.backgroundColor = UIColor.white
        containerView.hg_setAllCornerWithCornerRadius(radius: 10)
        
        rushToPurBtn.hg_setAllCornerWithCornerRadius(radius: 12)
        rushToPurBtn.titleLabel?.font = MYFont(size: 14)
        reducePriceLabel.jk.addBorder(borderWidth: 1.0, borderColor: UIColor.hex(hexString: "#FA6059"))
    }

}
