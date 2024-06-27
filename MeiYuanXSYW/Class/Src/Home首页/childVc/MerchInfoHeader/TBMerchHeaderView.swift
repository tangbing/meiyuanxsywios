//
//  TBMerchHeaderView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/28.
//

import UIKit
import QMUIKit
import MapKit


class TBMerchHeaderTopAddressPhoneView: UIView {
    lazy var merchAddresLabel: UILabel = {
        let address = UILabel()
        address.font = MYFont(size: 12)
        address.numberOfLines = 2
        address.text = "罗湖区桂园路255国贸商城5层456号，"
        address.textColor = .twoText
        address.jk.setTextLineSpace(5)
        return address
    }()
    
    lazy var locationGuideBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(#imageLiteral(resourceName: "merch_info_location"), for: .normal)
        return btn
    }()
    
    lazy var telephoneBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(#imageLiteral(resourceName: "merch_info_telephone"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.backgroundColor = .purple
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup(){
        self.addSubview(telephoneBtn)
        telephoneBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 22, height: 22))
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(7)
        }
        
        self.addSubview(locationGuideBtn)
        locationGuideBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 22, height: 22))
            make.right.equalTo(telephoneBtn.snp_left).offset(-10)
            make.centerY.equalTo(telephoneBtn)
        }
        
        self.addSubview(merchAddresLabel)
        merchAddresLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(locationGuideBtn.snp_left).offset(-37)
        }
    }
}

class TBMerchHeaderTopView: UIView {
    
    lazy var loggo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "picture21")
//        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    lazy var isOpenLabel: UILabel = {
        let openLabel = UILabel()
        openLabel.textAlignment = .center
        openLabel.backgroundColor = UIColor.hexStringColor(hexString: "#000000", alpha: 0.6)
        openLabel.text = "暂停营业"
        openLabel.textColor = .white
        openLabel.font = MYFont(size: 12)
        return openLabel
    }()
    
    lazy var merchLogoView: UIView = {
        let logoView = UIView()
        logoView.hg_setAllCornerWithCornerRadius(radius: 10)
        logoView.addSubview(loggo)
        loggo.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoView.addSubview(isOpenLabel)
        isOpenLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.bottom.left.right.equalToSuperview()
        }
        
        
        return logoView
    }()
    
    lazy var merchName: UILabel = {
        let lab = UILabel()
        lab.font = MYFont(size: 18)
        lab.text = "太清甜品(罗湖店)"
        lab.textColor = .text
        return lab
    }()
    
    lazy var scoreView: VipScoreView = {
        return VipScoreView()
    }()
    
    lazy var selfSupport: UIImageView = {
        let support = UIImageView()
        //logo.image = UIImage(named: "picture21")
        support.contentMode = .scaleAspectFit
        return support
    }()
    
    lazy var rightLabel: UILabel = {
        let lab = UILabel()
        lab.font = MYFont(size: 11)
        lab.text = "5.2km"
        lab.textColor = .twoText
        return lab
    }()
    
    /// 广东菜 鸡煲 晚餐
    lazy var evaluatView: XSCollectHightEvaluatView = {
        let evaluatView = XSCollectHightEvaluatView()
        //evaluatView.configMerchInfo()
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
    
    lazy var telephoneBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(#imageLiteral(resourceName: "merch_info_telephone"), for: .normal)
        btn.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout(){
       // self.backgroundColor = .yellow
        
        self.addSubview(merchLogoView)
        merchLogoView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 65, height: 65))
            make.top.equalTo(self.snp_top).offset(-(65 * 0.5))
            make.right.equalToSuperview().offset(-10)
        }
        
        
        self.addSubview(merchName)
        merchName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-85)
            make.height.equalTo(24)
        }
        
        self.addSubview(scoreView)
        scoreView.snp.makeConstraints { make in
            make.top.equalTo(merchName.snp_bottom).offset(5)
            make.left.equalTo(merchName)
            make.width.equalTo(140)
        }
        
        self.addSubview(rightLabel)
        rightLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(scoreView)
        }
        
        self.addSubview(evaluatView)
        evaluatView.snp.makeConstraints { make in
            make.top.equalTo(scoreView.snp_bottom).offset(5)
            make.left.equalTo(merchName)
            make.height.equalTo(15)
            make.bottom.equalToSuperview()
        }
        
