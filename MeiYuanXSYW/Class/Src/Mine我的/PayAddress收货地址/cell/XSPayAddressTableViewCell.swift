//
//  XSPayAddressTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/22.
//

import UIKit
import QMUIKit

class XSPayAddressTableViewCell: XSBaseXIBTableViewCell {
    
    var model:CLReceiverAddressModel? {
        didSet{
            guard let model = model else { return }
            
            detailAddressLab.text = model.receiverDetailAddress
            
            let sexStr = model.receiverSex == 0 ? "女士" : "男士"
            userInfoLab.text = "\(model.receiverName) \(sexStr) \(model.receiverPhone)"
            
            if model.isDefaultAddress == 1 {
                addressTypeLabel.text = "常用"
                addressTypeLabelW.constant = 45
                addressNameLabelLeft.constant = 4
            }
            
            // 签(家或者公司).0家，1公司, 2学校
            if model.receiverLabel == 0 { //
                addressTypeLabel.text = "家"
                addressTypeLabelW.constant = 45
                addressNameLabelLeft.constant = 4

            } else if(model.receiverLabel == 1) {
                addressTypeLabel.text = "公司"
                addressTypeLabelW.constant = 45
                addressNameLabelLeft.constant = 4

            } else if(model.receiverLabel == 2) {
                addressTypeLabelW.constant = 45
                addressTypeLabel.text = "学校"
                addressNameLabelLeft.constant = 4
            } else {
                addressNameLabelLeft.constant = 0
                addressNameLabelLeft.constant = 0
            }
            
        }
    }

    @IBOutlet weak var addressTypeLabelW: NSLayoutConstraint!
    @IBOutlet weak var addressNameLabelLeft: NSLayoutConstraint!
    
    @IBOutlet weak var detailAddressLab: UILabel!
    
    @IBOutlet weak var userInfoLab: UILabel!
    
    var editClickBlock : (() -> Void)?
    

    @IBOutlet weak var addressTypeLabel: QMUILabel!
    
        override var frame: CGRect {
            didSet {
                var newFrame = frame
                newFrame.origin.y += 10
                newFrame.size.height -= 10
                
                newFrame.origin.x += 10
                newFrame.size.width -= 20
                super.frame = newFrame
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addressTypeLabel.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        addressTypeLabel.jk.addBorder(borderWidth: 1, borderColor: .tag)
        addressTypeLabel.hg_setAllCornerWithCornerRadius(radius: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editBtnClick(_ sender: UIButton) {
        self.editClickBlock?()
    }
}
