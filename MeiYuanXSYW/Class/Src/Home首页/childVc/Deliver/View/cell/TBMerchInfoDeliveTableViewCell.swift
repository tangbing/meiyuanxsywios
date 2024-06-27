//
//  TBMerchInfoDeliveTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/5.
//

import UIKit

class TBMerchInfoDeliveTableViewCell: XSBaseTableViewCell {
    
    var delieveModel: TBDeliverModel? {
        didSet {
            //guard let model = delieveModel else { return }
            
            
            evaluateView.reloadData()
            
        }
    }

    lazy var evaluateView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let itemW:CGFloat = (screenWidth - 30)/2 - 0.01
        let itemH:CGFloat = itemW * 3 / 4 + 83
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: TBMerchInfoDeliverCollectionViewCell.self)

        return collectionView
    }()
    
    override func configUI() {
        //super.configUI()
        self.contentView.backgroundColor = .background
        self.contentView.addSubview(evaluateView)
        evaluateView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
}

extension TBMerchInfoDeliveTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.delieveModel?.goodsItems.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoDeliverCollectionViewCell.self)
        cell.hg_setAllCornerWithCornerRadius(radius: krepeatMargin)
        
        if let delieve = self.delieveModel?.goodsItems {
           let goodsItem = delieve[indexPath.row]
            cell.goodsItem = goodsItem
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delieve = self.delieveModel?.goodsItems {
           let goodsItem = delieve[indexPath.row]
            uLog(goodsItem.goodsId)
        }
    }
    
}

