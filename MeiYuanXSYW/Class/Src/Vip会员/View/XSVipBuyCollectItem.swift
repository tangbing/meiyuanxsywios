//
//  XSVipBuyCollectItem.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
//券
class VipTicketBuyItemView: UIView {
    //券背景图
    var ticketBackImg : UIImageView = {
        let tipImg = UIImageView()
        tipImg.image = UIImage(named: "vip_buy_car_bg2")
        return tipImg
    }()
    //月卡
    var nameLab : UILabel={
        let countLab = UILabel()
        countLab.font = MYBlodFont(size: 16)
        countLab.textColor = .text
        countLab.text = "月卡"
        return countLab
    }()
    //券价格
    var priceLab : UILabel={
        let priceLab = UILabel()
        priceLab.font = MYBlodFont(size: 30)
        priceLab.textColor = .tag
        priceLab.text = "¥5"
        priceLab.jk.setsetSpecificTextFont("¥", font:MYBlodFont(size: 16))
        return priceLab
    }()
    //券价格折扣
    var priceSLab : UILabel={
        let priceLab = UILabel()
        priceLab.font = MYFont(size: 14)
        priceLab.textColor = .fourText
        priceLab.text = "¥50"
        priceLab.jk.setSpecificTextDeleteLine("¥50", color: .fourText)
        return priceLab
    }()

    //无门槛
    var tipLab : UILabel={
        let tipLab = UILabel()
        tipLab.font = MYBlodFont(size: 12)
        tipLab.textColor = UIColor.hex(hexString: "#895D42")
        tipLab.text = "无门槛"
        tipLab.textAlignment = .center
        return tipLab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(ticketBackImg)
        ticketBackImg.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }

        self.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }
        
        self.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLab.snp_bottom).offset(5)
        }

        self.addSubview(priceSLab)
        priceSLab.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLab.snp_bottom).offset(0)
        }
        self.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalTo(0)
            make.height.equalTo(self.snp_height).multipliedBy(0.26)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSVipBuyCollectItem: XSBaseCollectionViewCell {

    let view = VipTicketBuyItemView()
    override func configUI(){
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }

    }
    

    
}
