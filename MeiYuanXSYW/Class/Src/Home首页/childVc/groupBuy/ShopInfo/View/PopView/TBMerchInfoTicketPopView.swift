//
//  TBMerchInfoTicketPopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/2.
//

import UIKit
import JXSegmentedView


class TBMerchInfoTicketPopView: UIView {

    var merchantId: String = ""
    let titles = ["优惠卷","红包"]
    var couponListModel = TBMerchantCouponListModel()

    lazy var ticketDiscount: TBMerchInfoTicketDiscountPopView = {
        let ticketDiscount = TBMerchInfoTicketDiscountPopView()
        ticketDiscount.delegate = self
        return ticketDiscount
    }()
    
    lazy var redPacket: TBMerchInfoTicketRedPacketPopView = {
        let redPacket = TBMerchInfoTicketRedPacketPopView()
        redPacket.delegate = self
        redPacket.merchantId = merchantId
        return redPacket
    }()

    var childViews: [UIView] {
        var views = [UIView]()
        views.append(ticketDiscount)
        views.append(redPacket)
        return views
    }
    
    private let segemntH: CGFloat = 52
    
    
    lazy var overlayView: UIControl = {
        let control = UIControl(frame: UIScreen.main.bounds)
        control.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.6)
        control.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        control.isHidden = true
        return control
    }()
    
    lazy var contentView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: segemntH, width: screenWidth, height: self.getPopViewHeight() - segemntH))
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .yellow
        scrollView.bounces = false
        //scrollView.delegate = self
        
        for (idx,vc) in childViews.enumerated() {
                scrollView.addSubview(vc)
                vc.frame = CGRect(x: CGFloat(idx) * screenWidth, y: 0, width:screenWidth , height: scrollView.tb_height)
        }
        scrollView.contentSize = CGSize(width: screenWidth * CGFloat(childViews.count), height: 0)
        return scrollView
    }()
    
    private lazy var segmentedDataSource: JXSegmentedBaseDataSource? = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = titles
        dataSource.titleSelectedColor = .tag
        dataSource.titleNormalColor = UIColor.hex(hexString: "#737373")
        dataSource.titleNormalFont = MYFont(size: 18)
        dataSource.titleSelectedFont = MYBlodFont(size: 18)
        return dataSource
    }()
    
    lazy var backButton: UIButton = {
        let back = UIButton()
        back.setImage(UIImage(named: "merchinfo_ticket_closure"), for: .normal)
        back.addTarget(self, action: #selector(backBtnDismiss), for: .touchUpInside)
        return back
    }()
    
    lazy var segmentView: JXSegmentedView = {
        let segment = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: screenWidth - 40, height: segemntH))
        segment.dataSource = segmentedDataSource
        //segment.delegate = self
        segment.defaultSelectedIndex = 0
        segment.backgroundColor = UIColor.lightBackground
        //配置指示器
        let indicator = JXSegmentedIndicatorImageView()
        indicator.image = UIImage(named: "home_segment_indicator")
        indicator.indicatorWidth = 11
        indicator.indicatorHeight = 11
        segment.indicators = [indicator]
        segment.contentScrollView = contentView
        return segment
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backBtnDismiss() {
        fadeOut()
    }

    func setupViewSubviews(){
        self.backgroundColor = UIColor.lightBackground
        
        addSubview(contentView)

        self.addSubview(segmentView)
        
        self.addSubview(backButton)
        backButton.frame = CGRect(x: segmentView.tb_maxX, y: 20, width: 40, height: 20)
    }
    
    
    func getPopViewHeight() -> CGFloat {
        return 491
    }
    
    // MARK: - public event
    func show(){
       
        let window = UIApplication.shared.keyWindow
        window?.addSubview(overlayView)
        window?.addSubview(self)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: getPopViewHeight())
        fadeIn()
        
        merchantCouponList()
        
    }
    
    func fadeIn() {
     
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = false
            self.frame = CGRect(x: 0, y: screenHeight - self.getPopViewHeight(), width: screenWidth, height: self.getPopViewHeight())
        }
    }
    
    @objc func fadeOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = true
            self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: self.getPopViewHeight())
        } completion: { (finish) in
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
}

// MARK: - TBMerchInfoPopViewDelegate
extension TBMerchInfoTicketPopView: TBMerchInfoPopViewDelegate {
    func dismissTicketPopView() {
        fadeOut()
    }
    
    func refreshTicket() {
        merchantCouponList()
    }
}

// MARK: - httpRequest
extension TBMerchInfoTicketPopView {
    func merchantCouponList(){
        MerchantInfoProvider.request(.getMerchantCouponList(merchantId), model: TBMerchantCouponListModel.self) { [weak self] returnData in
            
            guard let couponListModel = returnData else { return }
            
            self?.couponListModel = couponListModel
            
            self?.ticketDiscount.dataModel = couponListModel
            
            self?.redPacket.dataModel = couponListModel
           
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
}


