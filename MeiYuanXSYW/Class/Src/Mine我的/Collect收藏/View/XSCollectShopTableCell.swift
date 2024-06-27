//
//  XSCollectShopTableCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/16.
//  收藏店铺cell

import UIKit
import QMUIKit
import SwiftUI

/// 优惠券
class XSCollectTicketView: UIView {
    
    lazy var ticket0: QMUILabel = {
        let ticket = QMUILabel()
        ticket.text = "满20减5"
        ticket.font = MYFont(size: 9)
        ticket.textColor = UIColor.hex(hexString: "#FA6059")
        ticket.jk.addBorder(borderWidth: 1, borderColor: UIColor.hex(hexString: "#FA6059"))
        ticket.hg_setAllCornerWithCornerRadius(radius: 2)

        return ticket
    }()
    
    lazy var ticket1: QMUILabel = {
        let ticket = QMUILabel()
        ticket.text = "满20减5"
        ticket.font = MYFont(size: 9)
        ticket.textColor = UIColor.hex(hexString: "#FA6059")
        ticket.jk.addBorder(borderWidth: 1, borderColor: UIColor.hex(hexString: "#FA6059"))
        ticket.hg_setAllCornerWithCornerRadius(radius: 2)

        return ticket
    }()
    
    lazy var ticket2: QMUILabel = {
        let ticket = QMUILabel()
        ticket.text = "含5元津贴"
        ticket.backgroundColor = UIColor.hex(hexString: "#FFEEF3")
        ticket.font = MYFont(size: 9)
        ticket.textColor = UIColor.hex(hexString: "#FA6059")
        ticket.jk.addBorder(borderWidth: 1, borderColor: UIColor.hex(hexString: "#FA6059"))
        ticket.hg_setAllCornerWithCornerRadius(radius: 2)

        return ticket
    }()
    
