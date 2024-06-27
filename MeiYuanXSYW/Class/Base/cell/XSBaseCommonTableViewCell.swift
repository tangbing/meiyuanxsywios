//
//  XSBaseCommonTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/23.
//

import UIKit
import QMUIKit

/// 添加cell点击代理方法
protocol XSVipMerchantCellDelegate:NSObjectProtocol {
    func clickInsetMerchant()//进店
    func clickTicketExchange()//兑换券
}

class VipNameIcon: UIStackView {
    let icon : UIImageView={
        let icon = UIImageView()
        icon.image = UIImage(named: "vip_Takeaway")
        return icon
    }()
    let icon2 : UIImageView={
        let icon = UIImageView()
        icon.image = UIImage(named: "vip_Toshop")
        return icon
    }()
    
    let icon3 : UIImageView={
        let icon = UIImageView()
        icon.image = UIImage(named: "vip_private_kitchen")
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        alignment = .fill
        distribution = .fillProportionally
        spacing = 5
        addArrangedSubview(icon)
        addArrangedSubview(icon2)
        addArrangedSubview(icon3)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//评分、销量、均价行布局
class VipScoreView: UIView {
    ///评分
    var scoreIcon : UIImageView = {
        let scoreIcon = UIImageView()
        scoreIcon.image = UIImage(named: "vip_score")
        return scoreIcon
    }()
    //评分
    var scoreLab : UILabel={
        let scoreLab = UILabel()
        scoreLab.font = MYFont(size: 12)
        scoreLab.textColor = .warn
        scoreLab.text = "4.9分"
        return scoreLab
    }()

    //销量
    var saleLab : UILabel={
        let saleLab = UILabel()
        saleLab.font = MYFont(size: 12)
        saleLab.textColor = .twoText
        saleLab.text = "月销2566"
        return saleLab
    }()
    //均价
    var priceLab : UILabel={
        let priceLab = UILabel()
        priceLab.font = MYFont(size: 11)
        priceLab.textColor = .twoText
        priceLab.text = "人均¥25"
        return priceLab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(scoreIcon)
        scoreIcon.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.width.height.equalTo(12)
            make.centerY.equalToSuperview()
        }

        self.addSubview(scoreLab)
        scoreLab.snp.makeConstraints { make in
            make.bottom.top.equalTo(0)
            make.left.equalTo(scoreIcon.snp_right).offset(2)
        }
        
        self.addSubview(saleLab)
        saleLab.snp.makeConstraints { make in
            make.bottom.top.equalTo(0)
            make.left.equalTo(scoreLab.snp_right).offset(10)
        }

        self.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.bottom.top.equalTo(0)
            make.left.equalTo(saleLab.snp_right).offset(10)
        }

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//起送，配送费
class VipPriceView: UIView {
    //起送
    var startPriceLab : UILabel={
        let startPriceLab = UILabel()
        startPriceLab.font = MYFont(size: 11)
        startPriceLab.textColor = .twoText
        startPriceLab.text = "起送¥20"
        return startPriceLab
    }()
    
    var lineView : UIView = {
       let lineView = UIView()
        lineView.backgroundColor = .twoText
        return lineView
    }()
    
    //配送费
    var priceLab : UILabel={
        let priceLab = UILabel()
        priceLab.font = MYFont(size: 11)
        priceLab.textColor = .twoText
        priceLab.text = "免费配送"
        return priceLab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(startPriceLab)
        startPriceLab.snp.makeConstraints { make in
            make.left.bottom.top.equalTo(0)
        }

        self.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.bottom.top.equalTo(0)
            make.left.equalTo(startPriceLab.snp_right).offset(8)
            make.width.equalTo(1)
        }

        self.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.bottom.top.equalTo(0)
            make.left.equalTo(lineView).offset(8)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//时间距离
class VipTimeView: UIView {
    //时间
    var timeLab : UILabel={
        let timeLab = UILabel()
        timeLab.font = MYFont(size: 11)
        timeLab.textColor = .twoText
        timeLab.text = "28分钟 0.9km"
        timeLab.textAlignment = .right
        return timeLab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(timeLab)
        timeLab.snp.makeConstraints { make in
            make.right.bottom.top.equalTo(0)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class XSBaseCommonTableViewCell: XSBaseTableViewCell {
    
    var enterShopBlock:(()->())?


    weak var delegate : XSVipMerchantCellDelegate?

    lazy var backView : UIView={
        let backView = UIView()
        backView.isUserInteractionEnabled = true
        backView.backgroundColor = .white
        backView.hg_setAllCornerWithCornerRadius(radius: 10)
        return backView
    }()
    //商家图片
    lazy var tipImg : UIImageView = {
        let tipImg = UIImageView()
        tipImg.image = UIImage(named: "login_LOGO")
        tipImg.hg_setAllCornerWithCornerRadius(radius: 6)
        tipImg.contentMode = .scaleAspectFill
        return tipImg
    }()
    //商家名称加标签
    lazy var nameLab : UILabel={
        let nameLab = UILabel()
        nameLab.font = MYBlodFont(size: 16)
        nameLab.textColor = .text
        let str = "商家名称商家名称商家名称商家名称"
        nameLab.text = str
        return nameLab
    }()
    //商家名称加标签
    lazy var nameIcon : VipNameIcon={
        let nameIcon = VipNameIcon()
        return nameIcon
    }()
    
    
    //进店
    lazy var addBtn : QMUIButton = {
        let arrowBtn = QMUIButton(type: .custom)
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("进店", for: UIControl.State.normal)
        arrowBtn.setTitleColor(.tag, for: UIControl.State.normal)
        arrowBtn.jk.addBorder(borderWidth: 1, borderColor: .tag)
        arrowBtn.hg_setAllCornerWithCornerRadius(radius: 5)
        arrowBtn.titleLabel?.font = MYFont(size: 13)
        arrowBtn.addTarget(self, action: #selector(clickAddAction), for: .touchUpInside)
        return arrowBtn
    }()
    
    
    //销量
    lazy var scoreView : VipScoreView = {
        let scoreView = VipScoreView()
        return scoreView
    }()
    //时间距离
    lazy var timeView : VipTimeView = {
        let timeView = VipTimeView()
        return timeView
    }()
    //起送
    lazy var priceView : VipPriceView = {
        let priceView = VipPriceView()
        return priceView
    }()
    //榜单
    lazy var rankBtn : QMUIButton = {
        let rankBtn = QMUIButton()
        rankBtn.titleLabel?.font = MYFont(size: 10)
        rankBtn.setTitle("罗湖区热评榜第1名", for: UIControl.State.normal)
        rankBtn.setTitleColor(.warn, for: UIControl.State.normal)
        rankBtn.setImage(UIImage(named: "vip_Reviews_HotList"), for: UIControl.State.normal)
        rankBtn.backgroundColor = UIColor.hex(hexString: "FFFCF1")
        rankBtn.imagePosition = QMUIButtonImagePosition.left
        rankBtn.jk.addBorder(borderWidth: 0.5, borderColor: .warn)
        rankBtn.contentEdgeInsets = UIEdgeInsets.init(top: 1, left: 2, bottom: 1, right: 4)
        rankBtn.hg_setAllCornerWithCornerRadius(radius: 5)
        return rankBtn
    }()
    
    
    @objc func clickAddAction() {
        print("clickAddAction success!")
        delegate?.clickInsetMerchant()
    }
    
    func confiGgroupBuy(){
//        priceView.removeFromSuperview()
//        nameIcon.icon2.isHidden = true
//        nameIcon.icon3.isHidden = true
    }

    @objc func enterShop(){
        guard let action = enterShopBlock else { return }
        action()
    }
    
    override func configUI() {
       
        addBtn.addTarget(self, action: #selector(enterShop), for: .touchUpInside)
        contentView.backgroundColor = .background
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        //商家图片
        backView.addSubview(tipImg)
        tipImg.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.width.height.equalTo(65)
        }
        
        //进店
        backView.addSubview(addBtn)
        addBtn.snp.makeConstraints { make in
            make.top.equalTo(tipImg.snp_top)
            make.right.equalTo(-10)
            make.width.equalTo(45)
            make.height.equalTo(20)
        }
        
        //商家名称
        backView.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.top.equalTo(tipImg.snp_top)
            make.left.equalTo(tipImg.snp_right).offset(8)
            make.right.equalTo(addBtn.snp_left).offset(-4)
        }

        //商家标签
        backView.addSubview(nameIcon)
        nameIcon.snp.makeConstraints { make in
            make.top.equalTo(nameLab.snp_bottom).offset(2)
            make.left.equalTo(nameLab.snp_left).offset(0)
           
        }

        //销量
        backView.addSubview(scoreView)
        scoreView.snp.makeConstraints { make in
            make.left.equalTo(nameLab.snp_left)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(nameIcon.snp_bottom).offset(4)
        }
        //配送费
        backView.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.left.equalTo(nameLab.snp_left)
            make.width.equalTo(200)
            make.top.equalTo(scoreView.snp_bottom).offset(4)
            make.height.equalTo(13)
        }

        //榜单
        backView.addSubview(rankBtn)
        rankBtn.snp.makeConstraints { make in
            make.left.equalTo(nameLab.snp.left)
            make.top.equalTo(priceView.snp_bottom).offset(4)
            make.top.equalTo(scoreView.snp_bottom).offset(4).priorityLow()
        }
        
        //时间距离
        backView.addSubview(timeView)
        timeView.snp.makeConstraints { make in
            make.right.equalTo(addBtn.snp_right)
            make.width.equalTo(200)
            make.centerY.equalTo(priceView.snp_centerY)
            make.centerY.equalTo(rankBtn).priorityLow()
        }
    }

}
