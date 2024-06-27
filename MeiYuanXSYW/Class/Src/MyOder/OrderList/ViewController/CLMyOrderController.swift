
//  CLMyOrderController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/23.


import UIKit
import JXSegmentedView
import GKPageScrollView

class CLMyOrderController: XSBaseViewController {
    
    var selectIndext:Int = 0
    
    var currentVC:CLMyOrderLoadListController?
    
    lazy var menu = CLPullDownMenuView.init(frame: CGRect(x: 0, y: 40 + kStatusTopInset, width: screenWidth, height: 0))

    var flag:Bool  = false
    
    lazy var maskView = TBCover.init(frame: CGRect(x: 0, y: 40 + kStatusTopInset, width: screenWidth, height: screenHeight - 40))
        .then{
        $0.backgroundColor = .black
        $0.alpha = 0.6
    }

    let topSearchView = CLMyOrderHeadView().then{
        $0.backgroundColor = .lightBackground
    }

    let titles = ["全部","待支付","待使用","待评价","退款/售后"]
    
    var listVCArray = [CLMyOrderLoadListController]()

    lazy var segmentedDataSource: JXSegmentedBaseDataSource? = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = titles
        dataSource.titleSelectedColor = .tag
        dataSource.titleNormalColor = UIColor.hex(hexString: "#252525")
        dataSource.titleNormalFont = MYFont(size: 14)
        dataSource.titleSelectedFont = MYBlodFont(size: 14)
        return dataSource
    }()

    var listContainerView: JXSegmentedListContainerView!

    lazy var segmentView =  JXSegmentedView().then{
        $0.backgroundColor = .lightBackground
        $0.dataSource = segmentedDataSource
        $0.delegate = self
        $0.defaultSelectedIndex = selectIndext
        $0.contentEdgeInsetLeft = 0
        $0.contentEdgeInsetRight = 0
        //配置指示器
        let indicator = JXSegmentedIndicatorImageView()
        indicator.verticalOffset = 5
        indicator.image = UIImage(named: "home_segment_indicator")
        indicator.indicatorWidth = 11
        indicator.indicatorHeight = 11
        $0.indicators = [indicator]
    }

    
    func dismiss(){
        self.menu.tb_height = 0
        self.maskView.removeFromSuperview()
        self.menu.removeFromSuperview()
    }
    
    func awake(){
        self.view.addSubview(self.maskView)
        self.view.addSubview(self.menu)

        self.menu.hg_setCornerOnBottomWithRadius(radius: 10)
        maskView.clickCover = {[weak self] in
            self?.dismiss()
        }
        menu.clickBlock = {[unowned self] idx in
            uLog("发通知:\(idx)")
            if idx == 0 {
//                self.listVCArray[self.selectIndext].loadData(index:5)
                self.currentVC?.loadData(index:5)
            }else if idx == 1 {
//                self.listVCArray[self.selectIndext].loadData(index:6)
                self.currentVC?.loadData(index:6)
            }else if idx == 2 {
//                self.listVCArray[self.selectIndext].loadData(index:7)
                self.currentVC?.loadData(index:7)
            }else if idx == 3 {
//                self.listVCArray[self.selectIndext].loadData(index:8)
                self.currentVC?.loadData(index:8)
            }else if idx == 4 {
//                self.listVCArray[self.selectIndext].loadData(index:9)
                self.currentVC?.loadData(index:9)
            }
//            NotificationCenter.default.post(name: NSNotification.Name("reloadMyOrderListByBizType"), object: idx)
            self.dismiss()
        }
        self.menu.tb_height = 167
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightBackground
        self.view.addSubview(topSearchView)
        self.view.addSubview(segmentView)
        self.listContainerView = JXSegmentedListContainerView(dataSource: self)
        self.view.addSubview(listContainerView)
        segmentView.listContainer =  listContainerView
    
        topSearchView.pullAction = { [unowned self] in
            self.flag = !self.flag
            
            if self.flag == true{
                self.awake()
            }else{
                self.dismiss()
            }

        }

        topSearchView.clickAction = {[unowned self] in
            
            self.navigationController?.popViewController(animated: true)
        }

        topSearchView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(30)
            make.top.equalToSuperview().offset(kStatusTopInset)
        }
        segmentView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(54)
            make.top.equalTo(topSearchView.snp.bottom)
        }

        listContainerView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(segmentView.snp.bottom)
            make.bottom.equalTo(self.view.usnp.bottom).offset(-20)
        }

    }

    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

}


extension CLMyOrderController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int)
    {
        listContainerView.didClickSelectedItem(at: index)
        self.selectIndext = index
        print("刷新数据")
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
        listContainerView.didClickSelectedItem(at: index)
        self.selectIndext = index
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {

    }
}

extension CLMyOrderController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return segmentedDataSource!.dataSource.count
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = CLMyOrderLoadListController()
        vc.index = index
        self.listVCArray.append(vc)
        self.currentVC = vc
        return vc
    }
}
