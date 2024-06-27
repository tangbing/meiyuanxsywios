//
//  XSHeaderMeiTuanCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/24.
//

import UIKit

class XSHeaderMeiTuanCollectionViewCell: XSBaseXIBCollectionViewCell {

   
    var merchantDetail: ProbeShopMerchantDetail? {
        didSet {
            guard let merchant = merchantDetail else { return  }
            
            merchantNameLab.text = merchant.merchantName
            bgImageView.xs_setImage(urlString: merchant.topPic)
            
        }
    }
   
    
    @IBOutlet weak var signalLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var merchantNameLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgImageView.hg_setAllCornerWithCornerRadius(radius: 4)
        signalLabel.hg_setAllCornerWithCornerRadius(radius: 4)
        
    }

}
