//
//  XSHomeFindShopFoodViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/27.
//

import UIKit
import GKPageScrollView

class XSHomeFindShopFoodViewController: XSBaseViewController {
    
    var showStyle: HomeShowStyle = .multiple
    private var pageIndex: Int = 0
    
    var findShopFoodDataModel :[XSHomeFindShopFoodData] = [XSHomeFindShopFoodData]()
    

    init(style homeShowStyle: HomeShowStyle = .multiple ) {
        self.showStyle = homeShowStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var filterVcs: [UIViewController] {
        if showStyle == .multiple {
            
           return [
            XSHomeLocationFilterViewController(isTwoStepFilter: false),
            XSHomeLocationFilterViewController(isTwoStepFilter: true),
            XSHomeLocationFilterViewController(isTwoStepFilter: false),
            XSHomeSelectFilterViewController(selectFilterStyle: .homeDefault)]
            
        } else if(showStyle == .deliver) {
           return [XSHomeLocationFilterViewController(isTwoStepFilter: false),
                             XSHomeLocationFilterViewController(isTwoStepFilter: true),
                             XSHomeLocationFilterViewController(isTwoStepFilter: false),
                             XSHomeSelectFilterViewController(selectFilterStyle: .delivery)]
        } else {
            return [XSHomeLocationFilterViewController(isTwoStepFilter: false),
                              XSHomeLocationFilterViewController(isTwoStepFilter: true),
                              XSHomeLocationFilterViewController(isTwoStepFilter: false),
                              XSHomeSelectFilterViewController(selectFilterStyle: .groupBy)]
        }
    }
    
  
    
//    let modelData: [HomeFindFoodModel] = [
//        HomeFindFoodModel(productName: "金石医学是一家专业从事临床检验服务的独立医学检验实验室。目前开设有临床细胞分子遗传学专业、分子生物学专业，设置基因扩增室等传统实验室，拥有多种基因检测、诊断技术平台，配备各类先进设备及完整的医学实验室质量管理体系，承担相应的临床医学检验业务及科研业务。原本是复星医药集团下属全资子公司，2021年9月被出售。", type: 0, style: .custom),
//
//        HomeFindFoodModel(productName: "行膳有味行膳1", type: 1,style: .custom),
//
//
//        HomeFindFoodModel(productName: "金石医学是一家专业从事临床检验服务的独立医学检验实验室。目前开设有临床细胞分子遗传学专业、分子生物学专业，设置基因扩增室等传统实验室，拥有多种基因检测、诊断技术平台，配备各类先进设备及完整的医学实验室质量管理体系，承担相应的临床医学检验业务及科研业务。原本是复星医药集团下属全资子公司，2021年9月被出售。", type: 0,style: .meituan),
//        HomeFindFoodModel(productName: "行膳有味行甄营养套餐商家名称的行膳有味行膳食界康美甄营养套餐商家名称的行膳有味行膳食界康美甄营养套餐商家名称的行膳有味行膳食界康美甄营养套餐商家名称的行膳有味行膳食界康美甄营养套餐商家名称的行膳有味行膳食界康美甄营养套餐商家名称的行膳有味行膳食界康美甄营养套餐商家名称的", type: 1,style: .meituan),
//
//
//        HomeFindFoodModel(productName: "NFT中国是一个NFT数字资产上链、推广、交易综合性平台。公司志在打造人人都能参与的NFT生态，建立了完善的创作者发掘、孵化机制，为海内外用户提供优质的数字资产和一站式交易基础设施。杭州原与宙科技有限公司旗下产品。", type: 0,style: .apprivePay),
//        HomeFindFoodModel(productName: "行膳有味行膳", type: 1,style: .apprivePay),
//
//        HomeFindFoodModel(productName: "NFT中国是一个NFT数字资产上链、推广、交易综合性平台。公司志在打造人人都能参与的NFT生态，建立了完善的创作者发掘、孵化机制，为海内外用户提供优质的数字资产和一站式交易基础设施。杭州原与宙科技有限公司旗下产品。", type: 0,style: .other),
//        HomeFindFoodModel(productName: "行膳有味行膳", type: 1,style: .other)
//
//    ]
    
    var scrollCallBack: ((UIScrollView) -> ())?

    lazy var pullDownMenu: TBPullDownMenu  = {
        let menu = TBPullDownMenu(showInView: self.view,dataSource: self)
        menu.frame = CGRect(x: 0, y: 0, width: screenWidth - 20, height: 40)
        menu.delegate = self
        return menu
    }()

    lazy var menuContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = .background
        container.addSubview(pullDownMenu)
        return container
    }()

