//
//  XSDiscoverResultShortTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/3.
//  带图片，是短图文

import UIKit

class XSDiscoverResultShortTableViewCell: XSDiscoverResultBaseTableViewCell {

    lazy var pictureCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let itemHeight = FMScreenScaleFrom(60)
        let itemWidth: CGFloat = itemHeight * 1.3
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(cellType: XSShopCartDiscountDetailCollectionViewCell.self)

        return collectionView
    }()
    
    lazy var bottomMerchInfoView: XSDiscoverRecommandMerchInfoView = {
        let merchInfo = XSDiscoverRecommandMerchInfoView()
        return merchInfo
    }()
    
    lazy var rightNumLabel: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.text = "共\n7\n件"
        lab.backgroundColor = UIColor.hexStringColor(hexString: "#FFFFFF", alpha: 0.6)
        lab.numberOfLines = 3
        lab.textColor = .twoText
        lab.font = MYFont(size: 11)
        return lab
    }()
    
    override func configUI() {
        super.configUI()
        
        self.contentView.addSubview(pictureCollectionView)
        pictureCollectionView.snp.makeConstraints { make in
            make.top.equalTo(line.snp_bottom).offset(10)
            make.left.right.equalTo(line)
            make.height.equalTo(60)
        }
        
        self.contentView.addSubview(bottomMerchInfoView)
        bottomMerchInfoView.snp.makeConstraints { make in
            make.top.equalTo(pictureCollectionView.snp_bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(90)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        self.contentView.addSubview(rightNumLabel)
        rightNumLabel.snp.makeConstraints { make in
            make.top.bottom.right.equalTo(pictureCollectionView)
            make.width.equalTo(18)
        }

    }

}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension XSDiscoverResultShortTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(for: indexPath, cellType: XSShopCartDiscountDetailCollectionViewCell.self)
//        if indexPath.item != 3 {
//            item.rightNumView.snp.updateConstraints { make in
//                make.width.equalTo(0)
//            }
//            item.rightNumView.isHidden = true
//        } else {
//            item.rightNumView.snp.updateConstraints { make in
//                make.width.equalTo(18)
//            }
//            item.rightNumView.isHidden = false
//        }
        return item
    }
    
}
