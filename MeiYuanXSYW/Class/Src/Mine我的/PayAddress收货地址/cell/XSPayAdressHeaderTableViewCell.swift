//
//  XSPayAdressHeaderTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/22.
//

import UIKit

class XSPayAdressHeaderTableViewCell: XSBaseXIBTableViewCell {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var backView: UIView!
    var selectedButton:UIButton?

    @IBOutlet weak var womanBtn: UIButton!
    @IBOutlet weak var manBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        //self.hg_setCornerOnTopWithRadius(radius: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    @IBAction func BtnClick(_ sender: UIButton) {

        // 1.让当前选中的按钮取消选中
        if let selectBtn = self.selectedButton {
            selectBtn.isSelected = false
        }
        
        // 2.让新点击的按钮选中
        sender.isSelected = true;
        
        // 3.新点击的按钮就成为了"当前选中的按钮"
        self.selectedButton = sender;
        
    }
    

    
   

    
}
