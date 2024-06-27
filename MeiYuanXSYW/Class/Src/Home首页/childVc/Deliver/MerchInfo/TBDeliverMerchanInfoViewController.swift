//
//  TBDeliverMerchanInfoViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/8.
//

import UIKit
import JXSegmentedView
import GKPageScrollView

let kBaseHeaderH = FMScreenScaleFrom(125) + 215 - 20

class TBDeliverMerchanInfoViewController: XSBaseViewController {
    
    var showHomeStyle: HomeShowStyle = .deliver
    var merchantId: String = ""
    
    init(style homeShowStyle: HomeShowStyle, merchantId: String) {
        self.merchantId = merchantId
        self.showHomeStyle = homeShowStyle

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titles = ["商品","评价","商家信息"]
    var childVCs: [GKPageListViewDelegate] = [GKPageListViewDelegate]()
    var scrollDidView: UIView?
        
   
    lazy var collectItem: UIBarButtonItem = {
        let item = UIBarButtonItem.tb_item(image:UIImage(named: "nav_collect_white_icon"),selectEdImage: UIImage(named: "goodsInfo_love_select"), target: self, action: #selector(collectAction(collectionButton:)))
        return item
    }()
    
    lazy var backItem: UIBarButtonItem = {
       let back = UIBarButtonItem.tb_item(image: UIImage(named: "nav_back_white")!, target: self, action: #selector(backAction))
        return back
    }()
    lazy var shareItem: UIBarButtonItem = {
        let share = UIBarButtonItem.tb_item(image:UIImage(named: "nav_share_white_icon"), target: self, action: #selector(shareAction))
        return share

    }()
    
    var headerModel: TBDelieveMerchatInfoModel?
    /// 展开公告
    let headerInfoExpendView = TBMerchInfoExpendView()
    
    lazy var headerView: TBMerchHeaderView = {
        let iv = TBMerchHeaderView()
        iv.containerView.delegate = self
        iv.frame = CGRect(x: 0, y: 0, width: screenWidth, height: kBaseHeaderH)
        return iv
    }()
    
    lazy var headerContainerView: UIView = {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: kBaseHeaderH))
        containerView.backgroundColor = .background
        containerView.addSubview(headerView)
        return containerView
    }()
    
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: segemntH + spaceing, width: screenWidth, height: pageScrollView.tb_height - segemntH - spaceing - bottomCartViewH))
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = .yellow
        scrollView.bounces = false
        scrollView.delegate = self
        
        for (idx,vc) in childVCs.enumerated() {
            if let vc = vc as? XSBaseViewController {
                self.addChild(vc)
                scrollView.addSubview(vc.view)
                vc.view.frame = CGRect(x: CGFloat(idx) * screenWidth, y: 0, width:screenWidth , height: scrollView.tb_height)
            }
        }
        scrollView.contentSize = CGSize(width: screenWidth * CGFloat(childVCs.count), height: 0)
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
    
   private lazy var segmentView: JXSegmentedView = {
        let segment = JXSegmentedView(frame: CGRect(x: 10, y: 0, width: 280, height: segemntH))
        segment.dataSource = segmentedDataSource
        segment.delegate = self
        segment.defaultSelectedIndex = 0
        //配置指示器
        let indicator = JXSegmentedIndicatorImageView()
        indicator.image = UIImage(named: "home_segment_indicator")
        indicator.indicatorWidth = 11
        indicator.indicatorHeight = 11
        segment.indicators = [indicator]
        segment.contentScrollView = contentScrollView
        return segment
    }()
    
   private lazy var pageView: UIView  = {
        let pageView = UIView()
        pageView.backgroundColor = .background
        pageView.addSubview(contentScrollView)
        pageView.addSubview(segmentView)
        return pageView
    }()
    
   private lazy var pageScrollView: GKPageScrollView = {
        let pageScrollView = GKPageScrollView(delegate: self)
        pageScrollView.isAllowListRefresh = false
        pageScrollView.ceilPointHeight = kNavHeight
        pageScrollView.mainTableView.backgroundColor = .background
        return pageScrollView
    }()
    
