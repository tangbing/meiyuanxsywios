//
//  XSHomeFindFoodViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/26.
//

import UIKit
import GKPageScrollView
import JKSwiftExtension

// 0外卖，1团购,2私厨,3聚合, 5代金券
enum HomeShowStyle: Int {
    case deliver = 0
    case groupBuy
    case privateKitchen
    case multiple
    case ticket = 5
    
    func pinDataSourceTitles() -> [String] {
        switch self {
        case .groupBuy:
            return ["优惠", "套餐", "评价"]
        default:
            return ["优惠", "套餐","外卖", "评价"]
        }
    }
    
    func pinSectionTitles() -> [String?] {
        switch self {
        case .groupBuy:
            return [nil, "到店套餐", "餐厅评价","更多商家"]
        default:
           return [nil, "到店套餐","外卖", "餐厅评价","更多商家"]
            //return [nil, "到店套餐", "餐厅评价","更多商家"]
        }
    }
    
    func pinGoodsInfoSectionTitles() -> [String?] {
        switch self {
        case .deliver, .privateKitchen:
            return [nil, "菜品评价"]
        case .groupBuy:
           return [nil, "套餐详情", "购买须知","套餐评价"]
        case .ticket:
           return [nil, "购买须知","套餐评价"]
        case .multiple:
            return []
        }
    }
    
}

class XSHomeFindFoodViewController: XSBaseViewController {

    var scrollCallBack: ((UIScrollView) -> ())?
    var showStyle: HomeShowStyle = .multiple
    var discoverGoods: [XSHomeFindFoodData] = [XSHomeFindFoodData]()
    private var pageIndex: Int = 0
    
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
    
    lazy var pullDownMenu: TBPullDownMenu  = {
        let menu = TBPullDownMenu(showInView: self.view,dataSource: self)
        menu.frame = CGRect(x: 0, y: 0, width: screenWidth - 20, height: 40)
        menu.delegate = self
        return menu
    }()

    lazy var menuContainerView: UIView = {
        let container = UIView()
        container.frame = CGRect(x: 10, y: 0, width: screenWidth - 20, height: pullDownMenuH)
        container.backgroundColor = .background
        container.addSubview(pullDownMenu)
        return container
    }()
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.rowHeight = 110
        tableV.dataSource = self
        tableV.delegate = self
        if #available(iOS 11.0, *) {
            tableV.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        tableV.register(cellType: XSCollectMerchTableCell.self)
        return tableV;
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
    }
    
    override func initSubviews() {
        
        self.view.addSubview(menuContainerView)
        menuContainerView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(self.view)
            $0.height.equalTo(pullDownMenuH)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(menuContainerView.snp_bottom).offset(0)
            $0.bottom.equalTo(self.view)
        }
    }
    
}

// MARK: - HttpRequest
extension XSHomeFindFoodViewController {
    
    func setupRefresh() {
        
//        self.tableView.mj_header = URefreshAutoHeader(refreshingTarget: self, refreshingAction: #selector(headerRereshing))
       
        self.tableView.uFoot = URefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(footerRereshing))
        
        self.tableView.mj_footer?.beginRefreshing()
        
        
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
        
        MerchantInfoProvider.request(.discoverGoodDishes(latitude: lat, longitude: lon, page: pageIndex, pageSize: pageSize), model: XSHomeFindFoodModel.self) { returnData in
            
            //guard let self = self else { return }
            
            guard let discoverGood = returnData else {
                return
            }
            
            let discoverGoods = discoverGood.data
            let count = discoverGood.count
            
            if isRefresh {
                self.discoverGoods = discoverGoods

                self.tableView.mj_footer?.isHidden = !(self.discoverGoods.count > 0)
                if self.tableView.mj_footer?.state == .noMoreData {
                    self.tableView.mj_footer?.state = .idle
                }
            } else {
                self.discoverGoods.appends(discoverGoods)
                self.pageIndex += 1
            }
            
            if self.discoverGoods.count > 0 && count <= self.discoverGoods.count {
                self.tableView.mj_footer?.state = .noMoreData
            }
            self.endLoad(isRefresh: isRefresh)
            
        } errorResult: { errorMsg in
            XSTipsHUD.showError("加载失败，请重试")
            self.endLoad(isRefresh: isRefresh)
        }

    }
    
    func endLoad(isRefresh: Bool) {
        self.tableView.reloadData()
        if isRefresh {
            self.tableView.mj_header?.endRefreshing()
        } else if(!(self.tableView.mj_footer?.isHidden ?? true)) {
            if(self.tableView.mj_footer?.state != .noMoreData) {
                self.tableView.mj_footer?.endRefreshing()
            }
        }
    }
    
//    private func loadDiscoverGoodData() {
//        MerchantInfoProvider.request(.discoverGoodDishes(latitude: lat, longitude: lon, page: 1, pageSize: pageSize), model: XSHomeFindFoodModel.self) { returnData in
//
//            if let discoverGood = returnData {
//                self.discoverGoodModel = discoverGood
//                self.tableView.reloadData()
//                self.tableView.uFoot.beginRefreshing()
//            }
//
//        } errorResult: { errorMsg in
//            print(errorMsg)
//            XSTipsHUD.showText(errorMsg)
//        }
//    }
}

extension XSHomeFindFoodViewController: TBPullDownMenuDataSource, XSHomeSelectMenuClickDelegate {
    func numberOfColsInMenu(pullDownMenu: TBPullDownMenu) -> NSInteger {
        return self.filterVcs.count
    }
    
    func viewControllerForColAtIndex(index: NSInteger, pullDownMenu: TBPullDownMenu) -> UIViewController {
        return filterVcs[index]
    }
    
    func heightForColAtIndex(index: NSInteger, pullDownMenu: TBPullDownMenu) -> CGFloat {
        235
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

extension XSHomeFindFoodViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return discoverGoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSCollectMerchTableCell.self)
        if self.showStyle == .groupBuy {
            cell.addressView.configGroupBuy()
        } else if(self.showStyle == .privateKitchen){
            cell.addressView.configPrivateKitchen()
        }
        cell.findFoodModel = discoverGoods[indexPath.section]
        cell.addCartClickHandler = { idx in
            print("click 加入购物车 \(idx) cell")
        }
        cell.index = indexPath.section
        return cell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.background
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let findFoodModel = discoverGoods[indexPath.section]
        guard let style = HomeShowStyle.init(rawValue: findFoodModel.goodsType) else { return }
        let goodsOfVc = XSGoodsInfoGroupBuyTicketViewController(style:style , merchantId: findFoodModel.merchantId, goodId: findFoodModel.goodsId)
        self.navigationController?.pushViewController(goodsOfVc, animated: true)
        
    }
}


extension XSHomeFindFoodViewController: GKPageListViewDelegate {
    func listScrollView() -> UIScrollView {
        return self.tableView
    }
    
    func listViewDidScroll(callBack: @escaping (UIScrollView) -> ()) {
        self.scrollCallBack = callBack
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollCallBack!(scrollView)
    }
    
}


