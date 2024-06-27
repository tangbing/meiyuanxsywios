//
//  XSShopCartDelieveTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit
import QMUIKit


class XSShopCartDelieveTableViewCell: XSShopCartBaseTableViewCell {

   // weak var delegate: XSShopCartDelieveTableViewCellDelegate?
    
    lazy var ruleSelectBtn: QMUIButton = {
        let rule = QMUIButton(type: .custom)
        rule.imagePosition = .right
        rule.titleLabel?.numberOfLines = 1
        rule.setTitle("已选：椰子慕斯夹心提前一天预定；巧克力慕", for: .normal)
        rule.setImage(UIImage(named: "shopcart_icon_drop_down"), for: .normal)
        rule.spacingBetweenImageAndTitle = 5
        rule.setTitleColor(.text, for: .normal)
        rule.titleLabel?.font = MYFont(size: 12)
        rule.setBackgroundImage(UIColor.hex(hexString: "#F9F9F9").image(), for: .normal)
        rule.addTarget(self, action: #selector(ruleSelectBtnAction), for: .touchUpInside)
        return rule
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
            guard var model = self.delieveModel?.orderShoppingTrolleyVOList else { return }
            self.shopCartUpdateCount(style: .plus, model: model, merchantId: model.merchantId)

        }
        plusReduce.reduceBtnClickHandler = { [weak self] view in
            
            guard let self = self else { return }
            guard var model = self.delieveModel?.orderShoppingTrolleyVOList else { return }
            self.shopCartUpdateCount(style: .reduce, model: model, merchantId: model.merchantId)
        }
        
        return plusReduce
    }()

    
    lazy var priceView: XSCollectPriceView = {
        return XSCollectPriceView()
    }()
    
    override func bindingViewModel(viewModel: XSShopCartModelProtocol) {
        super.bindingViewModel(viewModel: viewModel)
        
        let delieveModel = viewModel as! XSShopCartDelieveModel
        self.delieveModel = delieveModel
        
        
        
    }


    var delieveModel: XSShopCartDelieveModel? {
        didSet {
            guard let model = delieveModel else {
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
            
            
            
            // 是否是有规则产品，只有外卖才有选规则产品
            if model.hasSelectStandard {
                ruleSelectBtn.isHidden = false
                discountMsgLabel.isHidden = true
                
                let selectStandardStr = "已选\(model.orderShoppingTrolleyVOList.specName),\(model.orderShoppingTrolleyVOList.attributesNameDetails)"
                ruleSelectBtn.setTitle(selectStandardStr, for: .normal)
            } else {
                ruleSelectBtn.isHidden = true
                discountMsgLabel.isHidden = false
            }
            
            merchIcon.snp.remakeConstraints { make in
                make.left.equalTo(loseSignLabel.isHidden ? selectBtn.snp_right : loseSignLabel.snp_right).offset(8)
                make.size.equalTo(CGSize(width: 90, height: 90))
                make.top.equalToSuperview().offset(10)
            }
            
        }
    }
    

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
            make.top.equalTo(ruleSelectBtn.snp_bottom).offset(4)
        }
        
        self.contentView.addSubview(plusReduceView)
        plusReduceView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(discountMsgLabel.snp_bottom).offset(4)
            make.height.equalTo(22)
            make.bottom.equalToSuperview().offset(-20)
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

// MARK: - event click
extension XSShopCartDelieveTableViewCell {
    @objc func ruleSelectBtnAction() {
        self.delegate?.showSelectStandard(self)
    }
}
