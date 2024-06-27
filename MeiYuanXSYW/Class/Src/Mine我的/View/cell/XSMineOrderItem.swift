//
//  XSMineOrderItem.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
class XSMineOrderItem: UICollectionViewCell {

    @IBOutlet weak var iconNum: QMUILabel!
    @IBOutlet weak var numLab: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tipLab: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        numLab.isHidden = true
        self.backgroundColor = .clear
        iconNum.textColor = .white
        iconNum.backgroundColor = .priceText
        iconNum.hg_setAllCornerWithCornerRadius(radius: 7)
        iconNum.contentEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
        // Initialization code
    }

}
