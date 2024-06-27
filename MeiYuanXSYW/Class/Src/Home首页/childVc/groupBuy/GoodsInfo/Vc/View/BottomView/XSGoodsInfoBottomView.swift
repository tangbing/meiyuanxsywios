//
//  XSGoodsInfoBottomView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/19.
//

import UIKit
import JKSwiftExtension
import QMUIKit


protocol XSGoodsInfoBottomViewDelegate: NSObjectProtocol {
    func nowBuyBtnAction()
    func addCartBtnAction()
}

class XSGoodsInfoBottomView: UIView {
    weak var delegate: XSGoodsInfoBottomViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBottomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var finalPriceLabel: UILabel = {
        let ib = UILabel()
        ib.text = "¥28.5"
        ib.textColor = UIColor.hex(hexString: "#E61016")
        ib.font = MYFont(size: 14)
        ib.jk.setsetSpecificTextFont("28.5", font:MYBlodFont(size: 30))
        
        return ib
    }()
    
    lazy var previousPriceLabel: UILabel = {
        let ib = UILabel()
        ib.textColor = UIColor.hex(hexString: "#B3B3B3")
        ib.font = MYFont(size: 11)
        ib.text = "￥110"
        ib.jk.setSpecificTextDeleteLine("￥110", color: .twoText)
        return ib
    }()
    
    lazy var reducePrice : JKPaddingLabel = {
        let ib = JKPaddingLabel()
        ib.paddingLeft = 4
        ib.paddingRight = 4
        ib.paddingTop = 1
        ib.paddingBottom = 1
        ib.textColor = UIColor.hex(hexString: "#F11F16")
        ib.font = MYFont(size: 11)
        ib.text = "3.3折"
        ib.textAlignment = .center
        ib.hg_setAllCornerWithCornerRadius(radius: 4)
        ib.jk.addBorder(borderWidth: 1, borderColor: .red)
        return ib
    }()
    
    lazy var addCartBtn: QMUIButton = {
        let addCart = QMUIButton(type: .custom)
        addCart.setTitle("加入购物车", for: .normal)
        addCart.setTitleColor(UIColor.hex(hexString: "#F11F16"), for: .normal)
        addCart.titleLabel?.font = MYFont(size: 15)
        addCart.addTarget(self, action: #selector(addCartBtnAction), for: .touchUpInside)
        return addCart
    }()
    
    lazy var nowOrderBuyBtn: UIButton = {
        let nowBuy = UIButton(type: .custom)
        nowBuy.setTitle("立即购买", for: .normal)
        nowBuy.setTitleColor(.white, for: .normal)
        nowBuy.titleLabel?.font = MYFont(size: 15)
        nowBuy.addTarget(self, action: #selector(nowBuyBtnAction), for: .touchUpInside)

        return nowBuy
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addCartBtn.hg_setCorner(conrners: [UIRectCorner.topLeft,UIRectCorner.bottomLeft], radius: 22, borderColor: UIColor.hex(hexString: "#F11F16"))

        nowOrderBuyBtn.jk.addCorner(conrners: [UIRectCorner.topRight,UIRectCorner.bottomRight], radius: 22)
        nowOrderBuyBtn.hg_addGradientColor([UIColor.hex(hexString: "#F6094C"),
                                            UIColor.hex(hexString: "#FF724E")],
                                           size: CGSize(width: 111, height: 44),
                                           startPoint: CGPoint(x: 1, y: 0.57),
                                           endPoint: CGPoint(x: 0.57, y: 0.57))
    }
    
    
    
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: screenWidth, height: 65)
//    }
    
    
    func setupBottomView(){
        self.addSubview(finalPriceLabel)
        finalPriceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(4)
        }
        
        self.addSubview(previousPriceLabel)
        previousPriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.left.equalTo(finalPriceLabel.snp_right).offset(10)
        }
        
        self.addSubview(reducePrice)
        reducePrice.snp.makeConstraints { make in
            make.top.equalTo(previousPriceLabel.snp_bottom).offset(10)
            make.left.equalTo(finalPriceLabel.snp_right).offset(10)
        }
        
        self.addSubview(nowOrderBuyBtn)
        nowOrderBuyBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 111, height: 44))
        }
        
        self.addSubview(addCartBtn)
        addCartBtn.snp.makeConstraints { make in
            make.right.equalTo(nowOrderBuyBtn.snp_left).offset(0)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 111, height: 44))
            
        }
        
    }
}

// MARK: - event touch
extension XSGoodsInfoBottomView {
    @objc func nowBuyBtnAction() {
        self.delegate?.nowBuyBtnAction()
    }
    
    @objc func addCartBtnAction() {
        self.delegate?.addCartBtnAction()
    }
    
}
