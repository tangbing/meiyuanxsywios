//
//  TBMerchInfoExpendMerchServiceCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/29.
//

import UIKit

class TBMerchInfoExpendMerchServiceCell: XSBaseTableViewCell {

    let titles = ["Wi-Fi","充电宝","宝宝座椅","无障碍通道","可停车","Wi-Fi","Wi-Fi","充电宝","宝宝座椅"]
    lazy var shopProductView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 9
        layout.minimumInteritemSpacing = 0
//        let itemW:CGFloat = 108
//        let itemH:CGFloat = 140
        //layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: TBHomeSearchHistoryCollectionViewCell.self)

        return collectionView
    }()
    
    override func configUI() {
        self.contentView.addSubview(shopProductView)
        shopProductView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        shopProductView.reloadData()
        
        //更新collectionView的高度约束
         let contentSize = self.shopProductView.collectionViewLayout.collectionViewContentSize
        print("contentSize:\(contentSize)")
        shopProductView.snp.updateConstraints { make in
            make.edges.equalToSuperview()
        }
        
         self.shopProductView.collectionViewLayout.invalidateLayout()

     //原文出自：www.hangge.com  转载请保留原文链接：https://www.hangge.com/blog/cache/detail_1591.html
    }
}

extension TBMerchInfoExpendMerchServiceCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TBHomeSearchHistoryCollectionViewCell.self)
        cell.hg_setAllCornerWithCornerRadius(radius: 10)
        cell.titleLabel.text = titles[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = titles[indexPath.item]
        let widht = title.jk.singleLineWidth(font: MYFont(size: 10))
        return CGSize(width: widht + 24, height: 20)
    }
    
}
