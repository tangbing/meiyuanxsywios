//
//  TBCartMerchInfoPopCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/12.
//

import UIKit

class TBCartMerchInfoPopCell: XSBaseTableViewCell {
    
    var merchantId: String = ""
    
    var reduceBtnZeroHandler: ((_ popCell: TBCartMerchInfoPopCell) -> Void)?
    
    var cartModel: OrderShoppingTrolleyVOList? {
        didSet {
            guard let model = cartModel else {
                return
            }
            
            merchNameLabel.text = model.goodsName
            merchIcon.xs_setImage(urlString: model.topPic, placeholder: UIImage.placeholder)
            
            merchStandardLabel.text = model.specName + "/" + model.attributesNameDetails
            
            priveView.finalPriceLabel.text = "￥\(model.finalPrice)"

            priveView.previousPriceLabel.text = "￥\(model.originPrice)"
            priveView.previousPriceLabel.isHidden = (model.finalPrice == model.originPrice)
            priveView.reduceDownPriceLabel.isHidden = true
            
            plusReduceView.buyNum = UInt(model.account)
            
        }
    }

    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.hg_setAllCornerWithCornerRadius(radius: 5)
        iv.image = #imageLiteral(resourceName: "login_LOGO")
        return iv
    }()
    
    
    lazy var priveView: XSCollectPriceView = {
        let priveView = XSCollectPriceView()
        return priveView
    }()
    
    lazy var merchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "【康美甄】营养餐"
        label.textColor = .text
        label.font = MYBlodFont(size: 16)
        return label
    }()
    
    lazy var merchStandardLabel: UILabel = {
        let label = UILabel()
        label.text = "商品规格"
        label.textColor = .twoText
        label.font = MYBlodFont(size: 12)
        return label
    }()
    
    lazy var plusReduceView: TBCartPlusReduceButtonView = {
        let button = TBCartPlusReduceButtonView()
        button.reduceBtnClickHandler = { [weak self] buttonView in
            guard var model = self?.cartModel else { return }
            
            let count = model.account - 1
            let goodsId = model.goodsId
            let merchantId = model.merchantId
            
            print("account: \(count)")
            MerchantInfoProvider.request(.updateShoppingTrolleyCountById(count, id: model.id, merchantId: merchantId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
                
                guard let self = self else { return }
                
                if (returnData?.trueOrFalse ?? 0) == 0 {
                   
                    model.account -= 1
                    
                    self.reduceBtnZeroHandler?(self)
                    
                    NotificationCenter.default.post(name: NSNotification.Name.XSCartMerchInfoPopCellReduceBtnClickNotification, object: self, userInfo: ["OrderShoppingTrolleyVOList" : model])

                }
            } errorResult: { errorMsg in
                uLog(errorMsg)
                XSTipsHUD.showText(errorMsg)
            }
       }
        
        button.plusBtnClickHandler = { [weak self] buttonView in
            guard let self = self else { return }
          
            guard var model = self.cartModel else { return }
            
            let count = model.account + 1
            let goodsId = model.goodsId
            
            MerchantInfoProvider.request(.updateShoppingTrolleyCountById(count, id: model.id, merchantId: model.merchantId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
                
                guard let self = self else { return }
                
                if (returnData?.trueOrFalse ?? 0) == 0 {
                   
                    model.account += 1
                    
                    NotificationCenter.default.post(name: NSNotification.Name.XSCartMerchInfoPopCellplusBtnClickNotification, object: self, userInfo: ["OrderShoppingTrolleyVOList" : model])

                }
            } errorResult: { errorMsg in
                uLog(errorMsg)
                XSTipsHUD.showText(errorMsg)
            }
        }
        
        
        return button
    }()
    
    override func configUI() {
        
        self.contentView.addSubview(merchIcon)
        merchIcon.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(100)
            /// multipliedBy, 120 * 0.75 , dividedBy , 直接除以一个数值
        }
        
        self.contentView.addSubview(merchNameLabel)
        merchNameLabel.snp.makeConstraints { make in
            make.left.equalTo(merchIcon.snp_right).offset(10)
            make.top.equalTo(merchIcon)
        }
        
        self.contentView.addSubview(merchStandardLabel)
        merchStandardLabel.snp.makeConstraints { make in
            make.left.equalTo(merchNameLabel)
            make.top.equalTo(merchNameLabel.snp_bottom).offset(5)
        }
        
        self.contentView.addSubview(plusReduceView)
        plusReduceView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview()
            make.height.equalTo(22)
        }
        
        self.contentView.addSubview(priveView)
        priveView.snp.makeConstraints { make in
            make.left.equalTo(merchNameLabel)
            make.bottom.equalToSuperview()
            make.height.equalTo(18)
            make.right.equalTo(plusReduceView.snp_left).offset(10)
        }
        
      
    }


}
