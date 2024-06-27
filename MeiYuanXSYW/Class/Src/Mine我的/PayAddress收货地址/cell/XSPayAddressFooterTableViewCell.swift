//
//  XSPayAddressFooterTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/22.
//

import UIKit
import QMUIKit

class XSPayAddressFooterTableViewCell: XSBaseXIBTableViewCell {
    
    var selectButton: UIButton?
    @IBOutlet weak var companyTagBtn: XSBorderSelectButton!
    @IBOutlet weak var homeTagBtn: XSBorderSelectButton!
    @IBOutlet weak var schoolTagBtn: XSBorderSelectButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        companyTagBtn.jk.addBorder(borderWidth: 1, borderColor: UIColor.hex(hexString: "#E5E5E5"))
        homeTagBtn.jk.addBorder(borderWidth: 1, borderColor: UIColor.hex(hexString: "#E5E5E5"))
        schoolTagBtn.jk.addBorder(borderWidth: 1, borderColor: UIColor.hex(hexString: "#E5E5E5"))
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func tagBtnClick(_ sender: UIButton) {
       
        if let selectBtn = selectButton {
            selectBtn.isSelected = false
        }
        
        sender.isSelected = true
        
        selectButton = sender
        
    }
   
    
}