//        self.addSubview(rankBtn)
//        rankBtn.snp.makeConstraints { make in
//            make.top.equalTo(evaluatView.snp_bottom).offset(5)
//            make.left.equalTo(merchName)
//            make.height.equalTo(15)
//            make.bottom.equalToSuperview()
//
//        }
    }
    
    @objc func callPhone() {
        
    }
    
    func configPrivateKit(){
        rightLabel.isHidden = true
        self.addSubview(telephoneBtn)
        
        self.telephoneBtn.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.top.equalTo(merchLogoView.snp_bottom).offset(10)
            make.centerX.equalTo(merchLogoView).offset(0)
        }
    }
}

/// 承载优惠券滚动的UIScrollView
class TBMerchTicketScrollView: UIScrollView {
    
    var lastTicketView: TBMerchTicketView? = nil
    /// 是否允许点击卷，弹出弹框
    var isAllowPopView: Bool = true
    var merchantId: String = ""
    
    var ticketTitiles: [CommonCouponVo]? {
        
        willSet {
            if var ticketTitiles = ticketTitiles {
                ticketTitiles.removeAll()
            }
        }
        
        didSet {
            if let ticketTitiles = ticketTitiles {
                setupTicketScrollView(ticketTitiles)
            }
           
        }
    }
    
    lazy var container: UIView = {
        let contain = UIView()
        contain.backgroundColor = .white
        return contain
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setupTicketScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTicketScrollView(_ ticketTitiles: [CommonCouponVo]){
        
        
        self.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        container.clearAll()
        lastTicketView = nil

        for i in 0..<ticketTitiles.count {
            let merchTicketView = TBMerchTicketView()
            let ticketModel = ticketTitiles[i]
            merchTicketView.ticketModel = ticketModel
           
            merchTicketView.clickTicketViewHandler = { ticketModel in
                if self.isAllowPopView {
                    let ticketPopView = TBMerchInfoTicketPopView()
                    ticketPopView.merchantId = self.merchantId
                    ticketPopView.show()
                } else {
                    self.receiverCoupon(couponId: ticketModel.couponId)
                }
               
            }
            
            container.addSubview(merchTicketView)
            merchTicketView.snp.makeConstraints { make in
                make.left.equalTo(lastTicketView != nil ? lastTicketView!.snp_right : container.snp_left).offset(4)
                make.centerY.equalToSuperview()
            }
            lastTicketView = merchTicketView
        }
        
        if lastTicketView != nil {
            container.snp.makeConstraints { make in
                make.right.equalTo(lastTicketView!.snp_right).offset(10)
            }
        }
    
    }
    
    func receiverCoupon(couponId: Int) {
           MerchantInfoProvider.request(.receiveCoupon(couponId: couponId), model: XSMerchInfoHandlerModel.self) { [weak self] returnData in
               
               if returnData?.trueOrFalse ?? 0 == 0 {
                   XSTipsHUD.showSucceed("领取成功")
                   // 重新刷新店铺详情的头接口获取数据
                   NotificationCenter.default.post(name: NSNotification.Name.XSUpdateMerchHeadrInfoNotification, object: nil)
                   
               } else {
                   XSTipsHUD.showSucceed("领取失败")
               }
               
           } errorResult: { errorMsg in
               print(errorMsg)
               XSTipsHUD.showText(errorMsg)
           }
       }

}

class TBMerchTicketView: UIView {
    
    var clickTicketViewHandler: ((_ ticketModel: CommonCouponVo) -> Void)?
    