    lazy var nav_titleView: UIView = {
        let titleView = TBSearchTextField()
        titleView.searchDelegate = self
        titleView.frame = CGRect(x: 0, y: 0, width: screenWidth - 100, height: 30)
        titleView.placeholderText = "搜索更多美食"
        return titleView
    }()

    lazy var shopVc: TBDeliverMerchInfoShopViewController = {
        let shop = TBDeliverMerchInfoShopViewController(style: .deliver, merchantId: merchantId)
        shop.delegate = self
        return shop
    }()
    
    lazy var evaluateVc: TBDeliverMerchInfoEvaluateViewController = {
        let evaluate = TBDeliverMerchInfoEvaluateViewController(style: .deliver, merchantId: merchantId)
        return evaluate
    }()
    
    lazy var detailVc: TBMerchInfoDetailController = {
        let detail = TBMerchInfoDetailController(style: .deliver, merchantId: merchantId)
       return detail
    }()

    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    
    lazy var popView: TBCartPopView = {
        return TBCartPopView()
    }()

    lazy var bottomCartView: TBCartBottomView = {
        let bottomView = TBCartBottomView.loadFromNib()
        bottomView.cartBottomClickHandler = { [weak self] bottomView in
            self?.popView.getCartOrderInfo(merchantId: self?.merchantId ?? "")
            
            self?.popView.cartClarAllHandler = { [weak self] popViw in
                bottomView.cartNumBadge = 0
                
                self?.shopVc.cartGoodsInfoModel = popViw.cartGoodInfoModel
                
            }
            self?.popView.show(showSuperView: self?.view,bottomSpace: bottomCartViewH)
            self?.view.bringSubviewToFront(bottomView)

            /// 将一个UIView显示在最前面,调用其父视图的 bringSubviewToFront（）
            /// 将一个UIView层推送到背后,调用其父视图的 sendSubviewToBack（）
        }
        return bottomView
    }()

    
    private func setupNav() {
        edgesForExtendedLayout = .all
        self.gk_statusBarStyle = .lightContent
        self.gk_navBarAlpha = 0
        self.gk_navTitle = ""
        self.gk_navTitleColor = .white
        self.gk_navLineHidden = true

        

        self.gk_navLeftBarButtonItem = self.backItem
        self.gk_navRightBarButtonItems = [shareItem, collectItem]
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCartOrderInfo()
        conformUser2MerchantDistance()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configInitSubviews()
        NotificationCenter.default.addObserver(self, selector: #selector(getMerchInfoHeaderData), name: NSNotification.Name.XSUpdateMerchHeadrInfoNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(joinGoodsToCart(note:)), name: NSNotification.Name.XSJoinGoodsInCartNotification, object: nil)
        
      
        
    }
    
     func configInitSubviews() {
        
        setupNav()

        childVCs.append(shopVc)
        childVCs.append(evaluateVc)
        childVCs.append(detailVc)
        
        self.view.addSubview(bottomCartView)
        
        bottomCartView.snp.makeConstraints { make in
            make.height.equalTo(bottomCartViewH)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.usnp.bottom)
        }
        
        self.view.addSubview(pageScrollView)
        pageScrollView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomCartView.snp_top).offset(0)
        }
        pageScrollView.reloadData()
        
    }
    
    @objc func shareAction() {
        uLog("shareAction")

    }
    @objc func collectAction(collectionButton: UIButton) {
        uLog("collectAction")
        let collectType = collectionButton.isSelected ? 1 : 0

        MerchantInfoProvider.request(.saveCollectMerchant(_merchantId: merchantId, type: collectType), model: XSMerchInfoHandlerModel.self) { returnData in
            
            if returnData?.trueOrFalse ?? 0 == 0 {
                XSTipsHUD.showSucceed("操作成功")
                collectionButton.isSelected = !collectionButton.isSelected
                
                
            } else {
                XSTipsHUD.showSucceed("操作失败")
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
        
    }
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func initData() {
        
        getMerchInfoHeaderData()
    }
    
}

// MARK: - HttpRequest
extension TBDeliverMerchanInfoViewController {
    func conformUser2MerchantDistance() {
        
        MerchantInfoProvider.request(.conformUser2MerchantDistance(lat, lon, merchantId), model: XSMerchInfoHandlerModel.self) { returnData in
            
            if (returnData?.trueOrFalse ?? 0) != 0 {
                let outDistance = XSDelieveOutDistancePopView()
                outDistance.changeLocationDidSelectHandler = { popView in
                    let address = XSPayAddressViewController()
                    self.navigationController?.pushViewController(address, animated: true)
                    
                }
                outDistance.show()
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    func getCartOrderInfo() {
        if merchantId.count <= 0 {
            uLog("merchantId 为nil")
        }
        MerchantInfoProvider.request(.getOrderMerchantInCarVO(merchantId), model: TBMerchInfoCartGoodInfoModel.self) { returnData in
            if let cartGoodsInfoModel = returnData {
                
                NotificationCenter.default.post(name: NSNotification.Name.XSJoinGoodsInCartNotification, object: self, userInfo: ["cartGoodsInfo" : cartGoodsInfoModel])
            }

        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

    }
    
    @objc func joinGoodsToCart(note: NSNotification) {
        guard let cartGoodsInfoModel = note.userInfo?["cartGoodsInfo"] as? TBMerchInfoCartGoodInfoModel
              else { return }
        
        bottomCartView.cartGoodsInfoModel = cartGoodsInfoModel
    }
    
   @objc func getMerchInfoHeaderData() {
        // 0外卖，1团购,2私厨,3聚合
       MerchantInfoProvider.request(.getMerchantPage(lon, lat, merchantId, bizType: self.showHomeStyle.rawValue), model: TBDelieveMerchatInfoModel.self) { [weak self] returnData in
            guard let self = self else { return }
           
            if let dataModel = returnData {
                self.headerView.headerModel = dataModel
                self.headerInfoExpendView.setupData(dataModel)
                self.headerView.showHomeStyle = self.showHomeStyle
                
                // 商家详情
                self.detailVc.setupDataModel(dataModel)
                
                // 收藏
                let collect = self.collectItem.customView as! UIButton
                collect.isSelected = dataModel.isCollect

                
                self.checkMerchantState(dataModel: dataModel)
                
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    func checkMerchantState(dataModel: TBDelieveMerchatInfoModel) {
        /// 营业状态(0:正常营业;1:暂停营业;2:打样了
        if dataModel.merchantStatus == 1 {
            detailVc.setContentInset(bottomInset: 46)

            
            evaluateVc.setContentInset(bottomInset: 46)
            shopVc.setContentInset(bottomInset: 46)
            
            let msgView = TBBottomMsgView(msgText: "本店暂停营业，恢复营业后可点餐")
            self.view.addSubview(msgView)
            msgView.snp.makeConstraints { make in
                make.height.equalTo(46)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(bottomCartView.snp_top)
            }
            
        } else if(dataModel.merchantStatus == 2) {
            let msgView = TBBottomMsgView(msgText: "本店打烊了，今日预约明日\(dataModel.bookTime)后配送")
            self.view.addSubview(msgView)
            msgView.snp.makeConstraints { make in
                make.height.equalTo(46)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(bottomCartView.snp_top)
            }
            
        } else {// 在营业中
            // 判断是否在范围距离中
            conformUser2MerchantDistance()
        }
    }
    
}

// MARK: - GKPageScrollViewDelegate
extension TBDeliverMerchanInfoViewController: GKPageScrollViewDelegate {
    func headerView(in pageScrollView: GKPageScrollView) -> UIView {
        return headerContainerView
    }
    func pageView(in pageScrollView: GKPageScrollView) -> UIView {
        return pageView
    }
    func listView(in pageScrollView: GKPageScrollView) -> [GKPageListViewDelegate] {
        return self.childVCs
    }
    
    /// mainTableView滑动回调，可用于实现导航栏渐变、头图缩放等功能
    ///
    /// - Parameters:
    ///   - scrollView: mainTableView
    ///   - isMainCanScroll: mainTableView是否可滑动，YES表示可滑动，没有到达临界点，NO表示不可滑动，已到达临界点
    func mainTableViewDidScroll(_ scrollView: UIScrollView, isMainCanScroll: Bool) {
        let offsetY = scrollView.contentOffset.y
        //uLog("offsetY:\(offsetY)")

        var navBarBackgroundAlpha: CGFloat = 0
        
        let collBtn = collectItem.customView as! UIButton
        let shareBtn = shareItem.customView as! UIButton
        let backBtn  = backItem.customView as! UIButton

        if offsetY > kNavHeight {
            navBarBackgroundAlpha = 1.0
            self.gk_navTitle = nil
            self.gk_navTitleView = self.nav_titleView

            backBtn.setImage(UIImage(named: "nav_back_black"), for: .normal)
            collBtn.setImage(UIImage(named: "nav_collect_black_icon"), for: .normal)
            shareBtn.setImage(UIImage(named: "nav_share_black_icon"), for: .normal)

            
        } else if(offsetY < 0) {
            navBarBackgroundAlpha = 0
            self.gk_statusBarStyle = .lightContent

            self.gk_navTitle = ""
            self.gk_navTitleView = nil
            
            backBtn.setImage(UIImage(named: "nav_back_white"), for: .normal)
            collBtn.setImage(UIImage(named: "nav_collect_white_icon"), for: .normal)
            shareBtn.setImage(UIImage(named: "nav_share_white_icon"), for: .normal)


        } else {
            navBarBackgroundAlpha = offsetY / CGFloat(kNavHeight)
        }
        self.gk_navBarAlpha = navBarBackgroundAlpha

    }
    
    func changeTitle(_ isShow: Bool) {
        if isShow {
            if self.gk_navTitle == nil {
                return
            }
            self.gk_navTitle = nil
            self.gk_navTitleView = self.nav_titleView
        } else {
            if self.gk_navTitleView == nil {
                return
            }
            self.gk_navTitle = ""
            self.gk_navTitleView = nil
        }
    }

}

extension TBDeliverMerchanInfoViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int)
    {
        print("刷新数据")
    }
}

extension TBDeliverMerchanInfoViewController: TBSearchTextFieldDelegate {
    func searchTextFieldDidBeginEditing(textField: TBSearchTextField) {
        textField.resignFirstResponder()
        let search = TBDelieverMerchInfoSearchViewController(merchantId: merchantId)
        self.navigationController?.pushViewController(search, animated: true)
    }
}

// MARK: - TBMerchHeaderViewDelegate
extension TBDeliverMerchanInfoViewController: TBMerchHeaderViewDelegate {
    func clickMerchInfoMoreButton(_ headerContainer: TBMerchHeaderTopContainer) {
//        self.navigationController?.pushViewController(TBMerchInfoDetailController(style: showHomeStyle, merchantId: merchantId), animated: true)
    }
    
    func showPublishExpendView(_ headerContainer: TBMerchHeaderTopContainer) {
        self.view.addSubview(headerInfoExpendView)
        headerInfoExpendView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(headerContainer.ticketActivityView.snp_bottom).offset(0)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UIScrollViewDelegate
extension TBDeliverMerchanInfoViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        pageScrollView.horizonScrollViewDidEndedScroll()
    }
    
    func mainTableViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate: Bool) {
        //print("mainTableViewDidEndDragging")
        pageScrollView.horizonScrollViewDidEndedScroll()

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        pageScrollView.horizonScrollViewDidEndedScroll()
    }

}

// MARK: - TBDeliverMerchInfoShopViewControllerDelegate
extension TBDeliverMerchanInfoViewController: TBDeliverMerchInfoShopViewControllerDelegate {
   
    func showShopCart() {
        popView.show(showSuperView: self.view)
        view.bringSubviewToFront(bottomCartView)
    }
    
    func shopTypeDidClick(_ shopViewController: TBDeliverMerchInfoShopViewController) {
        pageScrollView.scrollToCriticalPoint()
    }
    
    func rightViewDidClick(_ shopViewController: TBDeliverMerchInfoShopViewController, goodsItemVoModel: GoodsItemVo) {
//        let goodsInfo = TBHomeGroupBuyGoodsInfoVc()
//        goodsInfo.goodsId = goodsItemVoModel.goodsId
//        goodsInfo.showHomeStyle = self.showHomeStyle
//        self.navigationController?.pushViewController(goodsInfo, animated: true)
    }
    
    
}
