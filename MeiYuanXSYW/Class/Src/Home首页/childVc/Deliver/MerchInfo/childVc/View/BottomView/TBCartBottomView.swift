//
//  TBCartBottomView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/8.
//

import UIKit
import Reusable
import QMUIKit


class TBCartBottomView: UIView, NibLoadable {
    
    var cartBottomClickHandler: ((_ bottom: TBCartBottomView) -> Void)?
    
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var checkoutBtn: QMUIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var tempCartLab: UILabel!
    
    
    var cartGoodsInfoModel: TBMerchInfoCartGoodInfoModel? {
        didSet {
            guard let cartInfoModel = cartGoodsInfoModel else {
                return
            }
            
            //uLog("购物车数量为：\(UInt(cartInfoModel.totalAccount))")
            cartNumBadge = UInt(cartInfoModel.totalAccount)
            
            priceLabel.text = "¥\(cartInfoModel.payAmt)"
            
            if cartInfoModel.canDistribution == 0 {
                msgLabel.text = "预估另需配送费¥" + "\(cartInfoModel.distributionAmt)"
            } else if(cartInfoModel.canDistribution == 1) {
                msgLabel.text = "还差\(cartInfoModel.differenceAmt)起送"
            } else {
                msgLabel.text = "免费送费"
            }
            
        }
    }

    var cartNumBadge: UInt = 0 {
        didSet {
            if cartNumBadge == 0 { // 购物车为空
                cartBtn.qmui_badgeString = "\(cartNumBadge)"
                
                priceLabel.text = "¥0"
                checkoutBtn.setTitle("去结算", for: .normal)
                
                tempCartLab.isHidden = false
                priceLabel.isHidden = !tempCartLab.isHidden
                msgLabel.isHidden = !tempCartLab.isHidden
                checkoutBtn.backgroundColor = UIColor.hex(hexString: "#E5E5E5")


            } else {// 购物车非空
                cartBtn.qmui_badgeInteger = cartNumBadge
                
                tempCartLab.isHidden = true
                priceLabel.isHidden = !tempCartLab.isHidden
                msgLabel.isHidden = !tempCartLab.isHidden
                
                let normal_colors = [UIColor(red: 0.96, green: 0.04, blue: 0.3, alpha: 1), UIColor(red: 1, green: 0.45, blue: 0.31, alpha: 1)]
                checkoutBtn.hg_addGradientColor(normal_colors, size: checkoutBtn.tb_size, startPoint: CGPoint(x: 1, y: 1), endPoint: CGPoint(x: 0.04, y: 0.04))
                
                checkoutBtn.setTitle("去结算(\(cartNumBadge))", for: .normal)


            }
            
            cartBtn.qmui_badgeBackgroundColor = UIColor.hex(hexString: "#F11F16")
            cartBtn.qmui_badgeFont = MYFont(size: 12)
            cartBtn.qmui_badgeTextColor = .white
            cartBtn.qmui_badgeOffset = CGPoint(x: -10, y: 18)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        checkoutBtn.hg_setAllCornerWithCornerRadius(radius: 22)
        checkoutBtn.setTitle("去结算", for: .normal)
        checkoutBtn.setTitleColor(.white, for: .normal)

        cartNumBadge = 0
        
    }
    
    @IBAction func checkoutBtnClick(_ sender: QMUIButton) {
        
    }
    
    
    
    // MARK: - todo showCartView
    @IBAction func showCartView(_ sender: Any) {
        if cartNumBadge != 0 {
            self.cartBottomClickHandler?(self)
        }
       
    }
}
