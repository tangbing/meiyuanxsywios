//
//  XSVipCardTicketCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
//券
class VipCardTicketItemView: UIView {
    //券背景图
    var ticketBackImg : UIImageView = {
        let tipImg = UIImageView()
        tipImg.image = UIImage(named: "vip_cardCoupon_bg")
        return tipImg
    }()
    //券限购
    var countLab : UILabel={
        let countLab = UILabel()
        countLab.font = MYFont(size: 9)
        countLab.textColor = UIColor.hex(hexString: "#895D42")
        countLab.textAlignment = .center
        countLab.text = "加量包"
        countLab.backgroundColor = UIColor.hex(hexString: "FFE5B6")
        countLab.hg_setCorner(conrner: [QMUICornerMask.layerMinXMinYCorner,QMUICornerMask.layerMaxXMaxYCorner], radius: 9)
        return countLab
    }()
    //过期
    var timeOutLab : UILabel={
        let countLab = UILabel()
        countLab.font = MYFont(size: 12)
        countLab.textColor = .red
        countLab.text = "将于3天后过期"
        return countLab
    }()
    //商家图片
    var logImg : UIImageView={
        let img = UIImageView()
        img.isHidden = true
        return img
    }()
    //商家名称
    var nameLab : UILabel={
        let countLab = UILabel()
        countLab.font = MYBlodFont(size: 16)
        countLab.textColor = .red
        countLab.textAlignment = .center
        countLab.text = "行膳有味会员红包"
        return countLab
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
        tipLab.text = "使用>"
        tipLab.textAlignment = .center
        return tipLab
    }()
    
    
    //蒙板
    var maskbackImg : UIImageView = {
        let backImg = UIImageView()
        backImg.image = UIImage(named: "vip_mask_bg")
        return backImg
    }()
    var maskiconImg : UIImageView = {
        let backImg = UIImageView()
        backImg.image = UIImage(named: "vip_Used")
        return backImg
    }()
    var masksView : UIView = {
        let maskView = UIView()
        return maskView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(ticketBackImg)
        ticketBackImg.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }

        self.addSubview(countLab)
        countLab.snp.makeConstraints { make in
            make.left.top.equalTo(0)
            make.width.equalTo(46)
            make.height.equalTo(18)
        }
        self.addSubview(timeOutLab)
        timeOutLab.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.right.equalTo(-5)
            make.height.equalTo(20)
        }
        self.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.right.bottom.left.equalTo(0)
            make.height.equalTo(self.snp_height).multipliedBy(0.24)
        }

        self.addSubview(logImg)
        logImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(timeOutLab.snp_bottom).offset(-10)
            make.height.width.equalTo(40)
        }
        self.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(timeOutLab.snp_bottom)
            make.height.equalTo(30)
        }


        self.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(nameLab.snp_bottom).offset(-2)
            make.bottom.equalTo(tipLab.snp_top)
        }
        
        self.addSubview(masksView)
        masksView.isHidden = true
        masksView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        masksView.addSubview(maskbackImg)
        maskbackImg.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        masksView.addSubview(maskiconImg)
        maskiconImg.snp.makeConstraints { make in
            make.bottom.right.equalTo(-10)
            make.width.height.equalTo(60)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSVipCardTicketCell: XSBaseTableViewCell {
    
    var backView : UIView={
        let backView = UIView()
        backView.backgroundColor = .white
        return backView
    }()

    var ticketView : VipCardTicketItemView={
        let ticketView = VipCardTicketItemView()
        return ticketView
    }()

    var ticketViewRight : VipCardTicketItemView={
        let ticketView = VipCardTicketItemView()
        return ticketView
    }()
    
    
    
    var model : [Any] = []{
        didSet{
            let dict: [String: Any] = model.first as! [String : Any]
            //会员，商家
            setStyleType(type:dict["type"] as! Int , ticketV: ticketView)
            //使用，未使用
            setMask(isMask: ((dict["isused"] != nil) == false), ticketV: ticketView)
            
            
            if model.count > 1 {
                self.ticketViewRight.isHidden = false
                let dictLast: [String: Any] = model.last as! [String : Any]
                setStyleType(type:dictLast["type"] as! Int , ticketV: ticketViewRight)
                setMask(isMask: (dictLast["isused"] != nil), ticketV: ticketViewRight)

            }
            else{
                self.ticketViewRight.isHidden = true
            }
            

            
            
        }
    }
    func setStyleType(type:Int,ticketV:VipCardTicketItemView) {
            if type == 1 {
                ticketV.ticketBackImg.image = UIImage(named: "vip_cardCoupon_bg")
                ticketV.countLab.textColor = UIColor.hex(hexString: "#895D42")
                ticketV.countLab.backgroundColor = UIColor.hex(hexString: "FFE5B6")

                ticketV.nameLab.textColor = UIColor.hex(hexString: "#895D42")
                ticketV.priceLab.textColor = UIColor.hex(hexString: "#895D42")
                ticketV.tipLab.textColor = UIColor.hex(hexString: "#895D42")
            }
            else{
                ticketV.ticketBackImg.image = UIImage(named: "vip_Red_envelope_bg")
                ticketV.countLab.textColor = .red
                ticketV.countLab.backgroundColor = UIColor.hex(hexString: "#FFDDD9")
                
                ticketV.nameLab.textColor = .red
                ticketV.priceLab.textColor = .red
                ticketV.tipLab.textColor = .red
                
            }
    }

    func setMask(isMask:Bool, ticketV:VipCardTicketItemView) {
        if isMask {
            ticketV.masksView.isHidden = false
            ticketV.tipLab.text = "已使用"
        }
        else{
            ticketV.masksView.isHidden = true
            ticketV.tipLab.text = "使用>"
        }
    }

    override func configUI(){
//        contentView.backgroundColor = .background
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.bottom.equalTo(-15)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }

        let itemW = (screenWidth-35)/2
        
        backView.addSubview(ticketView)
        ticketView.snp.makeConstraints { make in
            make.top.bottom.left.equalTo(0)
            make.width.equalTo(itemW)
        }

        backView.addSubview(ticketViewRight)
        ticketViewRight.snp.makeConstraints { make in
            make.top.bottom.right.equalTo(0)
            make.width.equalTo(itemW)
        }
        
    }

}
