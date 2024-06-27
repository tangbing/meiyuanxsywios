//
//  TBGoodsInfoTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/15.
//

import UIKit
import QMUIKit

class TBGoodsInfoTableViewCell: XSBaseTableViewCell {
    
    var addCartBtnClickHandler: ((_ goodsItem: TBTakeoutGoodsItem) -> Void)?
    
    
    var voucherGoodsItem: TBVoucherGoodsItem?  {
        didSet {
            guard let voucherGoodsModel = voucherGoodsItem else { return }
            
            configGoodsInfoTicketUI()
            
            nameLab.text = voucherGoodsModel.goodsName
         
            evaluatView.layoutWithtags(tags: voucherGoodsModel.tagName, praise: "\(voucherGoodsModel.praise)%好评率")
            
            priveView.configGoodsInfoKillSecond(color: UIColor.hex(hexString: "#F11F16"))
            
            priveView.finalPriceLabel.text = "¥\(voucherGoodsModel.finalPrice)"
            priveView.finalPriceLabel.jk.setsetSpecificTextFont("¥", font:MYBlodFont(size: 18))
            priveView.finalPriceLabel.jk.setsetSpecificTextFont("\(voucherGoodsModel.finalPrice)", font:MYBlodFont(size: 28))
            
            priveView.previousPriceLabel.text = "¥\(voucherGoodsModel.originalPrice)"
            priveView.reduceDownPriceLabel.text = "\(voucherGoodsModel.discountRate)折"
            
            numLab.text = "已售\(voucherGoodsModel.monthlySales)"
            
            serviceView.layoutWithtags(tags: voucherGoodsModel.serviceDesc, praise: nil)
            serviceView.themeColor = .text
            
        }
    }
    
    var groupBuyItem: TBGroupBuyGoodsItem? {
        didSet {
            guard let groupBuyModel = groupBuyItem else { return }
            
            configGoodsInfoTicketUI()
            
            nameLab.text = groupBuyModel.goodsName
         
            evaluatView.layoutWithtags(tags: groupBuyModel.tagName, praise: "\(groupBuyModel.praise)%好评率")
            
            priveView.configGoodsInfoKillSecond(color: UIColor.hex(hexString: "#F11F16"))
            
            priveView.finalPriceLabel.text = "¥\(groupBuyModel.finalPrice)"
            priveView.finalPriceLabel.jk.setsetSpecificTextFont("¥", font:MYBlodFont(size: 18))
            priveView.finalPriceLabel.jk.setsetSpecificTextFont("\(groupBuyModel.finalPrice)", font:MYBlodFont(size: 28))
            
            priveView.previousPriceLabel.text = "¥\(groupBuyModel.originalPrice)"
            priveView.reduceDownPriceLabel.text = "\(groupBuyModel.discountRate)折"
            
            numLab.text = "已售\(groupBuyModel.monthlySales)"
            
            serviceView.layoutWithtags(tags: groupBuyModel.serviceDesc, praise: nil)
            serviceView.themeColor = .text
        }
    }
    
    var goodsItem: TBTakeoutGoodsItem? {
        didSet {
            guard let goodsModel = goodsItem else { return }
            serviceView.isHidden = true

            
            nameLab.text = goodsModel.goodsName
         
            evaluatView.layoutWithtags(tags: goodsModel.tagName, praise: "\(goodsModel.praise)%好评率")
            
            priveView.configGoodsInfoKillSecond(color: UIColor.hex(hexString: "#F11F16"))
            
            priveView.finalPriceLabel.text = "¥\(goodsModel.finalPrice)"
            priveView.finalPriceLabel.jk.setsetSpecificTextFont("¥", font:MYBlodFont(size: 18))
            priveView.finalPriceLabel.jk.setsetSpecificTextFont("\(goodsModel.finalPrice)", font:MYBlodFont(size: 28))
            
            priveView.previousPriceLabel.text = "¥\(goodsModel.originalPrice)"
            priveView.reduceDownPriceLabel.text = "\(goodsModel.discountRate)折"
            
            numLab.text = "月销\(goodsModel.monthlySales)"
            
            if goodsModel.preLimit > 0 {
                limitBuyLab.text = "限\(goodsModel.preLimit)份"
            } else {
                limitBuyLab.text = "不限购"
            }
            
        }
    }

    lazy var containView: UIView = {
        let contain = UIView()
        contain.hg_setAllCornerWithCornerRadius(radius: 10)
        contain.backgroundColor = .white
        return contain
    }()
    
    //商家名称加标签
    lazy var nameLab : UILabel={
        let nameLab = UILabel()
        nameLab.numberOfLines = 1
        nameLab.font = MYBlodFont(size: 16)
        nameLab.textColor = .text
        let str = "商家名称商家名称商家名称商家名称"
        nameLab.text = str
        return nameLab
    }()
    
    //
    lazy var numLab : UILabel={
        let name = UILabel()
        name.font = MYFont(size: 12)
        name.textColor = .twoText
        let str = "月销4,785"
        name.text = str
        return name
    }()
    
    /// 广东菜 鸡煲 晚餐
    lazy var evaluatView: XSCollectHightEvaluatView = {
        let evaluatView = XSCollectHightEvaluatView()
        return evaluatView
    }()
    
