//
//  TBTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/27.
//

import UIKit


class TBDeliverHeaderCoverFlowModel: NSObject {
    var imageName: String = ""
    var isVisable: Bool   = false
    var nameStr  : String = ""
    
    init(imageName: String, isVisable: Bool, nameStr: String) {
        self.imageName = imageName
        self.nameStr   = nameStr
        self.isVisable = isVisable
    }
    
}

class TBDeliverHeaderCoverFlowTableViewCell: XSBaseTableViewCell {
    
    var explosiveRecommendModels: [TBHomeDeliverHeaderViewExplosiveRecommendModel] = [TBHomeDeliverHeaderViewExplosiveRecommendModel]() {
        didSet {
            self.shopProductView.reloadData()
        }
    }
    
//    let models: [TBDeliverHeaderCoverFlowModel] = [
//        TBDeliverHeaderCoverFlowModel(imageName: "", isVisable: false, nameStr: "秒杀专场"),
//        TBDeliverHeaderCoverFlowModel(imageName: "", isVisable: false, nameStr: "秒杀专场"),
//        TBDeliverHeaderCoverFlowModel(imageName: "", isVisable: false, nameStr: "秒杀专场"),
//        TBDeliverHeaderCoverFlowModel(imageName: "", isVisable: false, nameStr: "秒杀专场"),
//        TBDeliverHeaderCoverFlowModel(imageName: "", isVisable: false, nameStr: "秒杀专场")
//    ]

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

extension TBDeliverHeaderCoverFlowTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return explosiveRecommendModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TBDeliverCollectionCell.self)
        let goodsModel = explosiveRecommendModels[indexPath.item]
        
        
        cell.shopImageView.xs_setImage(urlString: goodsModel.topPic, placeholder: UIImage.bannerPlaceholder)
        cell.nameLabel.text = goodsModel.goodsName
        cell.priceView.finalPriceLabel.text = "¥\(goodsModel.minPrice)"
        cell.priceView.previousPriceLabel.text = "¥\(goodsModel.originalPrice)"
        cell.priceView.reduceDownPriceLabel.text = "\(goodsModel.discount)折"
        cell.priceView.previousPriceLabel.jk.setSpecificTextDeleteLine("¥\(goodsModel.originalPrice)", color: UIColor.hex(hexString: "BBBBBB"))
            /// 0:外卖;1:团购;2:私厨
            var signal = ""
            if goodsModel.groupp == 1 {
                signal = "团购"
            } else if(goodsModel.takeout == 1) {
                signal = "外卖"
            }
        cell.signLabel.text = signal
        
//        if model.isVisable {
//           // UIView.animate(withDuration: 0.25) {
//                cell.shopImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                cell.priceView.isHidden = false
//                cell.nameLabel.isHidden = false
//            //}
//
//        } else {
//           // UIView.animate(withDuration: 0.25) {
//                cell.shopImageView.transform = CGAffineTransform.identity
//                cell.priceView.isHidden = true
//                cell.nameLabel.isHidden = true
//           // }
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let goodsModel = explosiveRecommendModels[indexPath.item]
        
        if goodsModel.goodsType == 0 { // 外卖商品详情
            let delieveGoodsInfo = TBDelievePrivateKitGoodsInfoVc(style: .deliver, merchantId: goodsModel.merchantId, goodsId: goodsModel.goodsId)
            topVC?.navigationController?.pushViewController(delieveGoodsInfo, animated: true)

        } else if (goodsModel.goodsType == 1) { // 团购商品详情
            let groupBuyGoodsInfo = XSGoodsInfoGroupBuyTicketViewController(style: .groupBuy, merchantId: goodsModel.merchantId, goodId: goodsModel.goodsId)
            topVC?.navigationController?.pushViewController(groupBuyGoodsInfo, animated: true)
        }
        
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        for cell in shopProductView.visibleCells {
//            guard let indexPath = shopProductView.indexPath(for: cell) else { return }
//            let model = models[indexPath.item]
//            model.isVisable = !model.isVisable
//        }
//        shopProductView.reloadData()
//    }
}
