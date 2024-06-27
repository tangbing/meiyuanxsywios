//
//  TBHomeDeliverViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/22.
//

import UIKit
import JXSegmentedView
import GKPageScrollView


class TBHomeDeliverViewController: XSBaseViewController {
    let deliverHeaderH: CGFloat = 36 + 165 + 120 + 160 + 160 + 160 + 10
    let titles = ["综合","发现好物","发现好店"]
    var childVCs: [GKPageListViewDelegate] = [GKPageListViewDelegate]()
    var scrollDidView: UIView?
    
    var showHomeStyle: HomeShowStyle = .deliver
    
    init(style homeShowStyle: HomeShowStyle) {
        self.showHomeStyle = homeShowStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headerView: TBHomeDeliverHeaderView = {
        let iv = TBHomeDeliverHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: deliverHeaderH))
        iv.backgroundColor = .background

        iv.updateDelieveHeaderHeight = { hasSecondKill in
            self.headerView.tb_height = self.deliverHeaderH - 160 - 40 - 10
            self.pageScrollView.reloadData()
        }
        iv.superViewController = self
        iv.delegate = self
        return iv
    }()
    
    lazy var customNavBar: UIView = {
        let custNav = TBHomeCustomNavBar(locationAligent: .right)
        if let locationStr = UserDefaults.standard.string(forKey: kCurrCityStr) {
            custNav.selectLocationBtn.setTitle(locationStr, for: .normal)
        }
        custNav.searchBackBtnClick = { [weak self] nav in
            self?.navigationController?.popViewController(animated: true)
        }
        custNav.searchTextFieldDidBeginEditingBlock = {[weak self] nav in
            self?.navigationController?.pushViewController(XSHomeSearchViewController(), animated: true)
        }
        custNav.searchGoSelectLocationBlock = {[weak self] nav in
            let selectLocation = TBHomeSelectLocationViewController()
            selectLocation.didSelectAddressBlock = {
                if let locationStr = UserDefaults.standard.string(forKey: kCurrCityStr) {
                    custNav.selectLocationBtn.setTitle(locationStr, for: .normal)
                }
            }
            self?.navigationController?.pushViewController(selectLocation, animated: true)
        }
        custNav.searchGoMessageBlock = { [weak self] nav in
            self?.navigationController?.pushViewController(CLMyNoticeCenterController(), animated: true)
        }
        return custNav
    }()
    
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: segemntH + spaceing, width: screenWidth, height: pageScrollView.tb_height - segemntH - spaceing))
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
    
    lazy var segmentedDataSource: JXSegmentedBaseDataSource? = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = titles
        dataSource.titleSelectedColor = .tag
        dataSource.titleNormalColor = UIColor.hex(hexString: "#737373")
        dataSource.titleNormalFont = MYFont(size: 18)
        dataSource.titleSelectedFont = MYBlodFont(size: 18)
        return dataSource
    }()
    
    lazy var segmentView: JXSegmentedView = {
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
    
    lazy var pageView: UIView  = {
        let pageView = UIView()
        pageView.backgroundColor = .background
        pageView.addSubview(contentScrollView)
        pageView.addSubview(segmentView)
        return pageView
    }()
    
    lazy var pageScrollView: GKPageScrollView = {
        let pageScrollView = GKPageScrollView(delegate: self)
        pageScrollView.isAllowListRefresh = false
        pageScrollView.ceilPointHeight = 0
        pageScrollView.mainTableView.backgroundColor = .background
        return pageScrollView
    }()
    
    lazy var scrollToBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(#imageLiteral(resourceName: "home_ scroll_top"), for: .normal)
        btn.addTarget(self, action: #selector(scrollTop), for: .touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(menuBtnShowClick), name: NSNotification.Name("MenuTitleNote_Btn_Show_Click"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(menuBtnDismissClick), name: NSNotification.Name("MenuTitleNote_Btn_Dismiss_Click"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        NotificationCenter.default.removeObserver(self)
        
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
    }

    override func initSubviews() {
        childVCs.append(XSHomeFindShopFoodViewController(style: .deliver))
        childVCs.append(XSHomeFindFoodViewController(style: .deliver))
        childVCs.append(XSHomeFindShopViewController(style: .deliver))
        
        self.view.addSubview(customNavBar)
        customNavBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.usnp.top)
            make.left.right.equalToSuperview()
        }
        
        self.view.addSubview(pageScrollView)
        pageScrollView.snp.makeConstraints { make in
            make.top.equalTo(customNavBar.snp_bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.usnp.bottom)
        }
        pageScrollView.reloadData()
        
        self.view.addSubview(scrollToBtn)
        scrollToBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.view.usnp.bottom).offset(-20)
        }
    }

    deinit {
        print("deinit!!!")
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("MenuTitleNote_Btn_Show_Click"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("MenuTitleNote_Btn_Dismiss_Click"), object: nil)
    }
   
 // MARK: - event touch
    @objc func scrollTop(){
       // self.pageScrollView.scrollToOriginalPoint()
        let outDistance = XSDelieveOutDistancePopView()
        outDistance.show()
    }
   
    @objc private func menuBtnShowClick() {
        if self.isViewLoaded && (self.view.window != nil) {
            UIView.animate(withDuration: 0.3) {
                self.pageScrollView.mainTableView.contentOffset = CGPoint(x: 0, y: self.deliverHeaderH)
                self.pageScrollView.mainTableView.isScrollEnabled = false
            }
        }
    }
    @objc private func menuBtnDismissClick() {
        if self.isViewLoaded && (self.view.window != nil) {
            self.pageScrollView.mainTableView.isScrollEnabled = true
        }
    }
    
}