    lazy var serviceView: XSCollectHightEvaluatView  = {
        let evaluatView = XSCollectHightEvaluatView()
        //evaluatView.configMerchInfo()
        evaluatView.themeColor = .text
        return evaluatView
    }()
    
    
//    //榜单
//    lazy var rankBtn : QMUIButton = {
//        let rankBtn = QMUIButton()
//        rankBtn.titleLabel?.font = MYFont(size: 10)
//        rankBtn.setTitle("罗湖区热评榜第1名", for: UIControl.State.normal)
//        rankBtn.setTitleColor(.warn, for: UIControl.State.normal)
//        rankBtn.setImage(UIImage(named: "vip_Reviews_HotList"), for: UIControl.State.normal)
//        rankBtn.backgroundColor = UIColor.hex(hexString: "FFFCF1")
//        rankBtn.imagePosition = QMUIButtonImagePosition.left
//        rankBtn.jk.addBorder(borderWidth: 0.5, borderColor: .warn)
//        rankBtn.contentEdgeInsets = UIEdgeInsets.init(top: 1, left: 2, bottom: 1, right: 4)
//        rankBtn.hg_setAllCornerWithCornerRadius(radius: 5)
//        return rankBtn
//    }()
    
    
    lazy var addCartBtn: UIButton = {
        let addCart = UIButton(type: .custom)
        addCart.setTitle("加入购物车", for: .normal)
        addCart.setTitleColor(.white, for: .normal)
        addCart.titleLabel?.font = MYFont(size: 15)
        addCart.addTarget(self, action: #selector(addCartBtnClick), for: .touchUpInside)
        addCart.hg_setAllCornerWithCornerRadius(radius: 15)
        addCart.hg_addGradientColor([UIColor(red: 0.96, green: 0.04, blue: 0.3, alpha: 1),
                                     UIColor(red: 1, green: 0.45, blue: 0.31, alpha: 1)],
                                        size: CGSize(width: 100, height: 30),
                                        startPoint: CGPoint(x: 1, y: 1), endPoint: CGPoint(x: 0.04, y: 0.04))
        return addCart
    }()
    
    lazy var limitBuyTitleLab: UILabel = {
        let label = UILabel()
        label.text = "限购"
        label.textAlignment = .center
        label.font = MYFont(size: 10)
        label.textColor = UIColor.hex(hexString: "#979797")
        label.backgroundColor = UIColor.hex(hexString: "#F5F5F5")
        label.hg_setAllCornerWithCornerRadius(radius: 8)
        return label
    }()
    
    lazy var limitBuyLab: UILabel = {
        let label = UILabel()
        label.text = "限1份"
        label.font = MYFont(size: 12)
        label.textColor = UIColor.text
        return label
    }()
    
    
    
    lazy var priveView: XSCollectPriceView = {
        let priveView = XSCollectPriceView()
        return priveView
    }()
    
    func configGoodsInfoTicketUI() {

        limitBuyTitleLab.backgroundColor = UIColor.hex(hexString: "#FFF3F5")
        limitBuyTitleLab.text = "服务"
        limitBuyTitleLab.textColor = UIColor.hex(hexString: "#FA6059")
        
        limitBuyLab.isHidden = true
        addCartBtn.isHidden = limitBuyLab.isHidden
    }
    
    @objc func addCartBtnClick() {
        
        if let item = goodsItem {
            self.addCartBtnClickHandler?(item)
        }
        
    }
    
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(containView)
        containView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        containView.addSubview(numLab)
        numLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            
        }
        
        containView.addSubview(priveView)
        priveView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.right.equalTo(numLab.snp_left).offset(-10)
            make.height.equalTo(26)
        }
        
        containView.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.top.equalTo(priveView.snp_bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        containView.addSubview(evaluatView)
        evaluatView.snp.makeConstraints { make in
            make.top.equalTo(nameLab.snp_bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(17)
        }
        
//        containView.addSubview(rankBtn)
//        rankBtn.snp.makeConstraints { make in
//            make.top.equalTo(evaluatView.snp_bottom).offset(10)
//            make.left.equalToSuperview().offset(10)
//            make.height.equalTo(13)
//        }
        
        containView.addSubview(addCartBtn)
        addCartBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 30))
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        containView.addSubview(limitBuyTitleLab)
        limitBuyTitleLab.snp.makeConstraints { make in
            make.left.equalTo(nameLab)
            make.top.equalTo(evaluatView.snp_bottom).offset(10)
            make.size.equalTo(CGSize(width: 31, height: 16))
            make.bottom.equalToSuperview().offset(-15)
        }
        
        containView.addSubview(limitBuyLab)
        limitBuyLab.snp.makeConstraints { make in
            make.left.equalTo(limitBuyTitleLab.snp_right).offset(5)
            make.centerY.equalTo(limitBuyTitleLab)
        }
        
        containView.addSubview(serviceView)
        serviceView.snp.makeConstraints { make in
            make.left.equalTo(limitBuyTitleLab.snp_right).offset(5)
            make.centerY.equalTo(limitBuyTitleLab)
            make.height.equalTo(17)
        }
          
        
    }

}
