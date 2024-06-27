//
//  TBGoodsInfoHeaderViewPicCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/15.
//

import UIKit

class TBGoodsInfoHeaderViewPicCell: XSBaseTableViewCell {

    private final let MaxNumPage: Int = 5
    fileprivate var currtPage: Int = 0
    /// 计时器
    fileprivate var dtimer: DispatchSourceTimer?
    private let autoScrollTimeInterval: Double = 3.0
    
    var picAddress: [String]? {
        didSet {
            guard let pics = picAddress else { return }
            numSignLabel.text = "1/\(pics.count)"
            picCollectionView.reloadData()
        }
    }
    
    lazy var numSignLabel: UILabel = {
        let signLabel = UILabel()
        signLabel.backgroundColor = UIColor.hex(hexString: "#000000")
        signLabel.alpha = 0.6
        signLabel.textColor = .white
        signLabel.font = MYBlodFont(size: 13)
        signLabel.textAlignment = .center
        signLabel.text = "1/\(MaxNumPage)"
        signLabel.hg_setAllCornerWithCornerRadius(radius: 9)
        return signLabel
    }()
    
    private lazy var picCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth: CGFloat = screenWidth
        let itwmHeight: CGFloat = screenWidth * 3 / 4
        layout.itemSize = CGSize(width: itemWidth, height: itwmHeight)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(cellType: TBGoodsInfoHeaderViewCollectionViewCell.self)
        
        return collectionView
    }()
    
    override func configUI() {
        self.contentView.addSubview(picCollectionView)
        picCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.contentView.addSubview(numSignLabel)
        numSignLabel.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 50, height: 18))
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-7)
        }
        
        //setupTimer()
    }
    
    deinit {
        self.invalidateTimer()
        print("TBShopInfoHeaderViewPicCell deinit!!!!")
    }

}

// MARK: - 倒计时相关方法
extension TBGoodsInfoHeaderViewPicCell {
    
    /// 添加DTimer
    func setupTimer() {
//        // 仅一张图不进行滚动操纵
//        if self.imagePaths.count <= 1 { return }
        
        invalidateTimer()
        
        let l_dtimer = DispatchSource.makeTimerSource()
        l_dtimer.schedule(deadline: .now()+autoScrollTimeInterval, repeating: autoScrollTimeInterval)
        l_dtimer.setEventHandler { [weak self] in
            DispatchQueue.main.async {
                self?.automaticScroll()
            }
        }
        // 继续
        l_dtimer.resume()
        
        dtimer = l_dtimer
    }
    
    /// 关闭倒计时
    func invalidateTimer() {
        dtimer?.cancel()
        dtimer = nil
    }
    
    func automaticScroll(){
        currtPage = currtPage + 1
        print(currtPage)
        if currtPage >= MaxNumPage {
            currtPage = 0
        }
        
        picCollectionView.scrollToItem(at: IndexPath.init(item: currtPage , section: 0), at: .left, animated: true)
    }
}

extension TBGoodsInfoHeaderViewPicCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.picAddress?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoHeaderViewCollectionViewCell.self)
        cell.bgShopImageView.xs_setImage(urlString: self.picAddress?[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //setupTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currtPage = Int(scrollView.contentOffset.x / scrollView.tb_width)
        numSignLabel.text = "\(currtPage + 1)/\(MaxNumPage)"
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        currtPage = Int(scrollView.contentOffset.x / scrollView.tb_width)
        numSignLabel.text = "\(currtPage + 1)/\(MaxNumPage)"
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invalidateTimer()
    }
    
    
}
