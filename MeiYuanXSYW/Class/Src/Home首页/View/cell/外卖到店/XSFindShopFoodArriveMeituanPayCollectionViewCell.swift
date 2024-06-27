//
//  XSFindShopFoodArriveMeituanPayCollectionViewCell.swift
//  TestWaterFlowDemo
//
//  Created by Tb on 2021/10/6.
//

import UIKit

//class XSFindShopFoodInfoView: UIView {
//
//    // 起送¥20
//    lazy var firstInfoLab : UILabel={
//        let firstInfoLab = UILabel()
//        firstInfoLab.font = MYFont(size: 12)
//        firstInfoLab.textColor = .twoText
//        firstInfoLab.text = "5.2Km"
//        return firstInfoLab
//    }()
//
//    //
//    lazy var lastInfoLab : UILabel={
//        let lastInfoLab = UILabel()
//        lastInfoLab.textAlignment = .right
//        lastInfoLab.font = MYFont(size: 11)
//        lastInfoLab.textColor = .twoText
//        lastInfoLab.text = "28分钟 5.2km"
//        return lastInfoLab
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.addSubview(firstInfoLab)
//        firstInfoLab.snp.makeConstraints { make in
//            make.left.top.equalToSuperview()
//        }
//
//        self.addSubview(lastInfoLab)
//        lastInfoLab.snp.makeConstraints { make in
//            make.right.top.equalToSuperview()
//        }
//
//    }
//
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}

class XSFindShopFoodArriveMeituanPayCollectionViewCell: XSHomeFindShopFoodBaseCollectionViewCell {
    var shopFoodModel: XSHomeFindShopFoodData = XSHomeFindShopFoodData()

    
     lazy var starView: XSHomeFindShopFoodStarScore = {
        let starView = XSHomeFindShopFoodStarScore()
        return starView
    }()
    
    lazy var infoView: XSFindShopFoodInfoView = {
        let infoView = XSFindShopFoodInfoView()
        return infoView
    }()
    
    lazy var priceView: XSCollectPriceView = {
        let priceView = XSCollectPriceView()
        return priceView
    }()
    
    lazy var shopProductView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 9
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = (homeW - 15) * 0.5
        let itemH:CGFloat = 140
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "XSMineCollectTicketCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "XSMineCollectTicketCollectionViewCell")

        return collectionView
    }()
    
    lazy var meituanInfoView: XSFindShopFoodMeituanInfoView = {
        let infoView = XSFindShopFoodMeituanInfoView()
        return infoView
    }()
    
    override func configureUI(shopFoodModel: XSHomeFindShopFoodData) {
        super.configureUI(shopFoodModel: shopFoodModel)
        // 是聚合的，只能有商家
        
        
        self.shopFoodModel = shopFoodModel
        
        
        starView.scoreLab.text = "\(shopFoodModel.score)分"
        starView.distanceLab.text = "月销\(shopFoodModel.monthlySales)"
        starView.priceLab.text = "人均¥\(shopFoodModel.perCapita)"
        
        infoView.firstInfoLab.text = "起送¥\(shopFoodModel.startDelivery)"
        infoView.lastInfoLab.text = "\(shopFoodModel.deliveryTime)分钟 \(shopFoodModel.distance)km"


        if shopFoodModel.bizType == 0 {
            
            shopProductView.snp.updateConstraints { make in
                make.top.equalTo(infoView.snp_bottom).offset(kFindMargin)
                make.left.right.equalToSuperview()
                make.height.equalTo(140)
                //make.bottom.equalToSuperview().offset(-10)
            }
            
           shopProductView.reloadData()
            
        } else {
            shopProductView.snp.updateConstraints { make in
                make.top.equalTo(infoView.snp_bottom).offset(0)
                make.left.right.equalToSuperview()
                make.height.equalTo(0)
                //make.bottom.equalToSuperview().offset(-10)
            }
        }
   }
    
    override func configUI() {
        super.configUI()
        
        backView.addSubview(homeEvaluatView)
        homeEvaluatView.snp.makeConstraints { make in
            make.left.equalTo(nameLab)
            make.height.equalTo(kFindViewH)
            make.top.equalTo(nameLab.snp_bottom).offset(kFindMargin)
        }
        
        backView.addSubview(starView)
        starView.snp.makeConstraints { make in
            make.top.equalTo(homeEvaluatView.snp_bottom).offset(kFindMargin)
            make.left.right.equalToSuperview()
            make.height.equalTo(kFindViewH)
        }
        
        backView.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.top.equalTo(starView.snp_bottom).offset(kFindMargin)
            make.left.right.equalToSuperview()
            make.height.equalTo(kFindViewH)
        }
        
        backView.addSubview(shopProductView)
        shopProductView.snp.makeConstraints { make in
            make.top.equalTo(infoView.snp_bottom).offset(kFindMargin)
            make.left.right.equalToSuperview()
            make.height.equalTo(140)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
}

extension XSFindShopFoodArriveMeituanPayCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shopFoodModel.details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSCollectionTicketViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XSMineCollectTicketCollectionViewCell", for: indexPath) as! XSMineCollectTicketCollectionViewCell
        cell.detailModel = self.shopFoodModel.details[indexPath.item]
        return cell
    }
    
    
}

