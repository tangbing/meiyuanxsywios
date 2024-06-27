//
//  TBDelievePrivateKitGoodsInfoVc.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/15.
//  聚合，团购商家详情

import UIKit
//import GKNavigationBarSwift
//import JXSegmentedView
//import GKPageSmoothView
import JKSwiftExtension


class TBDelievePrivateKitGoodsInfoVc: XSBaseViewController {
    public var buyOfNum: Int = 0
    
    var showHomeStyle: HomeShowStyle = .deliver
    public var goodsId: String
    public var merchantId: String
    
    var sections = [TBMerchInfoViewModel]()

    lazy var collectItem: UIBarButtonItem = {
        return UIBarButtonItem.tb_item(title: nil, image: UIImage(named: "nav_collect_black_icon"), highLightImage: nil, selectEdImage: UIImage(named: "goodsInfo_love_select"), target: self, action: #selector(collectAction(collectionButton: )))
    }()

    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(headerFooterViewType: TBHomeDeliverReusableView.self)
        tableV.register(cellType: XSFootMarkTableViewCell.self)
        tableV.register(cellType: TBMerchInfoEvalateTableCellTop.self)
        tableV.register(cellType: TBMerchInfoEvaluateTableCell.self)
        tableV.register(cellType: TBGoodsInfoDetailTableViewCell.self)
        
        tableV.register(cellType: TBGoodsInfoTableViewCell.self)
        tableV.register(cellType: TBGoodsInfoHeaderApplyTicketTableViewCell.self)

        
        tableV.register(cellType: TBPicLocationPacketTitleTableViewCell.self)
        tableV.register(cellType: TBPicLocationPacketContentTableViewCell.self)
        tableV.register(cellType: TBPicLocationBuyMustTableViewCell.self)
        tableV.register(cellType: XSPicLocationPacketMoreTableViewCell.self)
        tableV.register(cellType: TBPicLocationApplyMerchTableViewCell.self)
        
        tableV.register(cellType: TBGoodsInfoHeaderViewPicCell.self)
        tableV.register(cellType: TBGoodsInfoTableViewCell.self)
        tableV.register(cellType: TBGoodsInfoHeaderApplyTicketTableViewCell.self)
        return tableV
    }()
    
    lazy var popView: TBCartPopView = {
        return TBCartPopView()
    }()
    
    lazy var bottomCartView: TBCartBottomView = {
        let bottomView = TBCartBottomView.loadFromNib()
        bottomView.cartBottomClickHandler = { [weak self] bottomView in
            self?.popView.getCartOrderInfo(merchantId: self?.merchantId ?? "")
            self?.popView.cartClarAllHandler = { [weak self] popViw in
                
                bottomView.cartNumBadge = 0
                self?.buyOfNum = 0
                
            }
            self?.popView.show(showSuperView: self?.view, bottomSpace: bottomCartViewH)
            self?.view.bringSubviewToFront(bottomView)

            /// 将一个UIView显示在最前面,调用其父视图的 bringSubviewToFront（）
            /// 将一个UIView层推送到背后,调用其父视图的 sendSubviewToBack（）
        }
        return bottomView
    }()
    
