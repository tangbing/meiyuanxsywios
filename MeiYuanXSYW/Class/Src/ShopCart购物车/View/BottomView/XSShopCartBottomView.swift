//
//  XSShopCartBottomView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/23.
//

import UIKit
import QMUIKit

///// 总优惠
//class XSShopCartBottomTotalDiscount: TBBaseView {
//
////    lazy var totalTitleDiscountLabel: UILabel = {
////        let lab = UILabel()
////        lab.text = "总优惠："
////        lab.textColor = .twoText
////        lab.font = MYFont(size: 12)
////        return lab
////    }()
////
////    lazy var caculTotalDiscountLabel: UILabel = {
////        let lab = UILabel()
////        lab.text = "¥0.00"
////        lab.backgroundColor = .clear
////        lab.textColor = UIColor.hex(hexString: "#E61016")
////        lab.font = MYBlodFont(size: 18)
////        return lab
////    }()
//
////    lazy var checkBtn: QMUIButton = {
////        let check = QMUIButton(type: .custom)
////        check.setImage(UIImage(named: "shopcart_icon_drop_down_red"), for: .normal)
////        check.setImage(UIImage(named: "shopcart_icon_drop_down_red"), for: .selected)
////        check.setTitle("查看", for: .normal)
////        check.imagePosition = .right
////        check.spacingBetweenImageAndTitle = 0
////        check.setTitleColor(UIColor.hex(hexString: "#E61016"), for: .normal)
////        check.titleLabel?.font = MYFont(size: 12)
////        return check
////    }()
//
//    override func configUI() {
//        super.configUI()
//
//        self.addSubview(checkBtn)
//        checkBtn.snp.makeConstraints { make in
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-2)
//            make.size.equalTo(CGSize(width: 48, height: 16))
//        }
//
//        self.addSubview(caculTotalDiscountLabel)
//        caculTotalDiscountLabel.snp.makeConstraints { make in
//            make.bottom.equalToSuperview()
//            make.right.equalTo(checkBtn.snp_left).offset(-4)
//            make.top.equalToSuperview().offset(0)
//        }
//
//        self.addSubview(totalTitleDiscountLabel)
//        totalTitleDiscountLabel.snp.makeConstraints { make in
//            make.right.equalTo(caculTotalDiscountLabel.snp_left).offset(-4)
//            make.bottom.equalToSuperview().offset(-2)
//        }
//    }
//
//
//}


class XSShopCartBottomView: TBBaseView {
    
    var selectAllBlock: ((_ isSelect: Bool) -> Void)?
    var clickAllOrderBlock: (() -> Void)?
    var multSelectActionBlock: (() -> Void)?

    
    
    lazy var selectAll: QMUIButton = {
        let all = QMUIButton(type: .custom)
        all.setImage(UIImage(named: "mine_tick_normal"), for: .normal)
        all.setImage(UIImage(named: "mine_tick_selected"), for: .selected)
        all.setTitle("全选", for: .normal)
        all.spacingBetweenImageAndTitle = 5
        all.setTitleColor(.text, for: .normal)
        all.titleLabel?.font = MYBlodFont(size: 18)
        all.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
        return all
    }()
    
   
    
