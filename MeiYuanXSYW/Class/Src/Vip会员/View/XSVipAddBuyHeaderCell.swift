//
//  XSVipAddBuyHeaderCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
//券
class VipTicketAddBuyView: UIView {
    //券背景图
    var ticketBackImg : UIImageView = {
        let tipImg = UIImageView()
        tipImg.image = UIImage(named: "vip_addbuy_member_bg5")
        return tipImg
    }()
    //券价格
    var priceLab : UILabel={
        let priceLab = UILabel()
        priceLab.font = MYBlodFont(size: 30)
        priceLab.textColor = UIColor.hex(hexString: "#895D42")
        priceLab.textAlignment = .center
        priceLab.text = "¥5X2张"
        priceLab.jk.setsetSpecificTextFont("¥", font:MYBlodFont(size: 16))
        priceLab.jk.setsetSpecificTextFont("X2张", font:MYBlodFont(size: 16))

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

        
        self.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalTo(0)
            make.height.equalTo(self.snp_height).multipliedBy(0.7)
        }

        self.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalTo(0)
            make.height.equalTo(self.snp_height).multipliedBy(0.3)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSVipAddBuyHeaderCell: XSBaseTableViewCell {
    
    var model:CLAddPackageModel?{
        didSet{
            guard let newModel = model else { return }
            tipLab.text = "行膳会员红包加量包"
            priceLab.text = "￥" + newModel.discountAmt
            priceLab.font = MYBlodFont(size: 30)
            priceLab.jk.setsetSpecificTextFont("￥", font:MYBlodFont(size: 16))

            priceDeleLab.text = "¥" + newModel.originalAmt
            priceDeleLab.jk.setSpecificTextDeleteLine("¥" + newModel.originalAmt, color: .fourText)
            
            sealLab.text = newModel.discount + "折"
            
//            ticketView.countLab.text = "限购\(newModel.buyLimit)次"
        }
        
    }

    let ticketview = VipTicketAddBuyView()
    //标题
    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYBlodFont(size: 16)
        lab.textColor = .text
        lab.text = "行膳会员红包加量包"
        return lab
    }()

    //券价格
    var priceLab : UILabel={
        let lab = UILabel()
        lab.font = MYBlodFont(size: 30)
        lab.textColor = .red
        lab.text = "¥6"
        lab.jk.setsetSpecificTextFont("¥", font:MYBlodFont(size: 16))
        return lab
    }()
    //券原价
    var priceDeleLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 14)
        lab.textColor = .fourText
        lab.text = "¥50"
        lab.jk.setSpecificTextDeleteLine("¥50", color: .fourText)
        return lab
    }()
    //折扣
    var sealLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 11)
        lab.textColor = .red
        lab.text = "5折"
        lab.textAlignment = .center
        lab.hg_setAllCornerWithCornerRadius(radius: 3)
        return lab
    }()


    override func configUI(){
        contentView.addSubview(ticketview)
        ticketview.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.left.equalTo(10)
            make.width.height.equalTo(100)
        }
        contentView.addSubview(tipLab)
        tipLab.snp_makeConstraints { make in
            make.left.equalTo(ticketview.snp_right).offset(8)
            make.top.equalTo(30)
        }
        contentView.addSubview(priceLab)
        priceLab.snp_makeConstraints { make in
            make.left.equalTo(tipLab.snp_left)
            make.top.equalTo(tipLab.snp_bottom).offset(10)

        }

        contentView.addSubview(priceDeleLab)
        priceDeleLab.snp_makeConstraints { make in
            make.left.equalTo(priceLab.snp_right).offset(10)
            make.centerY.equalTo(priceLab.snp_centerY).offset(4)
        }
        contentView.addSubview(sealLab)
        sealLab.jk.addBorder(borderWidth: 1, borderColor: .red)
        sealLab.snp_makeConstraints { make in
            make.left.equalTo(priceDeleLab.snp_right).offset(10)
            make.centerY.equalTo(priceLab.snp_centerY).offset(4)
            make.width.equalTo(30)
            make.height.equalTo(14)
        }

    }
    

    
}
