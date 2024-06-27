//
//  XSMerchInfoCartButton.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/1/4.
//

import UIKit
import QMUIKit

class XSMerchInfoCartButton: UIButton {
    
    var cartNum: Int = 0 {
        didSet {
            self.qmui_badgeString = "\(cartNum)"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCartButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    func setupCartButton() {
        
        self.setImage(UIImage(named: "merchinfo_cart_white_icon"), for: .normal)
        
        self.qmui_badgeBackgroundColor = UIColor.hex(hexString: "#F11F16")
        self.qmui_badgeFont = MYFont(size: 12)
        self.qmui_badgeTextColor = UIColor.white
        self.qmui_badgeOffset = CGPoint(x: -10, y: 18)
    }

}
