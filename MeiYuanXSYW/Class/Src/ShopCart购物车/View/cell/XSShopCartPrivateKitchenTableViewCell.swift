//
//  XSShopCartPrivateKitchenTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit
import QMUIKit


class XSShopCartPrivateKitchenTableViewCell: XSShopCartBaseTableViewCell {

//    lazy var selectBtn: UIButton = {
//        let all = UIButton(type: .custom)
//        all.setImage(UIImage(named: "mine_tick_normal"), for: .normal)
//        all.setImage(UIImage(named: "mine_tick_selected"), for: .selected)
//        all.setTitleColor(.text, for: .normal)
//        all.titleLabel?.font = MYBlodFont(size: 18)
//        all.addTarget(self, action: #selector(selectBtnAction(select:)), for: .touchUpInside)
//        return all
//    }()
//
//    lazy var merchIcon: UIImageView = {
//        let iv = UIImageView()
//        //iv.contentMode = .scaleToFill
//        iv.hg_setAllCornerWithCornerRadius(radius: 5)
//        iv.image = UIImage(named: "group buy_picture4")
//        return iv
//    }()
//
//    lazy var merchNameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "康美甄营养餐菜品名称"
//        label.textColor = .twoText
//        label.font = MYBlodFont(size: 16)
//        return label
//    }()
//
    
    var goodsId = ""
    var merchantId = ""
    
    lazy var ruleSelectBtn: QMUIButton = {
        let rule = QMUIButton(type: .custom)
        rule.imagePosition = .right
        rule.titleLabel?.numberOfLines = 1
        rule.setTitle("已选：椰子慕斯夹心提前一天预定；巧克力慕", for: .normal)
        rule.setImage(UIImage(named: "shopcart_icon_drop_down"), for: .normal)
        rule.spacingBetweenImageAndTitle = 5
        rule.contentHorizontalAlignment = .left
        rule.setTitleColor(.text, for: .normal)
        rule.titleLabel?.font = MYFont(size: 12)
        rule.setBackgroundImage(UIColor.hex(hexString: "#F9F9F9").image(), for: .normal)
        rule.addTarget(self, action: #selector(ruleSelectBtnAction), for: .touchUpInside)
        return rule
    }()
    
    override func bindingViewModel(viewModel: XSShopCartModelProtocol) {
        super.bindingViewModel(viewModel: viewModel)
        
        let privateModel = viewModel as! XSShopCartPrivateKitchenModel
        self.privateModel = privateModel
        
    }
    
    var privateModel : XSShopCartPrivateKitchenModel? {
        didSet {
            guard let model = privateModel else {
                return
            }

            if model.hasBottomRadius {
                self.contentView.hg_setCornerOnBottomWithRadius(radius: 10)
            }
            
            goodsId = model.orderShoppingTrolleyVOList.goodsId
            
            discountMsgLabel.text = model.orderShoppingTrolleyVOList.salePromotionStr
            plusReduceView.buyNum = model.orderShoppingTrolleyVOList.account
            
            priceView.finalPriceLabel.text = "¥\(model.orderShoppingTrolleyVOList.finalPrice)"
            priceView.previousPriceLabel.text = "¥\(model.orderShoppingTrolleyVOList.originPrice)"
            priceView.reduceDownPriceLabel.text = "¥\(model.orderShoppingTrolleyVOList.discount)"
            
            
            if model.hasSelectRule {
                ruleSelectBtn.isHidden = false
                discountMsgLabel.isHidden = true
                ticketLabel.isHidden = true
                
                let selectStandardStr = "已选\(model.orderShoppingTrolleyVOList.specName),\(model.orderShoppingTrolleyVOList.attributesNameDetails)"
                ruleSelectBtn.setTitle(selectStandardStr, for: .normal)
                
            } else {
                ruleSelectBtn.isHidden = true
                discountMsgLabel.isHidden = false
                ticketLabel.isHidden = false
            }
            

            
//            if model.hasTicket {
//                ruleSelectBtn.isHidden = true
//                discountMsgLabel.isHidden = false
//                ticketLabel.isHidden = false
//            } else {
//                ruleSelectBtn.isHidden = true
//                discountMsgLabel.isHidden = false
//                ticketLabel.isHidden = true
//            }
            
          
            
        }
    }
    
    lazy var ticketLabel: UILabel = {
        let ticket = UILabel()
        ticket.textColor = UIColor.hex(hexString: "#F11F16")
        ticket.font = MYFont(size: 12)
        ticket.text = "优惠 满200减30"
        return ticket
    }()
    
    
    lazy var discountMsgLabel: UILabel = {
        let discount = UILabel()
        discount.textColor = .king
        discount.font = MYFont(size: 12)
        discount.text = "促销 2件8折，3件7折"
        return discount
    }()
    
    lazy var plusReduceView: TBCartPlusReduceButtonView = {
        let plusReduce = TBCartPlusReduceButtonView()
        plusReduce.plusBtnClickHandler = { [weak self] view in
            
            guard let self = self else { return }
            guard var model = self.privateModel?.orderShoppingTrolleyVOList else { return }
            self.shopCartUpdateCount(style: .plus, model: model, merchantId: model.merchantId)
        }
        
        plusReduce.reduceBtnClickHandler = { [weak self] view in
            
            guard let self = self else { return }
            guard var model = self.privateModel?.orderShoppingTrolleyVOList else { return }
            self.shopCartUpdateCount(style: .reduce, model: model, merchantId: model.merchantId)
            
        }
            
        return plusReduce
    }()
    
    lazy var priceView: XSCollectPriceView = {
        return XSCollectPriceView()
    }()
    
    
    
    override func configUI() {
        super.configUI()

        self.contentView.addSubview(ruleSelectBtn)
        ruleSelectBtn.snp.makeConstraints { make in
            make.left.equalTo(merchNameLabel.snp_left).offset(0)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(22)
            make.top.equalTo(merchNameLabel.snp_bottom).offset(4)
        }

        self.contentView.addSubview(discountMsgLabel)
        discountMsgLabel.snp.makeConstraints { make in
            make.left.equalTo(merchNameLabel)
            make.top.equalTo(merchNameLabel.snp_bottom).offset(4)
            //make.height.equalTo(13)
        }
        
        self.contentView.addSubview(ticketLabel)
        ticketLabel.snp.makeConstraints { make in
            make.left.equalTo(discountMsgLabel)
            make.top.equalTo(discountMsgLabel.snp_bottom).offset(4)
        }
        
        self.contentView.addSubview(plusReduceView)
        plusReduceView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(22)
        }
        
        self.contentView.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.left.equalTo(merchNameLabel)
            make.centerY.equalTo(plusReduceView)
            make.height.equalTo(18)
            make.right.equalTo(plusReduceView.snp_left).offset(10)
        }
        
        
    }
    
//    @objc func selectBtnAction(select button: QMUIButton) {
//
//    }


}

// MARK: - event click
extension XSShopCartPrivateKitchenTableViewCell {
    @objc func ruleSelectBtnAction() {
        
        MerchantInfoProvider.request(.getGoodsSpecsAttributes(_merchantId: merchantId, goodsId: goodsId), model: XSGoodsSpecsAttributesModel.self) { returnData in
            if let goodsSpecAttributeModel = returnData,
               let shopOrder = self.privateModel?.orderShoppingTrolleyVOList {
                let selectStandard = TBSelectStandardPopView()
                selectStandard.configData(goodsSpecAttributeModel: goodsSpecAttributeModel,orderShop:shopOrder)
                selectStandard.show()
            }
            
        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            uLog(errorMsg)
        }

        
        
        
    }
}