// MARK: - HttpRequest
extension TBHomeDeliverViewController {
    private func loadKingkongData(kingkongId: Int) {
        MerchantInfoProvider.request(.getJumpKingkongDistrictData(bizType: 0, kingkongId: kingkongId, lat: lat, lng: lon), model: XSMerchInfoHandlerModel.self) { returnData in
            
            if let jgData = returnData {
                uLog(jgData)
            }
            
        }errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }

    }
}

// MARK: - TBHomeDeliverHeaderViewDelegate
extension TBHomeDeliverViewController: TBHomeDeliverHeaderViewDelegate {
    
    /// 点击热搜
    func clickHotSearch(_ hotSearchText: String) {
        let homeSearch = XSHomeSearchViewController()
        homeSearch.searchText = hotSearchText
        topVC?.navigationController?.pushViewController(homeSearch, animated: true)
    }
    
    /// 点击金刚区
    func clickJG(_ JGData: KingkongDetal){
        loadKingkongData(kingkongId: JGData.id)
    }
    /// 点击推荐区
    func clickCommand(_ JGData: KingkongDetal){
        
    }

}

// MARK: - GKPageScrollViewDelegate
extension TBHomeDeliverViewController: GKPageScrollViewDelegate {
    func headerView(in pageScrollView: GKPageScrollView) -> UIView {
        return headerView;
    }
    func pageView(in pageScrollView: GKPageScrollView) -> UIView {
        return pageView;
    }
    func listView(in pageScrollView: GKPageScrollView) -> [GKPageListViewDelegate] {
        return self.childVCs;
    }
}

extension TBHomeDeliverViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int)
    {
        //print("刷新数据")
//        //pullDownMenu.dismiss()
//        pullDownMenu.coverView.removeFromSuperview()
//
//        print(childVCs[index])
//        let vc = childVCs[index]
//        pullDownMenu.showInView = vc.listView?()
        //pullDownMenu.reload()
       
        
    }
}
// MARK: - UIScrollViewDelegate
extension TBHomeDeliverViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pageScrollView.horizonScrollViewDidEndedScroll()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageScrollView.horizonScrollViewDidEndedScroll()
    }

    func mainTableViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate: Bool) {
        pageScrollView.horizonScrollViewDidEndedScroll()

    }
    
    
}