    var lastTicket: QMUILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tickets = ["含5元津贴","含5元津贴","含5元津贴"]
        let spcing: CGFloat = 3
        for ticket in tickets {
            let ticketIb = QMUILabel()
            ticketIb.text = ticket
            ticketIb.contentEdgeInsets = UIEdgeInsets(top: spcing, left: spcing, bottom: spcing, right: spcing)
            ticketIb.backgroundColor = UIColor.hex(hexString: "#FFEEF3")
            ticketIb.font = MYFont(size: 9)
            ticketIb.textColor = UIColor.hex(hexString: "#FA6059")
            ticketIb.jk.addBorder(borderWidth: 1, borderColor: UIColor.hex(hexString: "#FA6059"))
            ticketIb.hg_setAllCornerWithCornerRadius(radius: 2)
            
            self.addSubview(ticketIb)
            ticketIb.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(lastTicket != nil ? lastTicket!.snp_right : self.snp_left).offset(4)
            }
            lastTicket = ticketIb
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSCollectShopTableCell: XSBaseCommonTableViewCell {
    
    var details: [Detail]? {
        didSet {
            shopProductView.reloadData()
        }
    }
    
    var goods:[CLGoodsDetailsVo] = []{
        didSet {
            shopProductView.reloadData()
        }
    }
    
    var merchant_Id = ""
    var style: HomeShowStyle = .deliver
    
    var model: CLCollectMerchantListModel? {
        didSet {
            guard let model = model else { return }

            nameLab.text = model.merchantName
            
            tipImg.xs_setImage(urlString: model.merchantLogo)
            
            scoreView.scoreLab.text = "\(model.commentScore)分"
            scoreView.saleLab.text = "月销\(model.monthlySales)"
            scoreView.priceLab.text = "人均¥\(model.avgPrice)"
            
            priceView.startPriceLab.text = "起送¥\(model.minPrice)"
            priceView.priceLab.text = model.distributionAmt == "0" ? "免费配送" : "满\(model.distributionAmt)配送"

            
            /// 业务类型(0外卖，1团购,2私厨,3聚合)
            
            
            nameIcon.icon.isHidden = model.takeout != 1
            nameIcon.icon2.isHidden = model.groupp != 1
            nameIcon.icon3.isHidden = model.privateChef != 1

            // 优惠券
            // 第二行优惠信息
            var tickets: [String] = [String]()
//
//            if model.newCustomerReduce.doubleValue != 0 {
//                tickets.append("新客立减¥\(model.newCustomerReduce.stringValue)")
//            }
//
//            if let ticketActiviet = model. {
//                let ticket = ticketActiviet.map {
//                    "满\($0.accordPrice)减\($0.reducePrice)"
//                }
//                tickets.appends(ticket)
//            }
//
            /// 是否参与红包升级活动
            if !model.joinUpCoupon {
                // 添加5元会员红包
                tickets.append("5元会员红包")
            }
            
            ticketView.setupTicketActivieyView(tickets)
            
            self.goods = model.details
            self.merchant_Id = model.merchantId
            goodsStyle(takeout: model.takeout, group: model.groupp, privateChef: model.privateChef)
        }
    }
    
    
    var merchantModel: TBHomeSearchMerchantModel? {
        didSet {
            guard let model = merchantModel?.searchMerchantModel else { return }

            nameLab.text = model.merchantName
            
            tipImg.xs_setImage(urlString: model.merchantLogo)
            
            scoreView.scoreLab.text = "\(model.merchantScore)分"
            scoreView.saleLab.text = "月销\(model.monthlySales)"
            scoreView.priceLab.text = "人均¥\(model.perCapita)"
            
            priceView.startPriceLab.text = "起送¥\(model.startDelivery)"
            priceView.priceLab.text = model.deliveryFee.doubleValue == 0 ? "免费配送" : "满\(model.deliveryFee)配送"

            
            /// 业务类型(0外卖，1团购,2私厨,3聚合)
            
            
            nameIcon.icon.isHidden = model.takeout != 1
            nameIcon.icon2.isHidden = model.group != 1
            nameIcon.icon3.isHidden = model.privateChef != 1

            // 优惠券
            // 第二行优惠信息
            var tickets: [String] = [String]()
            
            if model.newCustomerReduce.doubleValue != 0 {
                tickets.append("新客立减¥\(model.newCustomerReduce.stringValue)")
            }
            
            if let ticketActiviet = model.merchantCFullReduceVoList {
                let ticket = ticketActiviet.map {
                    "满\($0.accordPrice)减\($0.reducePrice)"
                }
                tickets.appends(ticket)
            }
            
            /// 是否参与红包升级活动
            if !model.joinUpCoupon {
                // 添加5元会员红包
                tickets.append("5元会员红包")
            }
            
            ticketView.setupTicketActivieyView(tickets)
            
            self.details = model.details
            self.merchant_Id = model.merchantId
            goodsStyle(takeout: model.takeout, group: model.group, privateChef: model.privateChef)
        }
    }
    

    var dataModel: Datum? {
        didSet {
            guard let model = dataModel else { return }
            
            nameLab.text = model.merchantName
            
            tipImg.xs_setImage(urlString: model.merchantLogo)
            
            scoreView.scoreLab.text = "\(model.merchantScore)分"
            scoreView.saleLab.text = "月销\(model.monthlySales)"
            scoreView.priceLab.text = "人均¥\(model.perCapita)"
            
            priceView.startPriceLab.text = "起送¥\(model.startDelivery)"
            //priceView.priceLab.text = model.deliveryFee.doubleValue == 0 ? "免费配送" : "满\(model.deliveryFee)配送"
            
            /// 业务类型(0外卖，1团购,2私厨,3聚合)
            if model.merchantType == 0 {
                nameIcon.icon2.isHidden = true
                nameIcon.icon.isHidden = false
            } else if(model.merchantType == 1) {
                nameIcon.icon.isHidden = true
                nameIcon.icon2.isHidden = false
            } else {
                nameIcon.icon.isHidden = false
                nameIcon.icon2.isHidden = false
            }

            // 优惠券
            // 第二行优惠信息
            if let ticketActiviet = model.merchantCFullReduceVoList {
                var tickets: [String] = ticketActiviet.map {
                    "满\($0.accordPrice)减\($0.reducePrice)"
                }
                /// 是否参与红包升级活动
                if !model.joinUpCoupon {
                    // 添加5元会员红包
                    tickets.append("5元会员红包")
                }
                
                ticketView.setupTicketActivieyView(tickets)
            }
            
            self.details = model.details
            self.merchant_Id = model.merchantId
            goodsStyle(takeout: model.takeout, group: model.group, privateChef: model.privateChef)
        }
    }
   
    
    func goodsStyle(takeout: Int, group: Int, privateChef: Int) {
        if takeout == 1 || group == 1 {
            self.style = .multiple
        } else if(takeout == 1) {
            self.style = .deliver
        } else if(group == 1) {
            self.style = .groupBuy
        } else if(privateChef == 1) {
            self.style = .privateKitchen
        }

    }
   
    
    //商家优惠券
//    var ticketView : XSCollectTicketView={
//        let nameIcon = XSCollectTicketView()
//        return nameIcon
//    }()
    lazy var ticketView: TBMerchTicketActivieyView = {
        return TBMerchTicketActivieyView()
    }()
    
    
    // 线
    var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .borad
        return lineView
    }()

//    @objc override func clickAddAction() {
//        delegate?.clickInsetMerchant()
//    }
    
