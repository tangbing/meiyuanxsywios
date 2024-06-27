//
//  XSVipCardExchangeViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
//券
class VipCardExchangeTicketView: UIView {
    //券背景图
    var ticketBackImg : UIImageView = {
        let tipImg = UIImageView()
        tipImg.image = UIImage(named: "vip_cardCoupon_bg")
        return tipImg
    }()

    //商家图片
    var logImg : UIImageView={
        let img = UIImageView()
        img.image = UIImage(named: "login_LOGO")
        return img
    }()

    
    //券价格
    var priceLab : UILabel={
        let priceLab = UILabel()
        priceLab.font = MYFont(size:13)
        priceLab.textColor = UIColor.hex(hexString: "#895D42")
        priceLab.textAlignment = .center
        priceLab.text = "¥5 无门槛"
        priceLab.jk.setsetSpecificTextFont("¥", font:MYBlodFont(size: 16))
        priceLab.jk.setsetSpecificTextFont("5", font:MYBlodFont(size: 28))

        return priceLab
    }()

    //使用
    var tipLab : UILabel={
        let tipLab = UILabel()
        tipLab.font = MYBlodFont(size: 12)
        tipLab.textColor = UIColor.hex(hexString: "#895D42")
        tipLab.text = "会员红包"
        tipLab.textAlignment = .center
        return tipLab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(ticketBackImg)
        ticketBackImg.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }

        self.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.right.bottom.left.equalTo(0)
            make.height.equalTo(self.snp_height).multipliedBy(0.24)
        }

        self.addSubview(logImg)
        logImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
            make.height.width.equalTo(40)
        }


        self.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(logImg.snp_bottom).offset(-2)
            make.bottom.equalTo(tipLab.snp_top)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSVipCardExchangeView: UIView {
    var exchangeBlock:(()->())?
    
    var model :CLMerchantSimpleVoModel?{
        didSet{
            guard let newModel = model else { return }
            self.tipLab.text = "使用会员红包兑换商家红包"
            self.subLab.text = "当前还有0张会员红包，兑换需要消耗1张，兑换后商家红包不可退回，您确认兑换吗？"
            self.cardRight.logImg.xs_setImage(urlString: newModel.merchantLogo)
            self.cardRight.priceLab.text = "￥\(newModel.upAmt)"
            self.cardRight.priceLab.jk.setsetSpecificTextFont("¥", font:MYBlodFont(size: 16))
            self.cardRight.priceLab.jk.setsetSpecificTextFont(newModel.upAmt, font:MYBlodFont(size: 28))
            
            self.card.priceLab.text = "¥5"
            self.card.priceLab.jk.setsetSpecificTextFont("¥", font:MYBlodFont(size: 16))
            self.card.priceLab.jk.setsetSpecificTextFont("5", font:MYBlodFont(size: 28))
        }
        
    }
    let backView : UIView={
        let view = UIView()
        view.hg_setAllCornerWithCornerRadius(radius: 8)
        return view
    }()
    let backImg : UIImageView={
        let img = UIImageView()
        img.image = UIImage(named: "vip_changePop_ups_bg")
        return img
    }()
    let tipLab : UILabel = {
        let lab = UILabel()
        lab.font = MYBlodFont(size: 18)
        lab.textColor = .text
        lab.text = "使用会员红包兑换商家红包"
        return lab
    }()
    let subLab : UILabel = {
        let lab = UILabel()
        lab.font = MYFont(size: 14)
        lab.textColor = .twoText
        lab.text = "当前还有5张会员红包，兑换需要消耗1张，兑换后商家红包不可退回，您确认兑换吗？"
        lab.numberOfLines = 0
        return lab
    }()
    let cardRight : VipCardExchangeTicketView = {
        let view = VipCardExchangeTicketView()
        view.ticketBackImg.image = UIImage(named: "vip_change_Red_envelope_bg2")
        return view
    }()
    let itemW = (screenWidth-64-40-34)/2

    
    let card : VipCardExchangeTicketView = {
        
        let cardview = VipCardExchangeTicketView()
        cardview.ticketBackImg.image = UIImage(named: "vip_change_Red_envelope_bg")
        cardview.priceLab.textColor = .red
        cardview.tipLab.textColor = .red
        cardview.logImg.isHidden = true
        cardview.logImg.snp.updateConstraints { make in
            make.width.height.equalTo(0)
            make.top.equalTo(0)
        }
        let itemW = (screenWidth-64-40-34)/2
        let h = itemW*0.31
        cardview.tipLab.snp.remakeConstraints { make in
            make.right.bottom.left.equalTo(0)
            make.height.equalTo(h)
        }
//            tipLab.snp.makeConstraints { make in
//                make.right.bottom.left.equalTo(0)
//                make.height.equalTo(self.snp_height).multipliedBy(0.24)
//            }

        return cardview
    }()
    
    let exchangeBtn : UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = MYBlodFont(size: 16)
        btn.setTitleColor(.white, for: UIControl.State.normal)
        btn.setTitle("确认兑换", for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage(named: "btnBackImg"), for: UIControl.State.normal)
        btn.hg_setAllCornerWithCornerRadius(radius: 22)
        btn.addTarget(self, action: #selector(exchange), for: .touchUpInside)
        return btn
    }()
    
    @objc func exchange(){
        guard let action = exchangeBlock else { return }
        action()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear

        self.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.right.left.equalTo(0)
        }


        backView.addSubview(backImg)
        backImg.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        

        backView.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.left.top.equalTo(20)
            make.right.equalTo(-20)
        }
        

        backView.addSubview(subLab)
        subLab.snp.makeConstraints { make in
            make.left.equalTo(tipLab.snp_left)
            make.top.equalTo(tipLab.snp_bottom).offset(10)
            make.right.equalTo(-20)

        }

        backView.addSubview(cardRight)
        cardRight.snp.makeConstraints { make in
            make.top.equalTo(subLab.snp_bottom).offset(14)
            make.right.equalTo(-20)
            make.width.equalTo(itemW)
            make.height.equalTo(cardRight.snp_width).multipliedBy(1.18)
        }

        backView.addSubview(card)
        card.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.width.equalTo(itemW)
            make.bottom.equalTo(cardRight.snp_bottom)
            make.height.equalTo(card.snp_width)
        }



        backView.addSubview(exchangeBtn)
        exchangeBtn.snp.makeConstraints { make in
            make.left.equalTo(22)
            make.right.equalTo(-22)
            make.height.equalTo(44)
            make.top.equalTo(cardRight.snp_bottom).offset(14)
            make.bottom.equalTo(-18)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

