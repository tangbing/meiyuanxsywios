//
//  TBGroupBuyMerchInfoViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/28.
//

import UIKit
import GKNavigationBarSwift
import JXSegmentedView
import GKPageSmoothView

public let kBaseHeaderHeight: CGFloat = FMScreenScaleFrom(125) + 235 - 20
//FMScreenScaleFrom(125) + 235 - 20  FMScreenScaleFrom(125) + 177 - 20
public let kBaseSegmentHeight: CGFloat = 55.0

class TBGroupBuyMerchInfoViewController: XSBaseViewController {

    var isAnimation = false
    var showHomeStyle: HomeShowStyle!
    var merchantId: String = ""
    
    var viemModel = TBMerchInfoViewModel()

    
    /// 展开公告
    let headerInfoExpendView = TBMerchInfoExpendView()
    
    init(style: HomeShowStyle, merchantId: String) {
        self.showHomeStyle = style
        self.merchantId = merchantId
        super.init(nibName: nil, bundle: nil)
        self.gk_statusBarStyle = .lightContent
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
    
    lazy var infoSmoothView: GKPageSmoothView = {
        let smoothView = GKPageSmoothView(dataSource: self)
        smoothView.ceilPointHeight = kNavHeight
        smoothView.delegate = self
        return smoothView
    }()
    
    lazy var listView: TBMerchInfoPinLocationView = {
        return TBMerchInfoPinLocationView()
    }()
    
    
    lazy var headerView: TBMerchHeaderView = {
        let iv = TBMerchHeaderView()
        iv.showHomeStyle = self.showHomeStyle
        iv.containerView.delegate = self
        iv.frame = CGRect(x: 0, y: 0, width: screenWidth, height: kBaseHeaderHeight)
//        iv.containerView.merchTicketView.clickTicketViewHandler = {
//           let ticketPopView = TBMerchInfoTicketPopView()
//           ticketPopView.show()
//        }
        return iv
    }()

    lazy var headerViewContainer: UIView = {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: kBaseHeaderHeight))
        container.backgroundColor = .background
        
        container.addSubview(headerView)
        return headerView
    }()
    
    lazy var detailVc: TBMerchInfoDetailController = {
        let detail = TBMerchInfoDetailController(style: self.showHomeStyle, merchantId: merchantId)
       return detail
    }()
    
    private lazy var pinDataSource: JXSegmentedTitleDataSource? = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = self.showHomeStyle.pinDataSourceTitles()
        dataSource.titleSelectedColor = .tag
        dataSource.titleNormalColor = UIColor.hex(hexString: "#737373")
        dataSource.titleNormalFont = MYFont(size: 18)
        dataSource.titleSelectedFont = MYBlodFont(size: 18)
        return dataSource
    }()
    
    lazy var segmentContainerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: kBaseSegmentHeight))
        headerView.backgroundColor = .background
        
        headerView.addSubview(segmentView)
        return headerView
    }()
    
    lazy var segmentView: JXSegmentedView = {
        let segment = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: screenWidth - 40, height: kBaseSegmentHeight - 10))
        segment.dataSource = pinDataSource
        segment.delegate = self
        segment.defaultSelectedIndex = 0
        segment.backgroundColor = UIColor.background
        //配置指示器
        let indicator = JXSegmentedIndicatorImageView()
        indicator.image = UIImage(named: "home_segment_indicator")
        indicator.indicatorWidth = 11
        indicator.indicatorHeight = 11
        segment.indicators = [indicator]
        //segment.contentScrollView = contentView
        return segment
    }()
    
    lazy var cartBtn: XSMerchInfoCartButton = {
        return XSMerchInfoCartButton()
    }()
    
    
    private func ConfiginitSubviews() {
        view.addSubview(infoSmoothView)
        infoSmoothView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp_top).offset(0)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.snp_bottom)
        }
        infoSmoothView.reloadData()
        
        view.addSubview(cartBtn)
        cartBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.view.snp_bottom).offset(-60)
        }

    }
    