    init(style: HomeShowStyle, merchantId: String, goodsId: String) {
        self.showHomeStyle = style
        self.merchantId = merchantId
        self.goodsId = goodsId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func initSubviews() {
        super.initSubviews()
        
        if showHomeStyle == .groupBuy {
            
        } else {
            self.view.addSubview(bottomCartView)
            
            bottomCartView.snp.makeConstraints { make in
                make.height.equalTo(bottomCartViewH)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.view.usnp.bottom)
            }
            
        }
        
      
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets.init(top: 0, left: 0, bottom: bottomInset + bottomCartViewH, right: 0))
        }
        
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        self.navigationTitle = "商品详情"
        
        let shareItem = UIBarButtonItem.gk_item(image:UIImage(named: "nav_share_black_icon"), target: self, action: #selector(shareAction))
        self.navigationItem.rightBarButtonItems = [collectItem, shareItem]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCartOrderInfo()
        conformUser2MerchantDistance()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(shopCartPopViewReduceClick(notice:)), name: NSNotification.Name.XSCartMerchInfoPopCellReduceBtnClickNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(shopCartPopViewPlusClick(notice:)), name: NSNotification.Name.XSCartMerchInfoPopCellplusBtnClickNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchRequestData), name: NSNotification.Name.XSUpdateMerchHeadrInfoNotification, object: nil)
        
        
       
        
        fetchRequestData()
        
        
    }
    
    @objc func shareAction() {
        print(#function)
    }
    @objc func collectAction(collectionButton: UIButton) {
        let collectType = collectionButton.isSelected ? 1 : 0
        
        if merchantId.isEmpty {
            uLog("merchantId 为nil!")
            return
        }
        
        MerchantInfoProvider.request(.saveCollectGoods(_merchantId: merchantId, goodsId: goodsId, goodsType: self.showHomeStyle.rawValue, type: collectType), model: XSMerchInfoHandlerModel.self) { returnData in
            
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
    
}

// MARK: - NSNotification
extension TBDelievePrivateKitGoodsInfoVc {
    
    @objc func fetchRequestData() {
        
        let viemModel = TBMerchInfoViewModel(style: self.showHomeStyle)
        XSTipsHUD.showLoading("", inView: self.view)
        viemModel.fetchGoodsInfoData(bizType: self.showHomeStyle.rawValue, goodsId: goodsId)
        viemModel.delegate = self
        
     
        
        // fetchGoodsInfoData(bizType: self.showHomeStyle.rawValue)
     }
    
    @objc func shopCartPopViewPlusClick(notice: NSNotification) {
        
        //guard let model = notice.userInfo?["OrderShoppingTrolleyVOList"] as? OrderShoppingTrolleyVOList
              //else { return }
        
        self.getCartOrderInfo()
        
        self.buyOfNum += 1
        
    }
    
    @objc func shopCartPopViewReduceClick(notice: NSNotification) {
        
        //guard let model = notice.userInfo?["OrderShoppingTrolleyVOList"] as? OrderShoppingTrolleyVOList
              //else { return }
        
        self.getCartOrderInfo()
        
        self.buyOfNum -= 1
        
    }
}

extension TBDelievePrivateKitGoodsInfoVc: TBMerchInfoViewModelDelegate {
    func onFetchComplete(_ isCollection: Bool, goodsItem: TBGoodsItemModel, _ sections: [TBMerchInfoViewModel]) {
        XSTipsHUD.hideAllTips(inView: self.view)

        // 收藏
        let collBtn = collectItem.customView as! UIButton
        collBtn.isSelected = isCollection
        
        self.sections = sections
        tableView.reloadData()
        
        
    }
    
    
    func onFetchFailed(with reason: String) {
        XSTipsHUD.hideAllTips(inView: self.view)
        XSTipsHUD.showText(reason)
    }
    
}

// MARK: - HttpRequest
extension TBDelievePrivateKitGoodsInfoVc {
    
    func getCartOrderInfo() {
        MerchantInfoProvider.request(.getOrderMerchantInCarVO(merchantId), model: TBMerchInfoCartGoodInfoModel.self) { returnData in
            if let cartGoodsInfoModel = returnData {
                
                self.bottomCartView.cartGoodsInfoModel = cartGoodsInfoModel
                
                self.buyOfNum = cartGoodsInfoModel.totalAccount

//                cartGoodsInfoModel.orderShoppingTrolleyVOList?.forEach({ trolleyVOList in
//                    if trolleyVOList.goodsId == goodsId {
//                        self.buyOfNum = Int(trolleyVOList.account)
//                    }
//                })
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
    
}

extension TBDelievePrivateKitGoodsInfoVc: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = sections[section]
        let count = sectionModel.cellViewModels.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = sections[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        
        switch rowModel.style {
        case .detainInfo:
             let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoDetailTableViewCell.self)
             let detail = rowModel as! TBShopInfoDetailModel
             cell.detailModel = detail
            return cell
        case .evalutateTop:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvalateTableCellTop.self)
            cell.detailModel = rowModel as? TBRepeatTotalModel
            return cell
        case .evalutate:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvaluateTableCell.self)
            cell.configureRepeatModel(repeatModel: rowModel as! TBRepeatModel)
            return cell
        case .recommand:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSFootMarkTableViewCell.self)
            cell.configShopInfoUI()
            return cell
        case .packageDetailInfoTitle:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBPicLocationPacketTitleTableViewCell.self)
            let model = rowModel as! TBShopInfoPacketDetailInfoTitleModel
            cell.infoModel = model
            return cell
        case .packageDetailInfoContent:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBPicLocationPacketContentTableViewCell.self)
            let model = rowModel as! TBShopInfoPacketDetailInfoContentModel
            cell.infoModel = model
            return cell
        case .packageDetailMore:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSPicLocationPacketMoreTableViewCell.self)
            let model = rowModel as! TBShopInfoPacketDetailMoreModel
            cell.moreModel = model
            return cell
        case .goodsInfoPicArray:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoHeaderViewPicCell.self)
            let pics = rowModel as! TBGoodsInfoHeaderPiclModel
            cell.picAddress = pics.picAddress
            return cell
        case .goodsInfoItem:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoTableViewCell.self)
            let goods = rowModel as? TBGoodsInfoHeaderGoodsModel
            if let goodsItem = goods?.goodsItem
            {
                cell.goodsItem = goodsItem
                
                cell.addCartBtnClickHandler = { [weak self] goodsModel in
                    guard let self = self else {
                        return
                    }
                    self.addCartBtnClick(goodsModel)

                }
            }
            
            if let groupBuyItem = goods?.groupBuyGoodsItem {
                cell.groupBuyItem = groupBuyItem
            }

            return cell
        case .goodsInfoTicket:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoHeaderApplyTicketTableViewCell.self)
            let ticket = rowModel as! TBGoodsInfoHeaderTicketModel
            cell.ticketDataModel = ticket

            return cell
        default:
            return UITableViewCell()
      }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = sections[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        return rowModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = sections[section]
        guard let _ = sectionModel.sectionHeaderTitle else {
            return 0.0001
        }
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionModel = sections[section]
        guard let sectionHeaderTitle = sectionModel.sectionHeaderTitle else {
            return nil
        }
        
        let header = tableView.dequeueReusableHeaderFooterView(TBHomeDeliverReusableView.self)!
        header.configMerchInfo(more: sectionModel.sectionHeaderSubTitle)
        header.indicatorTitle.text = sectionHeaderTitle

        header.moreBtnClickHandler = { header in
            //guard let self = self else { return }
            
            let moreEvaluate = XSMerchInfoMoreEvaluateViewController(merchantId: self.merchantId)
            topVC?.navigationController?.pushViewController(moreEvaluate, animated: true)
            
        }
        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }
}