    lazy var shopProductView: UICollectionView = {
        let layout = WaterfallMutiSectionFlowLayout()
        layout.delegate = self
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .background
        collectionView.register(cellType: XSFindShopFoodKitChenCollectionViewCell.self)
        collectionView.register(cellType: XSFindShopFoodArrivePayCollectionViewCell.self)
        collectionView.register(cellType: XSFindShopFoodMeituanCollectionViewCell.self)
        collectionView.register(cellType: XSFindShopFoodArriveMeituanPayCollectionViewCell.self)

        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
    }
    
    override func initSubviews() {
        self.view.backgroundColor = .background

        self.view.addSubview(menuContainerView)
        menuContainerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(self.view)
            $0.height.equalTo(pullDownMenuH)
        }

        
        self.view.addSubview(shopProductView)
        shopProductView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(menuContainerView.snp_bottom).offset(0)
            $0.bottom.equalTo(self.view)

        }
    }
    
}

// MARK: - HttpRequest
extension XSHomeFindShopFoodViewController {
    
    func setupRefresh() {
        
//        self.tableView.mj_header = URefreshAutoHeader(refreshingTarget: self, refreshingAction: #selector(headerRereshing))
       
        self.shopProductView.uFoot = URefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(footerRereshing))
        
        self.shopProductView.mj_footer?.beginRefreshing()
        
        
    }
    
//    @objc private func headerRereshing() {
//        self.loadData(isRefresh: true)
//    }
    @objc private func footerRereshing() {
        self.loadData(isRefresh: false)

    }
    
    func loadData(isRefresh: Bool) {
        
        var pageIndex = 0
        if isRefresh {
            pageIndex = 1
            self.pageIndex = 1
        } else {
            pageIndex = self.pageIndex + 1
        }
        
        MerchantInfoProvider.request(.getComprehensive(latitude: lat, longitude: lon, page: pageIndex, pageSize: pageSize), model: XSHomeFindShopFoodModel.self) { returnData in
            
            //guard let self = self else { return }
            
            guard let findShopGoodsData = returnData else {
                return
            }
            
            let findShopGoodsDatas = findShopGoodsData.data
            let count = findShopGoodsData.count
            
            if isRefresh {
                self.findShopFoodDataModel = findShopGoodsDatas

                self.shopProductView.mj_footer?.isHidden = !(self.findShopFoodDataModel.count > 0)
                if self.shopProductView.mj_footer?.state == .noMoreData {
                    self.shopProductView.mj_footer?.state = .idle
                }
            } else {
                self.findShopFoodDataModel.appends(findShopGoodsDatas)
                self.pageIndex += 1
            }
            
            if self.findShopFoodDataModel.count > 0 && count <= self.findShopFoodDataModel.count {
                self.shopProductView.mj_footer?.state = .noMoreData
            }
            self.endLoad(isRefresh: isRefresh)
            
        } errorResult: { errorMsg in
            XSTipsHUD.showError("加载失败，请重试")
            self.endLoad(isRefresh: isRefresh)
        }

    }
    
    func endLoad(isRefresh: Bool) {
        self.shopProductView.reloadData()
        if isRefresh {
            self.shopProductView.mj_header?.endRefreshing()
        } else if(!(self.shopProductView.mj_footer?.isHidden ?? true)) {
            if(self.shopProductView.mj_footer?.state != .noMoreData) {
                self.shopProductView.mj_footer?.endRefreshing()
            }
        }
    }
    
