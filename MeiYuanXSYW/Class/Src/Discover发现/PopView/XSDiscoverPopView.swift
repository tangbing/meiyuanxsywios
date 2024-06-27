//
//  XSDiscoverPopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/7.
//

import UIKit
import QMUIKit


class XSDiscoverPopView: TBBaseView {

    let maxPicsNum = 5
    
    lazy var backButton: UIButton = {
        let back = UIButton()
        back.setImage(UIImage(named: "merchinfo_ticket_closure"), for: .normal)
        back.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        return back
    }()
    
    lazy var overlayView: UIControl = {
        let control = UIControl(frame: UIScreen.main.bounds)
        control.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.8)
        control.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        control.isHidden = true
        return control
    }()
    
    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        iv.hg_setAllCornerWithCornerRadius(radius: 17.5)
        //iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "group buy_picture4")
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "老李家的亲戚"
        label.numberOfLines = 1
        label.textColor = .white
        label.font = MYBlodFont(size: 14)
        return label
    }()
    
    lazy var contentLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .white
        lab.text = "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合，与众不同之处就在于它既有梨子酒的清香和威廉梨和小苍兰的结合与众不同之处与众......"
        lab.font = MYFont(size: 13)
        lab.numberOfLines = 3
        return lab
    }()
    
    lazy var zanNumBtn: QMUIButton = {
        let zan = QMUIButton(type: .custom)
        zan.contentHorizontalAlignment = .right
        zan.setImage(UIImage(named: "dscover_zan"), for: .normal)
        zan.setTitle("4,836", for: .normal)
        zan.spacingBetweenImageAndTitle = 2
        zan.setTitleColor(.text, for: .normal)
        zan.titleLabel?.font = MYFont(size: 12)
        //all.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
        return zan
    }()
    
    lazy var bottomMerchInfoView: XSDiscoverRecommandMerchInfoView = {
        let merchInfo = XSDiscoverRecommandMerchInfoView()
        return merchInfo
    }()
    
    lazy var shopProductView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = screenWidth - 20
        let itemH:CGFloat = FMScreenScaleFrom(430)
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(cellType: XSDiscoverPopPictureCollectionViewCell.self)

        return collectionView
    }()
    
    lazy var pageNumLabel: UILabel = {
        let page = UILabel()
        page.text = "1/5"
        page.textAlignment = .center
        page.textColor = UIColor.white
        page.font = MYFont(size: 12)
        page.hg_setAllCornerWithCornerRadius(radius: 10)
        page.backgroundColor = UIColor.hexStringColor(hexString: "#000000", alpha: 0.6)
        return page
    }()
    
    override func configUI() {
        
        self.addSubview(merchIcon)
        merchIcon.snp.makeConstraints { make in
            make.height.width.equalTo(35)
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
        }
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(merchIcon)
            make.left.equalTo(merchIcon.snp_right).offset(2)
        }
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(merchIcon)
        }
        
        self.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.top.equalTo(merchIcon.snp_bottom).offset(12)
            make.left.equalTo(merchIcon)
            make.right.equalTo(backButton)
        }
        
        self.addSubview(shopProductView)
        shopProductView.snp.makeConstraints { make in
            make.height.equalTo(FMScreenScaleFrom(430))
            make.top.equalTo(contentLab.snp_bottom).offset(12)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        addSubview(bottomMerchInfoView)
        bottomMerchInfoView.snp.makeConstraints { make in
            make.top.equalTo(shopProductView.snp_bottom).offset(10)
            make.left.right.equalTo(shopProductView)
            make.height.equalTo(75)
        }
        
        addSubview(zanNumBtn)
        zanNumBtn.snp.makeConstraints { make in
            make.right.equalTo(shopProductView.snp_right).offset(-10)
            make.bottom.equalTo(shopProductView.snp_bottom).offset(-6)
            make.height.equalTo(20)
        }
        
        addSubview(pageNumLabel)
        pageNumLabel.snp.makeConstraints { make in
            make.right.equalTo(shopProductView.snp_right).offset(-10)
            make.top.equalTo(shopProductView.snp_top).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
        
        
        
    }
    
    func getPopViewHeight() -> CGFloat {
        return screenHeight
    }
    
    // MARK: - public event
    func show(){
        let window = UIApplication.shared.keyWindow
        window?.addSubview(overlayView)
        window?.addSubview(self)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        //self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: getPopViewHeight())
        fadeIn()
    }
    
    func fadeIn() {
     
        //UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = false
            self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: self.getPopViewHeight())
        //}
    }
    
    @objc func fadeOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = true
//            self.frame = CGRect(x: 0, y: -self.getPopViewHeight(), width: screenWidth, height: self.getPopViewHeight())
        } completion: { (finish) in
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }

}

extension XSDiscoverPopView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverPopPictureCollectionViewCell.self)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let page = Int(offsetX / (screenWidth - 20))
        let int_page = Int(page) + 1
        pageNumLabel.text = "\(int_page)/\(maxPicsNum)"
    }
    
    
}
