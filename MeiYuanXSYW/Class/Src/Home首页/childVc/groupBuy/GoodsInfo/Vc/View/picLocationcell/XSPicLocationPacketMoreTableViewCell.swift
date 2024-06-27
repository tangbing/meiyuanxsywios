//
//  XSPicLocationPacketMoreTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/18.
//

import UIKit
import QMUIKit

class XSPicLocationPacketMoreTableViewCell: XSBaseXIBTableViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var moreButton: QMUIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    var moreModel: TBShopInfoPacketDetailMoreModel? {
        didSet {
            guard let model = moreModel else {
                return
            }
            
            totalPriceLabel.text = model.priceText
            
            if model.hasTopRadius {
                containerView.hg_setCornerOnTopWithRadius(radius: 10)
            } else {
                containerView.hg_setCornerOnTopWithRadius(radius: 0)
            }
            
            if model.hasBottomRadus {
                containerView.hg_setCornerOnBottomWithRadius(radius: 10)
            } else {
                containerView.hg_setCornerOnBottomWithRadius(radius: 0)
            }
            
        }
    }
    
    override func configUI() {
        super.configUI()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .background

        moreButton.imagePosition(at: .right, space: 5)
    }

    @IBAction func moreButtonClick(_ sender: QMUIButton) {
        
    }
}