//    private func loadData() {
//        MerchantInfoProvider.request(.getComprehensive(latitude: lat, longitude: lon, page: 1, pageSize: pageSize), model: TBCommendShopDataModel.self) { returnData in
//
//            if let moreModel = returnData {
//
//                guard let more = moreModel.data?.compactMap({ coupon -> TBMerchInfoModelProtocol in
//                    TBMerchMoreModel(data: coupon, count: moreModel.count,code: moreModel.code)
//                }) else {
//                    return
//                }
//
//                
//
//            }
//
//        } errorResult: { errorMsg in
//            print(errorMsg)
//            XSTipsHUD.showText(errorMsg)
//        }
//    }
}

extension XSHomeFindShopFoodViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return findShopFoodDataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let model = findShopFoodDataModel[indexPath.item]
        switch model.style {
        case .delieve:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSFindShopFoodMeituanCollectionViewCell.self)
            cell.configureUI(shopFoodModel: model)
            return cell
        case .groupBuy:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSFindShopFoodArrivePayCollectionViewCell.self)
            cell.configureUI(shopFoodModel: model)
            return cell
        case .privateKit:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSFindShopFoodKitChenCollectionViewCell.self)
            cell.configureUI(shopFoodModel: model)
            return cell
        case .other:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSFindShopFoodArriveMeituanPayCollectionViewCell.self)
            cell.configureUI(shopFoodModel: model)
            return cell
            
        }
    }
    
}

extension XSHomeFindShopFoodViewController: WaterfallMutiSectionDelegate {
    func heightForRowAtIndexPath(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat {
        
        let model = findShopFoodDataModel[indexPath.item]
        return model.cellHeight
    }
    func columnNumber(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, section: Int) -> Int {
        return 2
    }
    
    func lineSpacing(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, section: Int) -> CGFloat {
      return 10
    }
    
    func interitemSpacing(collectionView collection: UICollectionView, layout: WaterfallMutiSectionFlowLayout, section: Int) -> CGFloat {
      return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = findShopFoodDataModel[indexPath.item]
        if model.bizType == 0 || model.bizType == 1 { // 商家
            
        } else if(model.bizType == 2) { // 商品
            
            let goodsInfo = XSGoodsInfoGroupBuyTicketViewController(style: .multiple, merchantId: model.merchantId, goodId: nil)
            self.navigationController?.pushViewController(goodsInfo, animated: true)
        }  else { // 优惠券
            let ticket = XSGoodsInfoGroupBuyTicketViewController(style: .ticket, merchantId: model.merchantId, goodId: nil)
            self.navigationController?.pushViewController(ticket, animated: true)
        }
        
        //self.navigationController?.pushViewController(TBGroupBuyMerchInfoViewController(style: showStyle), animated: true)
    }
    
}

extension XSHomeFindShopFoodViewController: TBPullDownMenuDataSource, XSHomeSelectMenuClickDelegate {
    func numberOfColsInMenu(pullDownMenu: TBPullDownMenu) -> NSInteger {
        return self.filterVcs.count
    }
    
    func viewControllerForColAtIndex(index: NSInteger, pullDownMenu: TBPullDownMenu) -> UIViewController {
        return filterVcs[index]
    }
    
    func heightForColAtIndex(index: NSInteger, pullDownMenu: TBPullDownMenu) -> CGFloat {
       return 235
    }
    
    func clickSelectMenu(selectMenu: TBPullDownMenu, selectTitle selectMenuTitle: String) {
        print("titles" + selectMenuTitle)
        //menuBtnShowClick()
    }
    
//    private func menuBtnShowClick() {
//        if self.isViewLoaded && (self.view.window != nil) {
//            UIView.animate(withDuration: 0.3) {
//                self.pageScrollView.mainTableView.contentOffset = CGPoint(x: 0, y: self.headerH)
//                self.pageScrollView.mainTableView.isScrollEnabled = false
//            }
//        }
//    }
//    private func menuBtnDismissClick() {
//        if self.isViewLoaded && (self.view.window != nil) {
//            self.pageScrollView.mainTableView.isScrollEnabled = true
//        }
//    }

    
}


extension XSHomeFindShopFoodViewController: GKPageListViewDelegate {
    func listScrollView() -> UIScrollView {
        return self.shopProductView
    }
    
    func listViewDidScroll(callBack: @escaping (UIScrollView) -> ()) {
        self.scrollCallBack = callBack
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollCallBack!(scrollView)
    }

}
