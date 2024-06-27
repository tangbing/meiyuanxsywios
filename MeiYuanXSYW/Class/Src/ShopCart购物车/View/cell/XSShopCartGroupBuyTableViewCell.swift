//
//  XSShopCartGroupBuyTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit
import QMUIKit

class XSShopCartGroupBuyTableViewCell: XSShopCartBaseTableViewCell {

    lazy var limitMsgLabel: UILabel = {
        let discount = UILabel()
        discount.textColor = .twoText
        discount.font = MYFont(size: 12)
        discount.text = "周一至周日 免预约 过期退 随时退备份"
        return discount
    }()
    
    lazy var discountMsgLabel: UILabel = {
        let discount = UILabel()
        discount.textColor = .king
        discount.font = MYFont(size: 12)
        discount.text = "促销 2件8折，3件7折"
        return discount
    }()
    
    lazy var ticketLabel: UILabel = {
        let ticket = UILabel()
        ticket.textColor = UIColor.hex(hexString: "#F11F16")
        ticket.font = MYFont(size: 12)
        ticket.text = "优惠 满200减30"
        return ticket
    }()
    
    lazy var plusReduceView: TBCartPlusReduceButtonView = {
        
        let plusReduce = TBCartPlusReduceButtonView()
        plusReduce.plusBtnClickHandler = { [weak self] view in
            
            guard let self = self else { return }
            guard var model = self.groupBuyModel?.orderShoppingTrolleyVOList else { return }
            self.shopCartUpdateCount(style: .plus, model: model, merchantId: model.merchantId)
            
        }
        plusReduce.reduceBtnClickHandler = { [weak self] view in
            
            guard let self = self else { return }
            guard var model = self.groupBuyModel?.orderShoppingTrolleyVOList else { return }
            self.shopCartUpdateCount(style: .reduce, model: model, merchantId: model.merchantId)
           
        }
        return plusReduce
    }()
    
    lazy var priceView: XSCollectPriceView = {
        return XSCollectPriceView()
    }()
    
    override func bindingViewModel(viewModel: XSShopCartModelProtocol) {
        super.bindingViewModel(viewModel: viewModel)
        
        let groupBuyModel = viewModel as! XSShopCartGroupBuyModel
        self.groupBuyModel = groupBuyModel
        
    }
    
    var groupBuyModel: XSShopCartGroupBuyModel? {
        didSet {
            guard let model = groupBuyModel else {
                return
            }
            
            if model.hasBottomRadius {
                self.contentView.hg_setCornerOnBottomWithRadius(radius: 10)
            }

            discountMsgLabel.text = model.orderShoppingTrolleyVOList.salePromotionStr
            plusReduceView.buyNum = model.orderShoppingTrolleyVOList.account
            
            priceView.finalPriceLabel.text = "¥\(model.orderShoppingTrolleyVOList.finalPrice)"
            priceView.previousPriceLabel.text = "¥\(model.orderShoppingTrolleyVOList.originPrice)"
            priceView.reduceDownPriceLabel.text = "¥\(model.orderShoppingTrolleyVOList.discount)"
            
            limitMsgLabel.text = model.orderShoppingTrolleyVOList.groupUseRuleStr
            
            merchIcon.snp.remakeConstraints { make in
                make.left.equalTo(loseSignLabel.isHidden ? selectBtn.snp_right : loseSignLabel.snp_right).offset(8)
                make.size.equalTo(CGSize(width: 90, height: 90))
                make.top.equalToSuperview().offset(10)
            }
        }
    }
    
    
    override func configUI() {
        super.configUI()
        ruleSelectBtnAction()
    }
    
    @objc func ruleSelectBtnAction() {
        
        self.contentView.addSubview(limitMsgLabel)
        limitMsgLabel.snp.makeConstraints { make in
            make.left.equalTo(merchNameLabel.snp_left).offset(0)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(12)
            make.top.equalTo(merchNameLabel.snp_bottom).offset(4)
        }
        
        self.contentView.addSubview(discountMsgLabel)
        discountMsgLabel.snp.makeConstraints { make in
            make.left.equalTo(merchNameLabel)
            make.top.equalTo(limitMsgLabel.snp_bottom).offset(4)
        }
        
        self.contentView.addSubview(ticketLabel)
        ticketLabel.snp.makeConstraints { make in
            make.left.equalTo(merchNameLabel)
            make.top.equalTo(discountMsgLabel.snp_bottom).offset(4)
        }
        
        self.contentView.addSubview(plusReduceView)
        plusReduceView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(ticketLabel.snp_bottom).offset(4)
            make.height.equalTo(22)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self.contentView.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.left.equalTo(merchNameLabel)
            make.centerY.equalTo(plusReduceView)
            make.height.equalTo(18)
            make.right.equalTo(plusReduceView.snp_left).offset(10)
        }
        
        
    }


}

