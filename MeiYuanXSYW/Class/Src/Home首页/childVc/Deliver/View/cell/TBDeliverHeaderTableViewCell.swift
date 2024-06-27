//
//  TBDeliverHeaderTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/22.
//

import UIKit

class TBDeliverHeaderTableViewCell: XSBaseTableViewCell {
    
    var secKillGoods: [SecKillGoodsVos] = [SecKillGoodsVos]() {
        didSet {
            shopProductView.reloadData()
        }
    }

    lazy var shopProductView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 9
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = 108
        let itemH:CGFloat = 140
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: TBDeliverCollectionCell.self)

        return collectionView
    }()
    
    override func configUI() {
        super.configUI()
        self.contentView.hg_setCornerOnBottomWithRadius(radius: 10)
        
        self.contentView.addSubview(shopProductView)
        shopProductView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }

}

extension TBDeliverHeaderTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return secKillGoods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TBDeliverCollectionCell.self)
        cell.secondKillGoodsModel = secKillGoods[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goodsModel = secKillGoods[indexPath.item]
        let delieveGoodsInfo = TBDelievePrivateKitGoodsInfoVc(style: .deliver, merchantId: goodsModel.merchantId, goodsId: goodsModel.goodsId)
        topVC?.navigationController?.pushViewController(delieveGoodsInfo, animated: true)
        
    }
}