// MARK: - addCartBtnClick
extension TBDelievePrivateKitGoodsInfoVc {
    func addCartBtnClick(_ goodsItem: TBTakeoutGoodsItem) {
        
        /// 可选规格 0：可选 1：不可选
        if (goodsItem.isChoose == 0) {
            
            let popView = TBSelectStandardPopView()
            
            let model = goodsItem
            let goods = GoodsItemVo.init(model.goodsName, picAddress: model.picAddress.first!, finalPrice: model.finalPrice, originalPrice: model.originalPrice, discountStr: model.promotion,
                merchantId:self.merchantId, goodsId: model.goodsId, specItem: model.specItem, attributesItem: model.attributesItem)
            popView.goodsModel = goods
            popView.show()
            
            popView.joinCartSuccesHandler = { [weak self] count in
                // 获取加入购物车的数据
                self?.getCartOrderInfo()
                
                self?.buyOfNum += Int(count)
            }
            
        } else {
            let goodsId = goodsItem.goodsId
            
            MerchantInfoProvider.request(.updateOneSpecShoppingTrolleyCount(buyOfNum + 1 , goodsId: goodsId, merchantId: merchantId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
                if (returnData?.trueOrFalse ?? 0) == 0 {
                    // 更新购物车底部的数量
                    self?.getCartOrderInfo()
                    self?.buyOfNum += 1
                }
            } errorResult: { errorMsg in
                uLog(errorMsg)
                XSTipsHUD.showText(errorMsg)
            }
        }
    }
    

}

//// MARK: - GKPageSmoothViewDataSource && GKPageSmoothViewDelegate
//extension TBHomeGroupBuyGoodsInfoVc: GKPageSmoothViewDataSource,GKPageSmoothViewDelegate {
//    func headerView(in smoothView: GKPageSmoothView) -> UIView {
//        return headerView
//    }
//    
//    func segmentedView(in smoothView: GKPageSmoothView) -> UIView {
//        return segmentContainerView
//    }
//    
//    func numberOfLists(in smoothView: GKPageSmoothView) -> Int {
//        return 1
//    }
//    
//    func smoothView(_ smoothView: GKPageSmoothView, initListAtIndex index: Int) -> GKPageSmoothListViewDelegate {
//        listView.style = self.showHomeStyle
//        return listView
//    }
//    
//    private func initListViewData(view listView: TBGoodsInfoPinLocationView) {
//        //let viemModel = TBMerchInfoViewModel(style: self.showHomeStyle)
//        //viemModel.fetchGoodsInfoData(bizType: self.showHomeStyle.rawValue)
//
//        
//        listView.sections = self.sections
//        listView.tableView.reloadData()
//
//    }
//    
//    /// 当前列表滑动代理
//    /// - Parameters:
//    ///   - smoothView: smoothView
//    ///   - scrollView: 当前的列表scrollView
//    ///   - contentOffset: 转换后的contentOffset
//    func smoothViewListScrollViewDidScroll(_ smoothView: GKPageSmoothView, scrollView: UIScrollView, contentOffset: CGPoint) {
//        //let offsetY = scrollView.contentOffset.y
//        //print("smoothViewListScrollViewDidScroll offsetY:\(offsetY)")
//        /// 设置导航栏背景透明度
//        setupNavcroll(smoothView, scrollView: scrollView, contentOffset: contentOffset)
//        
////        if !self.isAnimation {
////            if !(scrollView.isTracking || scrollView.isDecelerating) {return}
////        }
//        
//        // 用户滚动的才处理
//        // 获取categoryView下面一点的所有部件信息，用于指定，当前最上方显示的那个section
//        let categoryH = self.segmentView.frame.size.height
//        let tableView = scrollView as! UITableView
//        let topIndexPaths = tableView.indexPathsForRows(in: CGRect(x: 0, y: contentOffset.y + categoryH - self.headerView.frame.size.height + 40 + 10, width: tableView.frame.size.width, height: 200))
//        let topIndexPath = topIndexPaths?.first
//        if let indexPath = topIndexPath {
//            let topSection = indexPath.section
//            if self.segmentView.selectedIndex != topSection {
//                self.segmentView.selectItemAt(index: topSection)
//            }
//        }
//    }
//    
//    func setupNavcroll(_ smoothView: GKPageSmoothView, scrollView: UIScrollView, contentOffset: CGPoint) {
//        let offsetY = contentOffset.y
//        //uLog("offsetY:\(offsetY)")
//
//        var navBarBackgroundAlpha: CGFloat = 0
//        
//        if offsetY > kBaseHeaderHeight - 90 {
//            navBarBackgroundAlpha = 1.0
//            self.gk_statusBarStyle = .default
//            self.gk_navLeftBarButtonItem = UIBarButtonItem.gk_item(image: UIImage(named: "nav_back_black")!, target: self, action: #selector(backAction))
//            let shareItem = UIBarButtonItem.gk_item(image:UIImage(named: "nav_share_black_icon"), target: self, action: #selector(shareAction))
//            collectItem = UIBarButtonItem.gk_item(image:UIImage(named: "nav_collect_black_icon"), target: self, action: #selector(collectAction))
//            self.gk_navRightBarButtonItems = [shareItem, collectItem]
//            self.gk_navTitleColor = .black
//            
//        } else if(offsetY < 0) {
//            navBarBackgroundAlpha = 0
//            self.gk_statusBarStyle = .lightContent
//            self.gk_navLeftBarButtonItem = UIBarButtonItem.gk_item(image: UIImage(named: "nav_back_white")!, target: self, action: #selector(backAction))
//            let shareItem = UIBarButtonItem.gk_item(image:UIImage(named: "nav_share_white_icon"), target: self, action: #selector(shareAction))
//            collectItem = UIBarButtonItem.gk_item(image:UIImage(named: "nav_collect_white_icon"), target: self, action: #selector(collectAction))
//            self.gk_navRightBarButtonItems = [shareItem, collectItem]
//            self.gk_navTitleColor = .white
//            
//        } else {
//            navBarBackgroundAlpha = offsetY / CGFloat(kBaseHeaderHeight - 90)
//        }
//        self.gk_navBarAlpha = navBarBackgroundAlpha
//    }
//    
//}
// MARK: - TBMerchHeaderViewDelegate
extension TBDelievePrivateKitGoodsInfoVc: TBMerchHeaderViewDelegate {
    func clickMerchInfoMoreButton(_ headerContainer: TBMerchHeaderTopContainer) {
        // 外卖，私厨，顶部详情跳转隐藏掉了，
//        let detailVc = TBMerchInfoDetailController(style: showHomeStyle)
//        self.navigationController?.pushViewController(detailVc, animated: true)
    }
    
    func showPublishExpendView(_ headerContainer: TBMerchHeaderTopContainer) {
        let iv = TBMerchInfoExpendView()
        self.view.addSubview(iv)
        iv.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerContainer.ticketActivityView.snp_bottom).offset(0)
            make.bottom.equalToSuperview()
        }
    }
}

//// MARK: - JXSegmentedViewDelegate
//extension TBHomeGroupBuyGoodsInfoVc: JXSegmentedViewDelegate {
//    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
//        let tableView = self.infoSmoothView.currentListScrollView as! UITableView
//        let frame = tableView.rectForHeader(inSection: index)
//        print("frame:\(frame)")
//
//        var offsetY = frame.origin.y - 100 - 40
//        let maxOffsetY = tableView.contentSize.height - tableView.frame.size.height
//
//        if offsetY > maxOffsetY {
//            offsetY = maxOffsetY
//        }
//
//        tableView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
//    }
//}

