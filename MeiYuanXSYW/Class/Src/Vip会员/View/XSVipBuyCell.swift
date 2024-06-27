//
//  XSVipBuyCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit

class XSVipBuyCell: XSBaseTableViewCell {
    var buyBlock:(()->())?
    
    var model:CLMemberUserInfoModel? {
        didSet {
            guard let newModel = model else { return }
            let price = String(Int(newModel.memberCardVo.price)! - Int(newModel.memberCardCouponPrice)!)

            if newModel.memberStatus == "1"{
                
                buyLab.text = "¥\(price) ¥\(newModel.memberCardVo.price)    立即续费"
                
                buyLab.jk.setsetSpecificTextFont("¥", font:MYFont(size: 14))
                buyLab.jk.setsetSpecificTextFont("¥\(newModel.memberCardVo.price) ", font:MYFont(size: 14))

                buyLab.jk.setSpecificTextDeleteLine("¥\(newModel.memberCardVo.price) ", color: .white)
                
                tipBtn.setTitle("已抵扣\(newModel.memberCardCouponPrice)元会员优惠", for: UIControl.State.normal)
            }else {
                
                buyLab.text = "¥\(newModel.memberCardVo.price)/月    开通会员"
                
                buyLab.jk.setsetSpecificTextFont("¥", font:MYFont(size: 14))
                buyLab.jk.setsetSpecificTextFont("¥\(newModel.memberCardVo.price) ", font:MYFont(size: 14))
                
                tipBtn.isHidden = true
            }

        }
    }

    var backView : UIView={
        let backView = UIView()
        backView.backgroundColor = .background
        return backView
    }()
    var tipBtn : UIButton={
        let tipBtn = UIButton()
        tipBtn.titleLabel?.font = MYBlodFont(size: 11)
        tipBtn.setBackgroundImage(UIImage(named: "vip_rebateBack"), for: UIControl.State.normal)
        tipBtn.setTitleColor(.white, for: UIControl.State.normal)
        return tipBtn
    }()
    var buyLab : UILabel = {
        let buyLab = UILabel()
        buyLab.textColor = .white
        buyLab.font = MYBlodFont(size: 19)
        buyLab.textAlignment = NSTextAlignment.center
        buyLab.backgroundColor = .clear
        return buyLab
    }()
    var btn : UIButton={
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named:"cartBackImg"), for: UIControl.State.normal)
        btn.hg_setAllCornerWithCornerRadius(radius: 22)

        return btn
    }()
    
    
    

    
    
    override func configUI() {
        contentView.backgroundColor = .background
        contentView.addSubview(backView)
        buyLab.jk.addGestureTap({ [unowned self] geuture in
            guard let action = self.buyBlock else { return }
            action()
        })
        backView.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        backView.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(10)
            make.height.equalTo(44)
        }
        
        backView.addSubview(buyLab)
        buyLab.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(10)
            make.height.equalTo(44)
        }

        backView.addSubview(tipBtn)
        tipBtn.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.height.equalTo(19)
            make.centerX.equalTo(backView.snp_centerX)
        }

    }


    
}
