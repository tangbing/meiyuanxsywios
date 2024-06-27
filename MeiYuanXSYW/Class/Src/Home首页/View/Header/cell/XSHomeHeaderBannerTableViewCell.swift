//
//  XSHomeHeaderBannerTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/24.
//

import UIKit
import FSPagerView
import QMUIKit


class XSHomeHeaderBannerTableViewCell: XSBaseXIBTableViewCell {
    
    var backGoodId: ((String) ->())?
    var hotBtnClickHandler: ((String) ->())?

    var slidesList: [AdvertiseDetail]?{
        didSet{
            guard slidesList != nil else {return}
            self.pagerControl.numberOfPages = self.slidesList!.count
            self.pagerView.reloadData()
        }
    }
    
    var signs: [String]! {
        didSet {
            setupScrollView()
        }
    }
    var lastHotBtn: QMUIButton?
    
    @IBOutlet weak var recommandView: UIView!
    @IBOutlet weak var bannerView: UIView!
    
    @IBOutlet weak var hotTItleLabel: UILabel!
    
    // 懒加载滚动图片浏览器
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.itemSize = CGSize.init(width: screenWidth - 60, height: 140)
        pagerView.transformer = FSPagerViewTransformer(type: .overlap)
        pagerView.isInfinite = !pagerView.isInfinite
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "ShopBannerCell")
        return pagerView
    }()
    
    // 懒加载滚动图片浏下标
        lazy var pagerControl:FSPageControl = {
            let pageControl = FSPageControl()
            //设置下标的个数
    //        pageControl.numberOfPages = 5
            //设置下标位置
            pageControl.contentHorizontalAlignment = .center
            //设置下标指示器边框颜色（选中状态和普通状态）
            pageControl.setStrokeColor(.lightGray, for: .normal)
            pageControl.setStrokeColor(.darkGray, for: .selected)
            //设置下标指示器颜色（选中状态和普通状态）
            pageControl.setFillColor(.lightGray, for: .normal)
            pageControl.setFillColor(.darkGray, for: .selected)
            
            //设置下标指示器图片（选中状态和普通状态）
            //pageControl.setImage(UIImage.init(named: "1"), for: .normal)
            //pageControl.setImage(UIImage.init(named: "2"), for: .selected)
            
            //绘制下标指示器的形状 (roundedRect绘制绘制圆角或者圆形)
    //        pageControl.setPath(UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 8, width: 8, height: 5),cornerRadius: 4.0), for: .normal)
            
            pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 6, height: 6)), for: .normal)
            pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 6, height: 6)), for: .selected)
            return pageControl

        }()
    
    lazy var scroll: UIScrollView = {
        let iv = UIScrollView()
        iv.showsVerticalScrollIndicator = false
        iv.showsHorizontalScrollIndicator = false
        iv.bounces = false
        return iv
    }()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.bannerView.addSubview(banner)
        self.bannerView.addSubview(self.pagerView)
        self.bannerView.addSubview(self.pagerControl)
        self.pagerView.snp.makeConstraints { (make) in
                 make.left.top.right.equalToSuperview()
                 make.height.equalToSuperview()
         }
        
        self.pagerControl.snp.makeConstraints { (make) in
             make.width.equalTo(80)
             make.height.equalTo(30)
             make.bottom.equalTo(pagerView.snp.bottom).offset(0)
             make.centerX.equalTo(self.pagerView)
         }
        
    }
    
    private func setupScrollView(){
        self.recommandView.addSubview(scroll)
        scroll.snp.makeConstraints { make in
            make.left.equalTo(hotTItleLabel.snp_right).offset(0)
            make.top.bottom.right.equalToSuperview()
        }
        
        let containerView = UIView()
        scroll.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        for i in 0..<signs.count {
            let hotBtn = QMUIButton(type: .custom)
            hotBtn.setTitle(signs[i], for: .normal)
            hotBtn.backgroundColor = UIColor.hex(hexString: "#ECECEC")
            hotBtn.setTitleColor(UIColor.text, for: .normal)
            hotBtn.titleLabel?.font = MYFont(size: 10)
            containerView.addSubview(hotBtn)
            hotBtn.sizeToFit()
            hotBtn.contentEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
            hotBtn.hg_setAllCornerWithCornerRadius(radius: 8)
            hotBtn.addTarget(self, action: #selector(hotBtnClick), for: .touchUpInside)
            hotBtn.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(lastHotBtn != nil ? lastHotBtn!.snp_right : containerView.snp_left).offset(4)
            }
            lastHotBtn = hotBtn
        }
        
        if lastHotBtn != nil {
            containerView.snp.makeConstraints { make in
                make.right.equalTo(lastHotBtn!.snp_right).offset(10)
            }
        }

    }
    
    @objc func hotBtnClick(button: QMUIButton) {
        hotBtnClickHandler?(button.currentTitle ?? "")
    }
    
}

extension XSHomeHeaderBannerTableViewCell: FSPagerViewDelegate, FSPagerViewDataSource {
    // - FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.slidesList?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "ShopBannerCell", at: index)
        cell.imageView?.xs_setImage(urlString: self.slidesList?[index].advertisePic, placeholder: UIImage.bannerPlaceholder) 
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        self.pagerControl.currentPage = index
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        backGoodId?((self.slidesList?[index].advertiseLink)!)
        
    }
}
