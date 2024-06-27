//
//  TBMerchInfoDetailAddressCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/3.
//

import UIKit

class TBMerchInfoDetailAddressCell: XSBaseXIBTableViewCell {

    @IBOutlet weak var merchLogo: UIImageView!
    @IBOutlet weak var merchLogoW: NSLayoutConstraint!
    
    @IBOutlet weak var telephoneButton: UIButton!
    @IBOutlet weak var guideButton: UIButton!
    
    @IBOutlet weak var merchNameLab: UILabel!
    @IBOutlet weak var merchAddressLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        merchLogoW.constant = 0
    }
    
    var detailModel: TBDetailModel? {
        didSet {
            guard let model = detailModel else {
                return
            }
            merchNameLab.text = model.title
            merchAddressLab.text = model.subTitle
            
        }
    }
    
    
    
    func configCompain() {
        telephoneButton.isHidden = true
        guideButton.isHidden = true
        merchLogoW.constant = 40

        self.backgroundColor = .white
        self.hg_setAllCornerWithCornerRadius(radius: 10)
    }
    
}
