//
//  TBHomeDeliverHeaderCommendTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/22.
//

import UIKit

class TBHomeDeliverHeaderCommendTableViewCell: XSBaseTableViewCell {
    
    var shopRecommand: ProbeShopDetail? {
        didSet {
            
            guard let _ = shopRecommand else { return  }
            
            shopProductView.reloadData()
            
        }
    }

    var clickHeaderCommendHandler: ((_ merchantDetail: ProbeShopMerchantDetail) -> Void)?
    
    lazy var shopProductView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 9
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = 108
        let itemH:CGFloat = 120
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "XSHeaderMeiTuanCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "XSHeaderMeiTuanCollectionViewCell")

        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.hg_setCornerOnBottomWithRadius(radius: 10)

        self.contentView.addSubview(shopProductView)
        shopProductView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(120)
        }
    }
}

extension TBHomeDeliverHeaderCommendTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopRecommand?.probeShopMerchantDetails.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSCollectionTicketViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XSHeaderMeiTuanCollectionViewCell", for: indexPath) as! XSHeaderMeiTuanCollectionViewCell
        cell.merchantDetail = shopRecommand?.probeShopMerchantDetails[indexPath.item]
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let model = shopRecommand?.probeShopMerchantDetails[indexPath.item] {
            /// 点击商品图跳转至该店铺首页
            self.clickHeaderCommendHandler?(model)
        }
       
    }
    
    
}