//    // 最好在初始化方法中设置gk_statusBarStyle，否则可能导致状态栏切换闪动问题
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        ConfiginitSubviews()

    }
    
    func setupNav() {
        //edgesForExtendedLayout = .all

        self.gk_navBarAlpha = 0
        self.gk_navTitle = ""
        self.gk_navTitleColor = .white
        self.gk_navLineHidden = true



        self.gk_navLeftBarButtonItem = self.backItem
        self.gk_navRightBarButtonItems = [shareItem, collectItem]
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)

    }
    
    override func initData() {
        super.initData()
        
        getMerchInfoHeaderData()
        getCartOrderInfo()
        
    }
    
    @objc func rightBuyButtonFirstClick(note: NSNotification) {
        guard let collectionViewCell =  note.userInfo?["TBMerchInfoDeliverCollectionViewCell"] as? TBMerchInfoDeliverCollectionViewCell  else { return }
        
        self.addCart(collectionViewCell: collectionViewCell)
    }
    
    @objc func selectStandardMenuFirstClick(note: NSNotification) {
        guard let collectionViewCell =  note.userInfo?["TBMerchInfoDeliverCollectionViewCell"] as? TBMerchInfoDeliverCollectionViewCell  else { return }
        
        self.addStandartCart(collectionViewCell)
    }
    
    @objc func cartPlusBtnClick(note: NSNotification) {
        guard let collectionViewCell =  note.userInfo?["TBMerchInfoDeliverCollectionViewCell"] as? TBMerchInfoDeliverCollectionViewCell  else { return }
        
        self.cartPlusBtnClick(collectionViewCell: collectionViewCell)
    }
    
    @objc func cartReduceClick(note: NSNotification) {
        guard let collectionViewCell =  note.userInfo?["TBMerchInfoDeliverCollectionViewCell"] as? TBMerchInfoDeliverCollectionViewCell  else { return }
        
        self.cartReduceBtnClick(collectionViewCell: collectionViewCell)
    }
    
    
    
    func addObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(rightBuyButtonFirstClick(note:)), name: NSNotification.Name.XSRightBuyButtonFirstClickNotification, object: nil)
        

        NotificationCenter.default.addObserver(self, selector: #selector(selectStandardMenuFirstClick(note:)), name: NSNotification.Name.XSSelectStandardMenuFirstClickNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(cartPlusBtnClick(note:)), name: NSNotification.Name.XSCartPlusBtnClickNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(cartReduceClick(note:)), name: NSNotification.Name.XSCartReduceClickNotification, object: nil)
        
    }
    
    
    func rightTableViewCell(_ collectionViewCell: TBMerchInfoDeliverCollectionViewCell, buyNumZero rightInfoModel: GoodsItemVo) {

        if rightInfoModel.isChoose == .isChoose {
            rightInfoModel.merchInfoShopState = .selectStandard
        } else {
            rightInfoModel.merchInfoShopState = .normal
        }
        
        rightInfoModel.buyOfNum = 0
        
        self.listView.tableView.reloadData()

    }
    
    /// 点击plusReduce了-号按钮
    func cartReduceBtnClick(collectionViewCell: TBMerchInfoDeliverCollectionViewCell){
        
        let model = collectionViewCell.goodsItem!
        
        if model.moreSpec == 0 {
            XSTipsHUD.showText("不同规格的商品需在购物车减购", inView: self.view, hideAfterDelay: 0.25)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                //self.delegate?.showShopCart()
            }
            return
        }
        
        let count = model.buyOfNum - 1
        let goodsId = model.goodsId
        
        MerchantInfoProvider.request(.updateOneSpecShoppingTrolleyCount(Int(count), goodsId: goodsId, merchantId: merchantId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
            if (returnData?.trueOrFalse ?? 0) == 0 {
                self?.getCartOrderInfo()
                
                model.buyOfNum -= 1
                
                if model.buyOfNum == 0 {
                    self?.rightTableViewCell(collectionViewCell, buyNumZero: model)
                }
                
                collectionViewCell.plusRaduceButton.buyNum = UInt(model.buyOfNum)
                //self?.listView.tableView.reloadData()

            }
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
        
    }
    
    func addCart(model: GoodsItemVo) {
        MerchantInfoProvider.request(.updateOneSpecShoppingTrolleyCount(Int(model.buyOfNum) + 1, goodsId: model.goodsId, merchantId: merchantId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
            if (returnData?.trueOrFalse ?? 0) == 0 {
                // 更新购物车底部的数量
                self?.getCartOrderInfo()
                
                // 变成有加减数量的按钮
                model.merchInfoShopState = .plusReduce
                
                model.buyOfNum += 1
                
                self?.listView.tableView.reloadData()
                
            }
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    /// 点击了+号按钮
    func cartPlusBtnClick(collectionViewCell: TBMerchInfoDeliverCollectionViewCell) {
        uLog("点击了+号按钮")
        
        let model = collectionViewCell.goodsItem!
        
        if model.isChoose == .isChoose { // 选多规格
            addStandartCart(collectionViewCell)
        } else { // 单规格
            addCart(model: model)
        }
    }
    
    /// 点击了选规格的情况
    func addStandartCart(_ collectionViewCell: TBMerchInfoDeliverCollectionViewCell) {
        let rightInfoModel = collectionViewCell.goodsItem!

        /// 选规格
        if rightInfoModel.isChoose == .isChoose {
            let popView = TBSelectStandardPopView()
            popView.goodsModel = rightInfoModel
            popView.joinCartSuccesHandler = { [weak self] count in
                // 获取加入购物车的数据
                self?.getCartOrderInfo()
                
                // 变成有加减数量的按钮
                rightInfoModel.merchInfoShopState = .plusReduce
                
                rightInfoModel.buyOfNum = rightInfoModel.buyOfNum + count
                
                self?.listView.tableView.reloadData()
                
            }
            popView.show()
        }
    }
    
    func addCart(collectionViewCell : TBMerchInfoDeliverCollectionViewCell) {
        let model = collectionViewCell.goodsItem!
        
        if model.isChoose == .isChoose { // 选多规格
            addStandartCart(collectionViewCell)
        } else { // 单规格
            let goodsId = model.goodsId
            
            MerchantInfoProvider.request(.updateOneSpecShoppingTrolleyCount(Int(model.buyOfNum) + 1, goodsId: goodsId, merchantId: merchantId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
                if (returnData?.trueOrFalse ?? 0) == 0 {
                    // 更新购物车底部的数量
                    self?.getCartOrderInfo()
                    
                    // 变成有加减数量的按钮
                    model.merchInfoShopState = .plusReduce
                    
                    model.buyOfNum += 1
                    
                    self?.listView.tableView.reloadData()
                    
                }
            } errorResult: { errorMsg in
                uLog(errorMsg)
                XSTipsHUD.showText(errorMsg)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
        conformUser2MerchantDistance()
    }

    @objc func shareAction() {
        
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
    
    @objc func cartBtnClick() {
        
    }
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }

}

// MARK: -  HttpRequest
extension TBGroupBuyMerchInfoViewController {
    
    func getDefaultCartOrderInfo() {
        MerchantInfoProvider.request(.getOrderMerchantInCarVO(merchantId), model: TBMerchInfoCartGoodInfoModel.self) { [weak self] returnData in
            if let cartGoodsInfoModel = returnData {
                
                self?.setCartAccountZero(false, cartGoodsInfoModel: cartGoodsInfoModel)
            }

        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

    }
    
    func setCartAccountZero(_ zero: Bool, cartGoodsInfoModel: TBMerchInfoCartGoodInfoModel ) {

        cartGoodsInfoModel.orderShoppingTrolleyVOList?.forEach({ orderShoppingTrolleyVOList in
            self.viemModel.sections.forEach { infoViewModel in
                infoViewModel.cellViewModels.forEach { infoModelProtocol in
                    if let delieveModel = infoModelProtocol as? TBDeliverModel {
                        delieveModel.goodsItems.forEach { goodsInfoModel in
                            if goodsInfoModel.goodsId == orderShoppingTrolleyVOList.goodsId {
                               if zero {
                                   goodsInfoModel.merchInfoShopState = goodsInfoModel.isChoose == .isChoose ? .selectStandard : .normal
                                   goodsInfoModel.buyOfNum = 0
                               } else {
       
                                   goodsInfoModel.merchInfoShopState = .plusReduce
                                   goodsInfoModel.buyOfNum += orderShoppingTrolleyVOList.account
                               }
                           }
                        }
                    }
                }
            }
        })
        
        self.listView.tableView.reloadData()
    }
    
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
        MerchantInfoProvider.request(.getOrderMerchantInCarVO(merchantId), model: TBMerchInfoCartGoodInfoModel.self) { returnData in
            if let cartGoodsInfoModel = returnData {
                
                self.cartBtn.cartNum = cartGoodsInfoModel.totalAccount
                
                
                
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
        
        cartBtn.cartNum = cartGoodsInfoModel.totalAccount
        //bottomCartView.cartGoodsInfoModel = cartGoodsInfoModel
    }
    
   @objc func getMerchInfoHeaderData() {
        // 0外卖，1团购,2私厨,3聚合
       MerchantInfoProvider.request(.getMerchantPage(lon, lat, merchantId, bizType: self.showHomeStyle.rawValue), model: TBDelieveMerchatInfoModel.self) { [weak self] returnData in
            guard let self = self else { return }
           
            if let dataModel = returnData {
                self.headerView.headerModel = dataModel
                self.headerInfoExpendView.setupData(dataModel)
                
                // 商家详情
                self.detailVc.setupDataModel(dataModel)
                
                
                self.checkMerchantState(dataModel: dataModel)
                
                
                let collBtn = self.collectItem.customView as! UIButton
                collBtn.isSelected = dataModel.isCollect
                
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    func checkMerchantState(dataModel: TBDelieveMerchatInfoModel) {
        /// 营业状态(0:正常营业;1:暂停营业;2:打样了
        if dataModel.merchantStatus == 1 {
            
            let msgView = TBBottomMsgView(msgText: "本店暂停营业，恢复营业后可点餐")
            self.view.addSubview(msgView)
            msgView.snp.makeConstraints { make in
                make.height.equalTo(46)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.view.usnp.bottom)
            }

        } else if(dataModel.merchantStatus == 2) {
            let msgView = TBBottomMsgView(msgText: "本店打烊了，今日预约明日\(dataModel.bookTime)后配送")
            self.view.addSubview(msgView)
            msgView.snp.makeConstraints { make in
                make.height.equalTo(46)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.view.usnp.bottom)
            }
            
        } else {// 在营业中
            // 判断是否在范围距离中
            conformUser2MerchantDistance()
        }
    }
    
}

// MARK: - GKPageSmoothViewDataSource && GKPageSmoothViewDelegate
extension TBGroupBuyMerchInfoViewController: GKPageSmoothViewDataSource,GKPageSmoothViewDelegate {
    func headerView(in smoothView: GKPageSmoothView) -> UIView {
        return headerViewContainer
    }
    
    func segmentedView(in smoothView: GKPageSmoothView) -> UIView {
        return segmentContainerView
    }
    
    func numberOfLists(in smoothView: GKPageSmoothView) -> Int {
        return 1
    }
    
    func smoothView(_ smoothView: GKPageSmoothView, initListAtIndex index: Int) -> GKPageSmoothListViewDelegate {
        initListViewData(view: listView)
        return listView
    }
    
    private func initListViewData(view listView: TBMerchInfoPinLocationView) {
        viemModel = TBMerchInfoViewModel(style: self.showHomeStyle)
        let falge = self.showHomeStyle == .multiple ? 0 : 1
        viemModel.getMerchantInfo(flage: falge, merchantId: merchantId)
        listView.viemModel = viemModel
        listView.merchantId = self.merchantId
        viemModel.completeConfigDataHandler = { dataModel in
            listView.datas = dataModel
            listView.tableView.reloadData()
            
            self.getDefaultCartOrderInfo()
        }
        
       
        
    }
    
    /// 当前列表滑动代理
    /// - Parameters:
    ///   - smoothView: smoothView
    ///   - scrollView: 当前的列表scrollView
    ///   - contentOffset: 转换后的contentOffset
    func smoothViewListScrollViewDidScroll(_ smoothView: GKPageSmoothView, scrollView: UIScrollView, contentOffset: CGPoint) {
        //let offsetY = scrollView.contentOffset.y
        //print("smoothViewListScrollViewDidScroll offsetY:\(offsetY)")
        /// 设置导航栏背景透明度
        setupNavcroll(smoothView, scrollView: scrollView, contentOffset: contentOffset)
        
        if !self.isAnimation {
            if !(scrollView.isTracking || scrollView.isDecelerating) {return}
        }
        
        // 用户滚动的才处理
        // 获取categoryView下面一点的所有部件信息，用于指定，当前最上方显示的那个section
        let categoryH = self.segmentView.frame.size.height
        let tableView = scrollView as! UITableView
        let topIndexPaths = tableView.indexPathsForRows(in: CGRect(x: 0, y: contentOffset.y + categoryH - self.headerView.frame.size.height + 40 + 10, width: tableView.frame.size.width, height: 200))
        let topIndexPath = topIndexPaths?.first
        if let indexPath = topIndexPath {
            let topSection = indexPath.section
            if self.segmentView.selectedIndex != topSection {
                self.segmentView.selectItemAt(index: topSection)
            }
        }
    }
    
    func setupNavcroll(_ smoothView: GKPageSmoothView, scrollView: UIScrollView, contentOffset: CGPoint) {
        let offsetY = contentOffset.y
        //uLog("offsetY:\(offsetY)")

        var navBarBackgroundAlpha: CGFloat = 0
        
        let collBtn = collectItem.customView as! UIButton
        let shareBtn = shareItem.customView as! UIButton
        let backBtn  = backItem.customView as! UIButton
        
        if offsetY > kBaseHeaderHeight - 90 {
            //navBarBackgroundAlpha = 1.0
            self.gk_statusBarStyle = .default
//
//            self.gk_navTitleColor = .black
//
            navBarBackgroundAlpha = 1.0
            self.gk_navTitle = ""
            
            backBtn.setImage(UIImage(named: "nav_back_black"), for: .normal)
            collBtn.setImage(UIImage(named: "nav_collect_black_icon"), for: .normal)
            shareBtn.setImage(UIImage(named: "nav_share_black_icon"), for: .normal)
            
            
        } else if(offsetY < 0) {
//            navBarBackgroundAlpha = 0
//            self.gk_statusBarStyle = .lightContent
//            self.gk_navTitleColor = .white
            
            navBarBackgroundAlpha = 0
            self.gk_statusBarStyle = .lightContent

            self.gk_navTitle = ""
            
            backBtn.setImage(UIImage(named: "nav_back_white"), for: .normal)
            collBtn.setImage(UIImage(named: "nav_collect_white_icon"), for: .normal)
            shareBtn.setImage(UIImage(named: "nav_share_white_icon"), for: .normal)
            
        } else {
            navBarBackgroundAlpha = offsetY / CGFloat(kBaseHeaderHeight - 90)
        }
        self.gk_navBarAlpha = navBarBackgroundAlpha
    }
    
}
// MARK: - TBMerchHeaderViewDelegate
extension TBGroupBuyMerchInfoViewController: TBMerchHeaderViewDelegate {
    func clickMerchInfoMoreButton(_ headerContainer: TBMerchHeaderTopContainer) {
        detailVc.detailModel = self.headerView.headerModel
        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func showPublishExpendView(_ headerContainer: TBMerchHeaderTopContainer) {
        self.view.addSubview(headerInfoExpendView)
        headerInfoExpendView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerContainer.ticketActivityView.snp_bottom).offset(0)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - JXSegmentedViewDelegate
extension TBGroupBuyMerchInfoViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        let tableView = self.infoSmoothView.currentListScrollView as! UITableView
        let frame = tableView.rectForHeader(inSection: index)
        //print("frame:\(frame)")
        
        var offsetY = frame.origin.y - 100 - 40
        let maxOffsetY = tableView.contentSize.height - tableView.frame.size.height

        if offsetY > maxOffsetY {
            offsetY = maxOffsetY
        }

        tableView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
    }
}

// MARK: - GKPinLoactionViewDelegate
extension TBGroupBuyMerchInfoViewController: GKPinLoactionViewDelegate {
    func locationViewDidEndAnimation(scrollView: UIScrollView) {
        self.isAnimation = false
    }
}
