//
//  XSVipMerchantCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit



//券
class VipTicketView: UIView {
    var clickBlock:(()->())?
    //券背景图
    var ticketBackImg : UIImageView = {
        let tipImg = UIImageView()
        tipImg.image = UIImage(named: "vip_Coupon_bg")
        tipImg.hg_setAllCornerWithCornerRadius(radius: 6)
        return tipImg
    }()
    //券价格
    var priceLab : UILabel={
        let priceLab = UILabel()
        priceLab.font = MYBlodFont(size: 14)
        priceLab.textColor = UIColor.hex(hexString: "#895D42")
        priceLab.textAlignment = .center
        priceLab.text = "¥8   无门槛"
        priceLab.jk.setsetSpecificTextFont("8", font:MYBlodFont(size: 22))
        priceLab.jk.setSpecificTextColor("8", color: .red)
        priceLab.jk.setSpecificTextColor("¥", color: .red)

        return priceLab
    }()
    //红包
    var tipLab : UILabel={
        let tipLab = UILabel()
        tipLab.font = MYBlodFont(size: 13)
        tipLab.textColor = UIColor.hex(hexString: "#895D42")
        tipLab.text = "1张会员红包"
        tipLab.textAlignment = .center
        return tipLab
    }()
    //兑换
    var tipBtn : UIButton={
        let tipBtn = UIButton()
        tipBtn.titleLabel?.font = MYFont(size: 11)
        tipBtn.setTitleColor(.white, for: UIControl.State.normal)
        tipBtn.backgroundColor = .king
        tipBtn.setTitle("兑换", for: UIControl.State.normal)
        tipBtn.hg_setAllCornerWithCornerRadius(radius: 7)
        tipBtn.addTarget(self, action: #selector(exchange), for: .touchUpInside)
        return tipBtn
    }()
    
    @objc func exchange(){
        guard let action = clickBlock else { return }
        action()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(ticketBackImg)
        ticketBackImg.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }

        self.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(self.snp_width).multipliedBy(0.54)
        }
        
        self.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.right.top.equalTo(0)
            make.width.equalTo(self.snp_width).multipliedBy(0.46)
            make.height.equalTo(self.snp_height).multipliedBy(0.6)
        }
        self.addSubview(tipBtn)
        tipBtn.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(14)
            make.top.equalTo(tipLab.snp_bottom).offset(-5)
            make.centerX.equalTo(tipLab.snp.centerX)
        }

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSVipMerchantCell: XSBaseCommonTableViewCell {
    
    
    var model :CLMerchantSimpleVoModel?{
        didSet{
            guard let newModel = model else { return }
            tipImg.xs_setImage(urlString: newModel.merchantLogo)
            nameLab.text = newModel.merchantName
            scoreView.scoreLab.text = newModel.commentScore
            scoreView.priceLab.text = "人均￥\(newModel.avgPrice)"
            scoreView.saleLab.text = "月销\(newModel.monthlySales)"
            timeView.timeLab.text = "\(newModel.deliveryTime)分钟" + " " +  "\(newModel.distance)km"
            priceView.priceLab.text =  newModel.distributionAmt == "0" ? "免费配送":"配送费￥\(newModel.distributionAmt)"
            priceView.startPriceLab.text = "起送￥\(newModel.minPrice)"
            rankBtn.setTitle(newModel.rankInfo, for: .normal)
            ticketView.priceLab.text = "￥\(newModel.upAmt)   无门槛"
            ticketView.priceLab.jk.setsetSpecificTextFont(newModel.upAmt, font:MYBlodFont(size: 22))
            ticketView.priceLab.jk.setSpecificTextColor(newModel.upAmt, color: .red)
            ticketView.priceLab.jk.setSpecificTextColor("¥", color: .red)

            
        }
    }

    //券
    var ticketView : VipTicketView = {
        let tickteView = VipTicketView()
        tickteView.isUserInteractionEnabled = true
        return tickteView
    }()
    
    // 线
    var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .borad
        return lineView
    }()


    
    var dataSource = [Any]()
    
//    func setNameIconType(type:Int) {
//        if type == 0 {//外卖+到店+自营
//            nameIcon.snp.updateConstraints { make in
//                make.width.equalTo(95)
//            }
//            nameIcon.icon.isHidden = false
//            nameIcon.icon2.isHidden = false
//            nameIcon.icon3.isHidden = false
//        }
//        else if type == 1{//外卖+自营 ||  到店+自营
//            nameIcon.snp.updateConstraints { make in
//                make.width.equalTo(67)
//            }
//            nameIcon.icon.isHidden = false
//            nameIcon.icon2.isHidden = true
//            nameIcon.icon3.isHidden = false
//
//        }
//        else if type == 2{//外卖+到店
//            nameIcon.snp.updateConstraints { make in
//                make.width.equalTo(51)
//            }
//            nameIcon.icon.isHidden = false
//            nameIcon.icon2.isHidden = false
//            nameIcon.icon3.isHidden = true
//
//        }
//        else if type == 3{//外卖 || 到店
//            nameIcon.snp.updateConstraints { make in
//                make.width.equalTo(23)
//            }
//            nameIcon.icon.isHidden = false
//            nameIcon.icon2.isHidden = true
//            nameIcon.icon3.isHidden = true
//        }
//    }
    override func configUI() {
        super.configUI()
        
        //券
        ticketView.jk.addGestureTap { gesture in
            self.delegate?.clickTicketExchange()
        }
        
        backView.addSubview(ticketView)
        ticketView.snp.makeConstraints { make in
            make.left.equalTo(nameLab.snp.left)
            make.right.equalTo(addBtn.snp_right)
            make.height.equalTo(56)
            make.top.equalTo(rankBtn.snp_bottom).offset(6)
        }
        //线
        backView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.equalTo(nameLab.snp.left)
            make.right.equalTo(addBtn.snp_right)
            make.height.equalTo(1)
            make.top.equalTo(ticketView.snp_bottom).offset(6)
            make.bottom.equalTo(-10)
        }

    }


    
}
