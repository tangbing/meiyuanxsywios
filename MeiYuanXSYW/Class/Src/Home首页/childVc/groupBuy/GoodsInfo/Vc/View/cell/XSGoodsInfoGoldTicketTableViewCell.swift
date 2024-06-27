//
//  XSGoodsInfoTicketTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/19.
//

import UIKit

class XSGoodsInfoGoldTicketTableViewCell: XSBaseTableViewCell {
    
    
    var goldTicket: XSGoodsInfoGroupBuyGoldTicketModel? {
        didSet {
            guard let voucherGoodsItem = goldTicket?.voucherGoodsItem else {
                return
            }
            
            shopNameLabel.text = voucherGoodsItem.merchantName
            ticketNameLabel.text = voucherGoodsItem.goodsName
            ticketTimeLabel.text = voucherGoodsItem.termOfValidity
        }
    }
    

    lazy var container: UIView = {
        let iv = UIView()
        iv.hg_setAllCornerWithCornerRadius(radius: 10)
        iv.hg_addGradientColor([UIColor.hex(hexString: "#FFF1DE"),
                                UIColor.hex(hexString: "#FFE0B5")],
                               size: CGSize(width: screenWidth - 20, height: 164),
                               startPoint: CGPoint(x: 0.04, y: 0),
                               endPoint: CGPoint(x: 1, y: 1))
        return iv
    }()
    
    lazy var shop_icon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "goodsinfo_groupBuy_shopname_icon")
        return icon
    }()
    
    lazy var shopNameLabel: UILabel = {
        let lab = UILabel()
        lab.text = "商家名称"
        lab.textColor = UIColor.hex(hexString: "#C39B76")
        lab.font = MYFont(size: 14)
        return lab
    }()
    
    lazy var ticket_bg: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: "goodsinfo_groupBuy_details_bg")
        return bg
    }()
    
    lazy var ticketNameLabel: UILabel = {
        let lab = UILabel()
        lab.text = "100元代金券"
        lab.textColor = .text
        lab.font = MYBlodFont(size: 19)
        return lab
    }()
    
    lazy var ticketTimeLabel: UILabel = {
        let lab = UILabel()
        lab.text = "周一至周日可用"
        lab.textColor = .twoText
        lab.font = MYFont(size: 12)
        return lab
    }()

    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .clear
        setupTicketUI()
    }
    
    func setupTicketUI() {
        
        self.contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        container.addSubview(shop_icon)
        shop_icon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 14, height: 12))
        }
        
        container.addSubview(shopNameLabel)
        shopNameLabel.snp.makeConstraints { make in
            make.left.equalTo(shop_icon.snp_right).offset(5)
            make.centerY.equalTo(shop_icon).offset(0)
        }
        
        container.addSubview(ticket_bg)
        ticket_bg.snp.makeConstraints { make in
            make.top.equalTo(shopNameLabel.snp_bottom).offset(14)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(98)
        }
        
        ticket_bg.addSubview(ticketNameLabel)
        ticketNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.equalToSuperview().offset(20)
        }
        
        ticket_bg.addSubview(ticketTimeLabel)
        ticketTimeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(ticket_bg.snp_bottom).offset(-16)
            make.left.equalTo(ticketNameLabel).offset(0)
        }

    }

}
