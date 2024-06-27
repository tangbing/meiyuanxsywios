//
//  XSaaa.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/15.
//

import UIKit
import JXSegmentedView

class XSmineCollectViewController: XSBaseViewController, JXSegmentedViewDelegate {
   
    public var defaultSelectIdx:Int = 0 {
        didSet {
            segmentedView.defaultSelectedIndex = defaultSelectIdx
        }
    }
    
    let titles = ["收藏商品", "收藏店铺"]
    var childrenVcs = [XSBaseViewController]()
    var segmentedDataSource: JXSegmentedTitleDataSource!
    var segmentedView: JXSegmentedView! = JXSegmentedView()
    private var contentScrollView: UIScrollView!
    let containerView = UIView()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hex(hexString: "#000000")
        view.alpha = 0.1
        return view
    }()
    
    init(selectedIdx: Int) {
        super.init(nibName: nil, bundle: nil)
        self.defaultSelectIdx = selectedIdx
        segmentedView.defaultSelectedIndex = selectedIdx
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 即将显示时，显示UINavigationBar
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    // 即将消失时，也要显示UINavigationBar
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    
    
    
//    override func setupNavigationItems() {
//        super.setupNavigationItems()
//        navigationTitle = "收藏"
//
//        childrenVcs.append(XSCollectMerchViewController())
//        childrenVcs.append(XSCollectShopViewController())
//
//    }
    
    
    override func initSubviews() {
        super.initSubviews()
        
      
        self.view.addSubview(containerView)
        containerView.addSubview(line)
        
        //1、初始化JXSegmentedView
        segmentedView.backgroundColor = .white
        
        //2、配置数据源
        //segmentedViewDataSource一定要通过属性强持有！！！！！！！！！
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedDataSource.titles = titles
        segmentedDataSource.titleNormalFont = MYFont(size: 14)
        segmentedDataSource.titleNormalColor = UIColor.twoText
        segmentedDataSource.titleSelectedColor = UIColor.text
        segmentedDataSource.titleSelectedFont = MYBlodFont(size: 14)
        segmentedView.dataSource = segmentedDataSource
        
        //配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 20
        indicator.indicatorColor = UIColor.tag
        indicator.indicatorHeight = 2
        segmentedView.indicators = [indicator]
        segmentedView.delegate = self
        containerView.addSubview(segmentedView)

        //5、初始化contentScrollView
        contentScrollView = UIScrollView()
        contentScrollView.backgroundColor = .yellow
        contentScrollView.isPagingEnabled = true
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.scrollsToTop = false
        contentScrollView.bounces = false
        //禁用automaticallyInset
        if #available(iOS 11.0, *) {
            contentScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(contentScrollView)

        //6、将contentScrollView和segmentedView.contentScrollView进行关联
        segmentedView.contentScrollView = contentScrollView
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle = "收藏"
        
        let goods = XSCollectGoodsViewController()
        goods.superVc = self
        childrenVcs.append(goods)
        
        let merchant = XSCollectMerchantViewController()
        merchant.superVc = self
        childrenVcs.append(merchant)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
        line.frame = CGRect(x: 0, y: 43, width: screenWidth, height: 1)
        segmentedView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 43)

        contentScrollView.frame = CGRect(x: 0, y: 44, width: screenWidth, height: screenHeight - 44 - kNavHeight - bottomInset)
        contentScrollView.contentSize = CGSize(width: contentScrollView.bounds.size.width*CGFloat(segmentedDataSource.dataSource.count), height: contentScrollView.bounds.size.height)
        for (index, vc) in childrenVcs.enumerated() {
            contentScrollView.addSubview(vc.view)
            vc.view.frame = CGRect(x: contentScrollView.bounds.size.width*CGFloat(index), y: 0, width: screenWidth, height: contentScrollView.bounds.size.height)
        }

    }

}

extension XSmineCollectViewController{
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
        
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        
    }
}