    var ticketModel: CommonCouponVo? {
        didSet {
            guard let ticketModel = ticketModel else { return }
            
            /// 优惠券类型（1联盟满减券2会员抵扣券3平台红包5商家券6商品券9会员权益券）
            if ticketModel.couponType == 9 {
                rightStateImageV.setBackgroundImage(UIImage(named: "ticket_bg_coupon_unselected_check"), for: .normal)
                rightStateImageV.setBackgroundImage(UIImage(named: "ticket_bg_coupon_selected_check"), for: .selected)
                priceLab = "￥\(ticketModel.merchantAmount) 无门槛"
                priceLabel.jk.setsetSpecificTextFont("\(ticketModel.merchantAmount)", font:MYBlodFont(size: 18))
                
                //backgroundColor = UIColor.hex(hexString: "#FA6059")
                // receiveStatus 领取状态 0未领取 1已领取 2未兑换 3已兑换
                rightStateImageV.isSelected = ticketModel.receiveStatus == 3 ? true : false
                leftPriceNumView.backgroundColor = !rightStateImageV.isSelected ? UIColor(r: 255, g: 233, b: 240, a: 1.0) : UIColor(r: 246, g: 71, b: 72, a: 1.0)
                priceLabel.textColor = !rightStateImageV.isSelected ? UIColor.hex(hexString: "#FA6059") : .white
                
            } else {
                rightStateImageV.setBackgroundImage(UIImage(named: "ticket_bg_coupon_unselected"), for: .normal)
                rightStateImageV.setBackgroundImage(UIImage(named: "ticket_bg_coupon_selected"), for: .selected)
                priceLab = "￥\(ticketModel.discountAmount) 满\(ticketModel.fullReductionAmount)可用"
                
                priceLabel.jk.setsetSpecificTextFont("\(ticketModel.discountAmount)", font:MYBlodFont(size: 18))
                //backgroundColor = UIColor.hex(hexString: "#FA6059")

                // receiveStatus 领取状态 0未领取 1已领取 2未兑换 3已兑换
                rightStateImageV.isSelected = ticketModel.receiveStatus == 0 ? false : true
                leftPriceNumView.backgroundColor = rightStateImageV.isSelected ? UIColor(r: 255, g: 233, b: 240, a: 1.0) : UIColor(r: 246, g: 71, b: 72, a: 1.0)
                priceLabel.textColor = rightStateImageV.isSelected ? UIColor.hex(hexString: "#FA6059") : .white
                
            }
            
        }
    }
    

    let rightStateImageV: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        return button
    }()
    
    let leftPriceNumView: UIView = {
        let num = UIView()
        num.backgroundColor = UIColor.hex(hexString: "#FA6059")
        return num
    }()
    
    let priceLabel: UILabel = {
        let pricelabel = UILabel()
        pricelabel.textColor = .white
        pricelabel.text = "¥8 满38可用"
        
        pricelabel.font = MYFont(size: 11)
        return pricelabel
    }()
    
    var priceLab: String? {
        didSet {
            guard let price = priceLab else {
                return
            }
            priceLabel.text = price
           
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        leftPriceNumView.jk.addBorderTop(borderWidth: 0.5, borderColor: UIColor.hex(hexString: "#FA6059"))
        leftPriceNumView.jk.addBorderLeft(borderWidth: 0.5, borderColor: UIColor.hex(hexString: "#FA6059"))
        leftPriceNumView.jk.addBorderBottom(borderWidth: 0.5, borderColor: UIColor.hex(hexString: "#FA6059"))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        self.jk.addGestureTap({ [weak self] geuture in
            guard let weakSelf = self else {
                return
            }
            
            weakSelf.clickTicketViewHandler?(weakSelf.ticketModel!)
        
        })
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout(){
        

        self.addSubview(rightStateImageV)
        rightStateImageV.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(40)
        }
        
        self.addSubview(leftPriceNumView)
        leftPriceNumView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview()
            make.right.equalTo(rightStateImageV.snp_left).offset(0)
        }
        
        leftPriceNumView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }

    }
}

/// 优惠信息
class TBMerchTicketActivieyView: UIView {
    
    var ticketInfos: [String] = [String]()
    var lastTicket: QMUILabel?

