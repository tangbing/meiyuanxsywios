//
//  XSShopCartBottomBalanceOrderTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/25.
//

import UIKit
import QMUIKit

class XSShopCartBottomBalanceOrderTableViewCell: XSBaseTableViewCell {

    lazy var balanceOrderBtn : QMUIButton = {
        let arrowBtn = QMUIButton()
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("去凑单", for: UIControl.State.normal)
      
        arrowBtn.setImage(UIImage(named: "merchInfo_detail_down"), for: UIControl.State.normal)
        arrowBtn.setTitleColor(.text, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYBlodFont(size: 14)
        arrowBtn.spacingBetweenImageAndTitle = 0
        arrowBtn.addTarget(self, action: #selector(showShopInfo), for: .touchUpInside)
        return arrowBtn
    }()
    
    var balanceOrderModel: XSShopCartBalanceOrderModel? {
        didSet {
            guard let model = balanceOrderModel else {
                return
            }
            
            let caculator  = model.caculateMoreAmt
            
            let sub = "\(caculator.diffPrice.doubleValue)"
            let msg = "凑单"
            let selectColor = UIColor.hex(hexString: "#F11F16")
               if let attr = NSMutableAttributedString(string: "还\(sub)差元起送，去凑单").setMultAttributes(elements: [
                    (str: sub, attr:  [NSAttributedString.Key.foregroundColor : selectColor, NSAttributedString.Key.font: MYBlodFont(size: 14)]),
                    (str: msg, attr:  [NSAttributedString.Key.foregroundColor : selectColor, NSAttributedString.Key.font: MYBlodFont(size: 14)]),
               ]) {
                   balanceOrderBtn.setAttributedTitle(attr, for: UIControl.State.normal)
               }
            
            
            
            if model.hasBottomRadius {
                self.contentView.hg_setCornerOnBottomWithRadius(radius: 10)
            }
        }
    }
    
    
    override func configUI() {
        super.configUI()
        
        self.contentView.addSubview(balanceOrderBtn)
        balanceOrderBtn.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
       
    }

    @objc func showShopInfo() {
        
    }

}
