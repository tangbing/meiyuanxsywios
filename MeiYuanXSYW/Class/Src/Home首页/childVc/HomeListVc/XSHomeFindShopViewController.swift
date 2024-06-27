//
//  XSHomeFindShopViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/26.
//

import UIKit
import GKPageScrollView


class XSHomeFindShopViewController: XSBaseViewController {

    var showStyle: HomeShowStyle = .multiple
    private var pageIndex: Int = 0

    var findShopDatasModel: [Datum] = [Datum]()
    
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
    
    var scrollCallBack: ((UIScrollView) -> ())?
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
    
    lazy var shopTableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(cellType: XSCollectShopTableCell.self)
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

        
        self.view.addSubview(shopTableView)
        shopTableView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.top.equalTo(menuContainerView.snp_bottom).offset(0)
            $0.bottom.equalTo(self.view)
        }
      
    }


}

// MARK: - HttpRequest
extension XSHomeFindShopViewController {
    
   private func setupRefresh() {
        
//        self.tableView.mj_header = URefreshAutoHeader(refreshingTarget: self, refreshingAction: #selector(headerRereshing))
       
        self.shopTableView.uFoot = URefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(footerRereshing))
        
        self.shopTableView.mj_footer?.beginRefreshing()
        
        
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
        
        MerchantInfoProvider.request(.getNearByStoreAndGoods(_businessType: "\(self.showStyle.rawValue)", lat1: lat, lng1: lon, page: pageIndex, pageSize: pageSize), model: TBCommendShopDataModel.self) { returnData in
            
            //guard let self = self else { return }
            
            guard let findShop = returnData else {
                return
            }
            
            let findShopGoods = findShop.data
            let count = findShop.count
            
            if isRefresh {
                self.findShopDatasModel = findShopGoods

                self.shopTableView.mj_footer?.isHidden = !(self.findShopDatasModel.count > 0)
                if self.shopTableView.mj_footer?.state == .noMoreData {
                    self.shopTableView.mj_footer?.state = .idle
                }
            } else {
                self.findShopDatasModel.appends(findShopGoods)
                self.pageIndex += 1
            }
            
            if self.findShopDatasModel.count > 0 && count <= self.findShopDatasModel.count {
                self.shopTableView.mj_footer?.state = .noMoreData
            }
            self.endLoad(isRefresh: isRefresh)
            
        } errorResult: { errorMsg in
            XSTipsHUD.showError("加载失败，请重试")
            self.endLoad(isRefresh: isRefresh)
        }

    }
    
    func endLoad(isRefresh: Bool) {
        self.shopTableView.reloadData()
        if isRefresh {
            self.shopTableView.mj_header?.endRefreshing()
        } else if(!(self.shopTableView.mj_footer?.isHidden ?? true)) {
            if(self.shopTableView.mj_footer?.state != .noMoreData) {
                self.shopTableView.mj_footer?.endRefreshing()
            }
        }
    }
    
}


extension XSHomeFindShopViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.findShopDatasModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSCollectShopTableCell.self)
        cell.dataModel = self.findShopDatasModel[indexPath.section]
//        cell.addCartClickHandler = { idx in
//            print("click \(idx) cell")
//        }
//        cell.index = indexPath.section
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let findShopModel = self.findShopDatasModel[indexPath.section]
        let multMerchantInfo = TBDeliverMerchanInfoViewController(style: .multiple, merchantId: findShopModel.merchantId)
        self.navigationController?.pushViewController(multMerchantInfo, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 272
    }
    
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
}

extension XSHomeFindShopViewController: TBPullDownMenuDataSource, XSHomeSelectMenuClickDelegate {
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

extension XSHomeFindShopViewController: GKPageListViewDelegate {
    func listScrollView() -> UIScrollView {
        return self.shopTableView
    }
    
    func listViewDidScroll(callBack: @escaping (UIScrollView) -> ()) {
        self.scrollCallBack = callBack
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollCallBack!(scrollView)
    }
}

