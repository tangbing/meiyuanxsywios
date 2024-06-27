//
//  XSVipCollectItem.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
//券
class VipTicketItemView: UIView {
    //券背景图
    var ticketBackImg : UIImageView = {
        let tipImg = UIImageView()
        tipImg.image = UIImage(named: "vip_envelope_bg")
        return tipImg
    }()
    //券限购
    var countLab : UILabel={
        let countLab = UILabel()
        countLab.font = MYFont(size: 10)
        countLab.textColor = UIColor.hex(hexString: "#895D42")
        countLab.textAlignment = .center
        countLab.text = "限购1次"
        countLab.backgroundColor = UIColor.hex(hexString: "FFE5B6")
        countLab.hg_setCorner(conrner: [QMUICornerMask.layerMinXMinYCorner,QMUICornerMask.layerMaxXMaxYCorner], radius: 9)
        return countLab
    }()
    //券价格
    var priceLab : UILabel={
        let priceLab = UILabel()
        priceLab.font = MYBlodFont(size: 16)
        priceLab.textColor = UIColor.hex(hexString: "#895D42")
        priceLab.textAlignment = .center
        priceLab.text = "¥5x2张"
        priceLab.jk.setsetSpecificTextFont("5", font:MYBlodFont(size: 30))

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

        self.addSubview(countLab)
        countLab.snp.makeConstraints { make in
            make.left.top.equalTo(0)
            make.width.equalTo(46)
            make.height.equalTo(18)
        }
        
        self.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.right.bottom.left.equalTo(0)
            make.height.equalTo(self.snp_height).multipliedBy(0.3)
        }

        self.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(countLab.snp_bottom)
            make.bottom.equalTo(tipLab.snp_top)
        }

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/// 添加cell点击代理方法
protocol XSVipCollectItemDelegate:NSObjectProtocol {
    func clickBuy()
}


class XSVipCollectItem: XSBaseCollectionViewCell {
    weak var delegate : XSVipCollectItemDelegate?
    
    var clickBlock:(()->())?
    
    var model:CLAddPackageModel? {
        didSet {
            guard let newModel = model else { return }
            priceBtn.setTitle("\(newModel.discount)折抢购", for: UIControl.State.normal)
            priceLab.text = "¥\(newModel.discountAmt) ¥\(newModel.originalAmt)"
            priceLab.textColor = .twoText
            priceLab.font = MYBlodFont(size: 14)
            priceLab.jk.setSpecificTextColor("¥\(newModel.discountAmt)", color: .red)
            priceLab.jk.setsetSpecificTextFont("\(newModel.discountAmt)", font: MYBlodFont(size: 22))
            
            priceLab.jk.setsetSpecificTextFont("¥\(newModel.originalAmt)", font:MYFont(size: 11))
            priceLab.jk.setSpecificTextDeleteLine("¥\(newModel.originalAmt)", color: .twoText)
            
            ticketView.countLab.text = "限购\(newModel.buyLimit)次"

        }
    }

    var backView : UIView={
        let backView = UIView()
        backView.backgroundColor = .white
        return backView
    }()

    var ticketView : VipTicketItemView={
        let ticketView = VipTicketItemView()
        return ticketView
    }()
    //价格
    var priceLab : UILabel = {
        let priceLab = UILabel()
        //14 22 11
        priceLab.text = "¥8 ¥10"
        priceLab.textColor = .twoText
        priceLab.font = MYBlodFont(size: 14)
        priceLab.jk.setSpecificTextColor("¥8", color: .red)
        priceLab.jk.setsetSpecificTextFont("8", font: MYBlodFont(size: 22))
        
        priceLab.jk.setsetSpecificTextFont("¥10", font:MYFont(size: 11))
        priceLab.jk.setSpecificTextDeleteLine("¥10", color: .twoText)

        return priceLab
    }()
    //折扣
    var priceBtn : UIButton={
        let priceBtn = UIButton()
        priceBtn.setTitleColor(.red, for: UIControl.State.normal)
        priceBtn.setTitle("8折抢购", for: UIControl.State.normal)
        priceBtn.titleLabel?.font = MYFont(size: 10)
        priceBtn.hg_setAllCornerWithCornerRadius(radius: 4)
        priceBtn.jk.addBorder(borderWidth: 1, borderColor: .red)
        return priceBtn
    }()
    //购买
    var buyBtn : QMUIButton={
        let buyBtn = QMUIButton()
        buyBtn.setTitleColor(.white, for: UIControl.State.normal)
        buyBtn.setTitle("购买", for: UIControl.State.normal)
        buyBtn.titleLabel?.font = MYFont(size: 12)
        buyBtn.setImage(UIImage(named: "vip_shopping_cart"), for: UIControl.State.normal)
        buyBtn.hg_setAllCornerWithCornerRadius(radius: 13)
        buyBtn.setBackgroundImage(UIImage(named: "cartBackImg"), for: UIControl.State.normal)
        buyBtn.spacingBetweenImageAndTitle = 5
        return buyBtn
    }()

    override func configUI(){
//        contentView.backgroundColor = .background
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }

        backView.addSubview(ticketView)
        ticketView.snp.makeConstraints { make in
            make.top.left.right.equalTo(0)
            make.height.equalTo(100)
        }

        
        backView.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(ticketView.snp_bottom).offset(6)

        }
        backView.addSubview(priceBtn)
        priceBtn.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.centerY.equalTo(priceLab.snp_centerY)
            make.width.equalTo(48)
            make.height.equalTo(16)
        }

        backView.addSubview(buyBtn)
        buyBtn.add(self, action: #selector(clickBuyAction))
        buyBtn.snp.makeConstraints { make in
            make.top.equalTo(priceLab.snp_bottom).offset(6)
            make.left.equalTo(4)
            make.right.equalTo(-4)
            make.bottom.equalTo(-12)
            make.height.equalTo(26)
        }

    }
    @objc func clickBuyAction() {
//        delegate?.clickBuy()
        guard let action = clickBlock else { return }
        action()
    }

}