    lazy var container: UIView = {
        let contain = UIView()
        contain.backgroundColor = .white
        return contain
    }()
    
//    init(ticketsInfos: [String]) {
//        self.ticketInfos = ticketsInfos
//        super.init(frame: .zero)
//    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    func setupTicketActivieyView(_ ticketInfos: [String])
    {
        //let tickets = ["含5元津贴","含5元津贴","含5元津贴"]
        self.ticketInfos.removeAll()
        self.clearAll()
        lastTicket = nil
        
        self.ticketInfos = ticketInfos
        
        let spcing: CGFloat = 3
        for ticketinfo in self.ticketInfos {
            
            let ticketIb = QMUILabel()
            ticketIb.text = ticketinfo
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

class TBMerchHeaderOpenTimeView: UIView {
    
    var clickMerchInfoBlock: (() -> Void)?
    
    lazy var openTime: UILabel = {
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.text = "营业中：10:00-21:00"
        lab.textColor = UIColor.hex(hexString: "#5A93FF")
        return lab
    }()
    
    var arrowBtn : QMUIButton = {
        let arrowBtn = QMUIButton()
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("详情", for: UIControl.State.normal)
        arrowBtn.setImage(UIImage(named: "merchInfo_detail_down"), for: UIControl.State.normal)
        arrowBtn.setTitleColor(.twoText, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYFont(size: 13)
        arrowBtn.spacingBetweenImageAndTitle = 5
        arrowBtn.addTarget(self, action: #selector(clickMerchInfoAction), for: .touchUpInside)
        return arrowBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(openTime)
        openTime.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(arrowBtn)
        arrowBtn.snp.makeConstraints { make in
            make.left.equalTo(openTime.snp_right).offset(5)
            make.centerY.equalTo(openTime)
            make.size.equalTo(CGSize(width: 56, height: 15))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickMerchInfoAction() {
        self.clickMerchInfoBlock?()
    }

}

protocol TBMerchHeaderViewDelegate: NSObjectProtocol {
    func showPublishExpendView(_ headerContainer: TBMerchHeaderTopContainer)
    func clickMerchInfoMoreButton(_ headerContainer: TBMerchHeaderTopContainer)
}

class TBMerchHeaderTopContainer: UIView {
    var delieveHeaderModel: TBDelieveMerchatInfoModel!
    
    weak var delegate: TBMerchHeaderViewDelegate?

    lazy var topView: TBMerchHeaderTopView = {
        return TBMerchHeaderTopView()
    }()
    
    lazy var phoneView: TBMerchHeaderTopAddressPhoneView = {
        return TBMerchHeaderTopAddressPhoneView()
    }()
    
    lazy var optimeView: TBMerchHeaderOpenTimeView = {
        let openTime = TBMerchHeaderOpenTimeView()
        openTime.clickMerchInfoBlock = {
            self.delegate?.clickMerchInfoMoreButton(self)
        }
        return openTime
    }()
    
//    lazy var merchTicketView: TBMerchTicketView = {
//        return TBMerchTicketView()
//    }()
    
    lazy var ticketScroll: TBMerchTicketScrollView = {
        
        return TBMerchTicketScrollView()
    }()
    
    lazy var ticketActivityView: TBMerchTicketActivieyView = {
        return TBMerchTicketActivieyView()
    }()
    
    lazy var pulishNoteLabel: UILabel = {
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.numberOfLines = 1
        lab.text = "店铺公告：注意事项注意事项注意事项"
        lab.textColor = .twoText
        return lab
    }()
    
    var arrowPulishNoteBtn : QMUIButton = {
        let arrowBtn = QMUIButton()
        //arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setImage(UIImage(named: "merch_info_arrow_down"), for: UIControl.State.normal)
        arrowBtn.addTarget(self, action: #selector(clickPublishAction), for: .touchUpInside)
        return arrowBtn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickPublishAction() {
        self.delegate?.showPublishExpendView(self)
    }
    
    func bindModel(_ model: TBDelieveMerchatInfoModel) {
        delieveHeaderModel = model
        
        
        
        topView.loggo.xs_setImage(urlString: model.merchantLogo)
        topView.merchName.text = model.merchantName
        
        topView.rightLabel.text = "起送¥\(model.minPrice) \(model.bookTime)分钟 \(model.distance)km"

        if let merchantTags = model.merchantTag {
            topView.evaluatView.layoutWithtags(tags: merchantTags, praise: nil)
        }

        topView.scoreView.scoreLab.text = "\(model.commentScore)分"
        topView.scoreView.saleLab.text = "月销\(model.monthlySales)"
        topView.scoreView.priceLab.text = "人均¥\(model.avgPrice)"
        phoneView.merchAddresLabel.text = model.merchantAddress
        
        phoneView.telephoneBtn.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
        phoneView.locationGuideBtn.addTarget(self, action: #selector(locationGuide), for: .touchUpInside)

        
        pulishNoteLabel.text = "店铺公告：\(model.storeNotice)"
        
        /// 营业状态(0:正常营业;1:暂停营业;2:打样了)
        let merchantStatus = getDutyStatus(model.merchantStatus)
        optimeView.openTime.text = "\(merchantStatus.msg) \(model.todayOpeningHours)"
        topView.isOpenLabel.isHidden = merchantStatus.showMsg
        topView.isOpenLabel.text = merchantStatus.msg
           
        
//        先判断营业状态，在判断是否在距离中
//         打样了，有预约状态isBook，，否，显示打样UI提示
//        不在距离中，显示不在距离的UI
        
        // 优惠券
        ticketScroll.merchantId = model.merchantId
        if let ticketCouponModels = model.commonCouponVos {            
            ticketScroll.ticketTitiles = ticketCouponModels
        }
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
            
            ticketActivityView.setupTicketActivieyView(tickets)
        }
       
    }
    
    
    func getDutyStatus(_ status: Int) -> (msg: String , showMsg: Bool) {
        switch status {
        case 0:
            return ("营业中", true)
        case 1:
            return ("暂停营业", false)
        default:
            return ("打烊了", false)
        }
    }
    
  
    
    func configPrivateKit() {
        phoneView.isHidden = true
        phoneView.snp.updateConstraints { make in
            make.top.equalTo(topView.snp_bottom).offset(0)
            make.height.lessThanOrEqualTo(0)
        }
        optimeView.isHidden = true
        optimeView.snp.updateConstraints { make in
            make.height.equalTo(0)
            make.top.equalTo(phoneView.snp_bottom).offset(0)
        }
        
        self.topView.configPrivateKit()
    
    }
    
    func setupUI() {
        self.backgroundColor = .white
        
        self.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        self.addSubview(phoneView)
        phoneView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp_bottom).offset(5)
            make.left.right.equalToSuperview()
            make.height.lessThanOrEqualTo(36)
        }
        
        self.addSubview(optimeView)
        optimeView.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.top.equalTo(phoneView.snp_bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.addSubview(ticketScroll)
        ticketScroll.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(optimeView.snp_bottom).offset(5)
            make.height.equalTo(24)
        }
        
        self.addSubview(ticketActivityView)
        ticketActivityView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(ticketScroll.snp_bottom).offset(5)
            make.height.equalTo(12)

        }
        
        self.addSubview(arrowPulishNoteBtn)
        arrowPulishNoteBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(ticketActivityView.snp_bottom).offset(5)
            make.width.height.equalTo(15)
        }
        
        self.addSubview(pulishNoteLabel)
        pulishNoteLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(arrowPulishNoteBtn.snp_left).offset(-15)
            make.top.equalTo(ticketActivityView.snp_bottom).offset(5)
            make.height.equalTo(18)
            make.bottom.equalToSuperview().offset(-16)
        }

    }
    
    
    @objc func locationGuide(){
        
        let latitute = delieveHeaderModel.merchantLat
        let longitute = delieveHeaderModel.merchantLng
        let endAddress = delieveHeaderModel.merchantAddress
        
        let alert = UIAlertController(title: "请选择导航应用程序", message: "", preferredStyle: .actionSheet)
        
//        let appleMapSheet = UIAlertAction(title: "苹果地图", style: .default) { action in
//            self.appleMap(lat: latitute, lng: longitute, destination: endAddress)
//        }
//        alert.addAction(action: appleMapSheet)
        
        let gaodeMapSheet  = UIAlertAction(title: "高德地图", style: .default) { action in
            self.amap(dlat: latitute, dlon: longitute, dname: endAddress, way: 0)
        }
        alert.addAction(action: gaodeMapSheet)
        
        let baiduMapSheet  = UIAlertAction(title: "百度地图", style: .default) { action in
            self.baidumap(endAddress: endAddress, way: "driving", lat: latitute,lng: longitute)
        }
        alert.addAction(action: baiduMapSheet)

        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action: cancelAction)
              
        topVC?.present(alert, animated: true, completion: nil)
    }
    
    // 打开高德地图
     func amap(dlat:Double,dlon:Double,dname:String,way:Int) {
         let appName = Bundle.jk.bundleName
         
         let urlString = "iosamap://path?sourceApplication=\(appName)&dname=\(dname)&dlat=\(dlat)&dlon=\(dlon)&t=\(way)" as NSString
         
         if self.openMap(urlString) == false {
             uLog("您还没有安装高德地图")

         }
     }
    
    // 打开第三方地图
       private func openMap(_ urlString: NSString) -> Bool {

           let url = NSURL(string:urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)

           if UIApplication.shared.canOpenURL(url! as URL) == true {
               UIApplication.shared.openURL(url! as URL)
               return true
           } else {
               return false
           }
       }
    
    // 打开百度地图
        func baidumap(endAddress:String,way:String,lat:Double,lng:Double) {
            
            let coordinate = CLLocationCoordinate2DMake(lat, lng)
            
            // 将高德的经纬度转为百度的经纬度
            let baidu_coordinate = getBaiDuCoordinateByGaoDeCoordinate(coordinate: coordinate)
            
            let destination = "\(baidu_coordinate.latitude),\(baidu_coordinate.longitude)"
            
            
            let urlString = "baidumap://map/direction?" + "&destination=" + endAddress + "&mode=" + way + "&destination=" + destination
            
            let str = urlString as NSString
            
            if self.openMap(str) == false {
                uLog("您还没有安装百度地图")
            }
        }
    
    // 打开苹果地图
       func appleMap(lat:Double,lng:Double,destination:String){
           let loc = CLLocationCoordinate2DMake(lat, lng)
           let currentLocation = MKMapItem.forCurrentLocation()
           let toLocation = MKMapItem(placemark:MKPlacemark(coordinate:loc,addressDictionary:nil))
           toLocation.name = destination
           MKMapItem.openMaps(with: [currentLocation,toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: "true"])
       }
    
    // 高德经纬度转为百度地图经纬度
       // 百度经纬度转为高德经纬度，减掉相应的值就可以了。
       func getBaiDuCoordinateByGaoDeCoordinate(coordinate:CLLocationCoordinate2D) -> CLLocationCoordinate2D {
           return CLLocationCoordinate2DMake(coordinate.latitude + 0.006, coordinate.longitude + 0.0065)
       }
     
    
    @objc func callPhone(){
        
       let phones = delieveHeaderModel.merchantPhone
    
        if phones.count <= 0 {
            XSTipsHUD.showInfo("商家暂时未提供联系方式")
            return
        }

        let sheetVc = UIAlertController(title: "拨打电话", message: "", preferredStyle: .actionSheet)
        
        let _ = phones.map { phone  in
            let sheet = UIAlertAction(title: phone, style: .default) { action in
                self.callPhoneTelpro(phone: phone)

            }
            sheetVc.addAction(action: sheet)
        }
        

        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        sheetVc.addAction(action: cancelAction)
              
        topVC?.present(sheetVc, animated: true, completion: nil)
        
    }
    
    func callPhoneTelpro(phone : String){
        let  phoneUrlStr = "telprompt://" + phone
        if UIApplication.shared.canOpenURL(URL(string: phoneUrlStr)!)
        {
            UIApplication.shared.openURL(URL(string: phoneUrlStr)!)
        }
    }

    
    
}

// MARK: - 店铺详情头部
class TBMerchHeaderView: UIView {
    
    var headerModel: TBDelieveMerchatInfoModel? {
        didSet {
            guard let model = headerModel else {
                return
            }
            
            bgImagView.xs_setImage(urlString: model.merchantBackPic)
            containerView.bindModel(model)
            
            
        }
    }
    var showHomeStyle: HomeShowStyle = .deliver {
        didSet {
            if showHomeStyle == .deliver || showHomeStyle == .privateKitchen {
                self.containerView.optimeView.arrowBtn.isHidden = true
            }
        }
    }

    
    lazy var bgImagView: UIImageView = {
        let bgImagView = UIImageView()
        bgImagView.image = UIImage(named: "picture21")
        bgImagView.contentMode = .scaleAspectFit
        return bgImagView
    }()
    
    lazy var topContainerBg: UIView = {
        let bgView = UIView()
        let cover = UIView()
        cover.backgroundColor = .black
        cover.alpha = 0.5
        bgView.addSubview(cover)
        cover.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(bgImagView)
        bgImagView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return bgView
    }()
    
    lazy var containerView: TBMerchHeaderTopContainer  = {
        return TBMerchHeaderTopContainer()
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.addSubview(topContainerBg)
        topContainerBg.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(FMScreenScaleFrom(125))
        }
        
        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(topContainerBg.snp_bottom).offset(-20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            //make.height.equalTo(235)
            make.bottom.equalToSuperview().offset(0)
        }
    }

}