    lazy var closeAccount: TBSubTitleButton = {
        let nowBuy = TBSubTitleButton()
        nowBuy.setTitle("一键结算", for: .normal)
        nowBuy.setTitleColor(.white, for: .normal)
        nowBuy.titleLabel?.font = MYBlodFont(size: 15)
        nowBuy.addTarget(self, action: #selector(allOrderAction), for: .touchUpInside)
        nowBuy.hg_setAllCornerWithCornerRadius(radius: 22)
        nowBuy.hg_addGradientColor([UIColor.hex(hexString: "#F6094C"),
                                            UIColor.hex(hexString: "#FF724E")],
                                           size: CGSize(width: 111, height: 44),
                                           startPoint: CGPoint(x: 1, y: 0.57),
                                           endPoint: CGPoint(x: 0.57, y: 0.57))

        return nowBuy
    }()
    
    
    lazy var deleteBtn: UIButton = {
        let nowBuy = UIButton()
        nowBuy.setTitle("删除", for: .normal)
        nowBuy.setTitleColor(.white, for: .normal)
        nowBuy.titleLabel?.font = MYFont(size: 15)
        nowBuy.isHidden = true
        nowBuy.addTarget(self, action: #selector(multselectAction), for: .touchUpInside)
        nowBuy.hg_setAllCornerWithCornerRadius(radius: 22)
        nowBuy.hg_addGradientColor([UIColor.hex(hexString: "#EFCB9C"),
                                            UIColor.hex(hexString: "#E8C089")],
                                           size: CGSize(width: 111, height: 44),
                                           startPoint: CGPoint(x: 0.03, y: 0.15),
                                           endPoint:  CGPoint(x: 0.8, y: 0.8))

        return nowBuy
    }()
    
    lazy var caculTotalPriceLabel: UILabel = {
        let lab = UILabel()
        lab.text = "¥0.00"
        lab.textColor = .text
        lab.font = MYBlodFont(size: 12)
        return lab
    }()
    
    lazy var totalTitlePriceLabel: UILabel = {
        let lab = UILabel()
        lab.text = "合计："
        lab.textColor = .twoText
        lab.font = MYFont(size: 12)
        return lab
    }()
    
//    lazy var totalDiscount: XSShopCartBottomTotalDiscount = {
//        let check = XSShopCartBottomTotalDiscount()
//        check.isHidden = true
//        check.checkBtn.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
//        return check
//    }()
    
    lazy var totalDiscount: UILabel = {
        let msgLabel = UILabel()
        msgLabel.text = "优惠金额见查看界面"
        msgLabel.textColor = UIColor.red
        msgLabel.font = MYFont(size: 12)
        return msgLabel
    }()
    
    func configOnlyDelete(isShowDelete deleteShow: Bool){
        self.deleteBtn.isHidden = deleteShow
        
        self.closeAccount.isHidden = !deleteShow
        caculTotalPriceLabel.isHidden = !deleteShow
        totalTitlePriceLabel.isHidden = !deleteShow
    }
    
    func configSelectState(select isSelect: Bool, closeAccountSubTitle: String){
     
        closeAccount.subTitleText = isSelect ? closeAccountSubTitle : nil
    }
    
    @objc func allOrderAction() {
        clickAllOrderBlock?()
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: screenWidth, height: 65)
    }

    override func configUI() {
        super.configUI()
        self.backgroundColor = .white
        
        addSubview(selectAll)
        selectAll.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: intrinsicContentSize.height))
        }
        
        self.addSubview(closeAccount)
        closeAccount.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 111, height: 44))
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 111, height: 44))
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(totalDiscount)
        totalDiscount.snp.makeConstraints { make in
            make.bottom.equalTo(closeAccount)
            make.height.equalTo(24)
            make.right.equalTo(closeAccount.snp_left).offset(-20)
            make.left.equalTo(selectAll.snp_right).offset(30)
        }

        self.addSubview(caculTotalPriceLabel)
        caculTotalPriceLabel.snp.makeConstraints { make in
            make.right.equalTo(closeAccount.snp_left).offset(-20)
            make.bottom.equalTo(totalDiscount.snp_top).offset(-4)
        }
        
        self.addSubview(totalTitlePriceLabel)
        totalTitlePriceLabel.snp.makeConstraints { make in
            make.right.equalTo(caculTotalPriceLabel.snp_left).offset(-2)
            make.centerY.equalTo(caculTotalPriceLabel)
        }
        
        let line = lineView(bgColor: UIColor.hex(hexString: "#EBEBEB"))
        addSubview(line)
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.left.right.equalToSuperview()
        }
        
        
    }
    
}

// MARK: - event touch
extension XSShopCartBottomView {
    @objc func selectAllAction(_ button: UIButton) {
        button.isSelected = !button.isSelected
        self.selectAllBlock?(button.isSelected)
    }
    
    @objc func multselectAction() {
        self.multSelectActionBlock?()
    }
}
