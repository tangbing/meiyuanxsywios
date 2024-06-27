//
//  XSHomeController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit
import JXSegmentedView
import GKPageScrollView


let custNavH: CGFloat = 76
let segemntH: CGFloat = 44
let spaceing: CGFloat = 15
let bottomBarH:  CGFloat = 65

class XSHomeController: XSBaseViewController {
    let headerH: CGFloat = 176 + 165 + 40 + 210 + 210
    let titles = ["综合","发现好物","发现好店"]
    var childVCs: [GKPageListViewDelegate] = [GKPageListViewDelegate]()
    var scrollDidView: UIView?
    
    
    lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: headerH))
        headerView.backgroundColor = .background
        
        let iv = XSHomeHeaderView()
        iv.delegate = self
        iv.frame = CGRect(x: 0, y: 0, width: screenWidth, height: headerH)
        headerView.addSubview(iv)
        return headerView
    }()
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: segemntH + spaceing, width: screenWidth, height: pageScrollView.tb_height - segemntH - spaceing - bottomBarH))
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
    
    private lazy var contScrollView: UIScrollView = {
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
        segment.contentScrollView = contScrollView
        return segment
    }()
    
    lazy var pageView: UIView  = {
        let pageView = UIView()
        pageView.backgroundColor = .background
        pageView.addSubview(contScrollView)
        pageView.addSubview(segmentView)
        return pageView
    }()
   
    lazy var customNavBar: TBHomeCustomNavBar = {
        let custNav = TBHomeCustomNavBar()
        if let locationStr = UserDefaults.standard.string(forKey: kCurrCityStr) {
            custNav.selectLocationBtn.setTitle(locationStr, for: .normal)
        }
        custNav.searchTextFieldDidBeginEditingBlock = { nav in
//            if !XSAuthManager.shared.isLoginEd {
//                NotificationCenter.default.post(name: NSNotification.Name.XSNeedToLoginNotification, object: nil)
//                return
//            }
            self.navigationController?.pushViewController(XSHomeSearchViewController(), animated: true)
        }
        custNav.searchGoSelectLocationBlock = { nav in
            if !XSAuthManager.shared.isLoginEd {
                NotificationCenter.default.post(name: NSNotification.Name.XSNeedToLoginNotification, object: nil)
                return
            }
            let selectLocation = TBHomeSelectLocationViewController()
            selectLocation.didSelectAddressBlock = {
                if let locationStr = UserDefaults.standard.string(forKey: kCurrCityStr) {
                    custNav.selectLocationBtn.setTitle(locationStr, for: .normal)
                }
            }
            self.navigationController?.pushViewController(selectLocation, animated: true)
        }
        custNav.searchGoMessageBlock = { nav in
            self.navigationController?.pushViewController(XSMapViewSelectLocationViewController(), animated: true)
        }
        return custNav
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

        NotificationCenter.default.addObserver(self, selector: #selector(updateLoation), name: NSNotification.Name.XSUpdateLocationNotification, object: nil)
    }
    
    @objc func updateLoation() {
        let currCityStr = XSAuthManager.shared.currCityStr
        customNavBar.selectLocationBtn.setTitle(currCityStr, for: .normal)
    }
    
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }

    override func initSubviews() {
        childVCs.append(XSHomeFindShopFoodViewController(style: .multiple))
        childVCs.append(XSHomeFindFoodViewController(style: .multiple))
        childVCs.append(XSHomeFindShopViewController(style: .multiple))
  
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
   
/// event touch
    
    @objc func scrollTop(){
        self.pageScrollView.scrollToOriginalPoint()
    }
   
    @objc private func menuBtnShowClick() {
        if self.isViewLoaded && (self.view.window != nil) {
            UIView.animate(withDuration: 0.3) {
                self.pageScrollView.mainTableView.contentOffset = CGPoint(x: 0, y: self.headerH)
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



// MARK: - XSHomeHeaderViewDelegate
extension XSHomeController: XSHomeHeaderViewDelegate {
    func clickHeaderJGTableViewCell(_ header: XSHomeHeaderView, click itemModel: KingkongDetal) {
        if itemModel.name == "美食外卖" {
            let deliver = TBHomeDeliverViewController(style: .deliver)
            self.navigationController?.pushViewController(deliver, animated: true)
            
        } else if(itemModel.name == "美食团购") {
            let groupBuy = TBHomeGroupBuyViewController(style:.groupBuy)
            self.navigationController?.pushViewController(groupBuy, animated: true)
            
        } else if(itemModel.name == "上门私厨") {
            self.navigationController?.pushViewController(XSHomePrivateKitchenViewController(style:.privateKitchen), animated: true)
        } else {
            //self.navigationController?.pushViewController(TBGroupBuyMerchInfoViewController(), animated: true)
//            let discover = TBHomeGroupBuyShopInfoVc()
//            self.navigationController?.pushViewController(discover, animated: true)
            
            
//            let privateKitchen = XSHomePrivateKitchenViewController(style: .privateKitchen)
//            self.navigationController?.pushViewController(privateKitchen, animated: true)
            
            XSTipsHUD.showText("板块上新，敬请期待")
            
        }
    }
    
    func clickHeaderSecondLeftView(_ header: XSHomeHeaderView) {
        let second = TBHomeSecondViewController(killSecondStyle: .homeDefault)
        second.changeSecondStatus(isFinish: true)
        self.navigationController?.pushViewController(second, animated: true)
    }
    
    /// 点击行缮好卷
    func clickHeaderSecondRightView(_ header: XSHomeHeaderView) {
        
        self.navigationController?.pushViewController(TBHomeTicketViewController(), animated: true)
    }
    
   
}

// MARK: - GKPageScrollViewDelegate
extension XSHomeController: GKPageScrollViewDelegate {
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

extension XSHomeController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int)
    {
       // print("刷新数据")
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
extension XSHomeController: UIScrollViewDelegate {
    
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