    lazy var shopProductView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 9
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = 108
        let itemH:CGFloat = 140
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "XSMineCollectTicketCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "XSMineCollectTicketCollectionViewCell")

        return collectionView
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
        
        backView.addSubview(ticketView)
        ticketView.snp.makeConstraints { make in
            make.left.equalTo(nameLab.snp.left)
            make.right.equalTo(addBtn.snp_right)
            make.top.equalTo(rankBtn.snp_bottom).offset(6)
        }

        backView.addSubview(shopProductView)
        shopProductView.snp.makeConstraints { make in
            make.top.equalTo(ticketView.snp_bottom).offset(10)
            make.right.equalToSuperview()
            make.left.equalTo(nameLab.snp_left).offset(0)
            make.height.equalTo(140)
        }
        
    }
}

extension XSCollectShopTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.details?.count ?? self.goods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSCollectionTicketViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XSMineCollectTicketCollectionViewCell", for: indexPath) as! XSMineCollectTicketCollectionViewCell
        if let detail = self.details {
            cell.detailModel = detail[indexPath.row]
        }
        
        if goods.count > 0 {
            cell.goods = goods[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detail = self.details {
            let model = detail[indexPath.row]
            let goodsId = model.goodsId
            // 跳转到商品详情
            if model.goodsType == 1 {
                let goodsInfoVc = XSGoodsInfoGroupBuyTicketViewController(style: self.style, merchantId: merchant_Id, goodId: goodsId)
                topVC?.navigationController?.pushViewController(goodsInfoVc, animated: true)
            } else {
                let goodsInfoVc = TBDelievePrivateKitGoodsInfoVc(style: self.style, merchantId: merchant_Id
                                                            ,goodsId: goodsId)
                topVC?.navigationController?.pushViewController(goodsInfoVc, animated: true)
            }
        } else {
            let goods = goods[indexPath.row]
            if self.style == .groupBuy {
                let goodsInfoVc = XSGoodsInfoGroupBuyTicketViewController(style: self.style, merchantId:merchant_Id, goodId: goods.goodsId)
                topVC?.navigationController?.pushViewController(goodsInfoVc, animated: true)
            } else {
                let goodsInfoVc = TBDelievePrivateKitGoodsInfoVc(style: self.style, merchantId: merchant_Id
                                                            ,goodsId: goods.goodsId)
                topVC?.navigationController?.pushViewController(goodsInfoVc, animated: true)
            }
        }
    }
    
}
