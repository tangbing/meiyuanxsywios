//
//  XSFindShopFoodArrivePayCollectionViewCell.swift
//  TestWaterFlowDemo
//
//  Created by Tb on 2021/10/6.
//

import UIKit

class XSFindShopFoodArrivePayCollectionViewCell: XSHomeFindShopFoodBaseCollectionViewCell {
    
    var groupBuyModel: XSHomeFindShopFoodData = XSHomeFindShopFoodData()
    
    
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
    
    
    override func configUI() {
        super.configUI()
        
        backView.addSubview(homeEvaluatView)
        homeEvaluatView.snp.makeConstraints { make in
            make.left.equalTo(nameLab)
            make.height.equalTo(18)
            make.top.equalTo(nameLab.snp_bottom).offset(4)
        }
        
    }
    
    override func configureUI(shopFoodModel: XSHomeFindShopFoodData) {
        super.configureUI(shopFoodModel: shopFoodModel)
        
        if shopFoodModel.bizType == 0 {
            
            self.groupBuyModel = shopFoodModel
            
            priceView.removeFromSuperview()
            meituanInfoView.removeFromSuperview()
            
            backView.addSubview(starView)
            starView.snp.makeConstraints { make in
                make.top.equalTo(homeEvaluatView.snp_bottom).offset(kFindMargin)
                make.left.right.equalToSuperview()
                make.height.equalTo(kFindViewH)
            }
            
            backView.addSubview(shopProductView)
            shopProductView.snp.makeConstraints { make in
                make.top.equalTo(starView.snp_bottom).offset(kFindMargin)
                make.left.right.equalToSuperview()
                make.height.equalTo(kFindTipImageH)
                //make.bottom.equalToSuperview().offset(-10)
            }
            
            starView.scoreLab.text = "\(shopFoodModel.score)分"
            starView.distanceLab.text = "月销\(shopFoodModel.monthlySales)"
            starView.priceLab.text = "人均¥\(shopFoodModel.perCapita)"
            
            infoView.firstInfoLab.text = "起送¥\(shopFoodModel.startDelivery)"
            infoView.lastInfoLab.text = "\(shopFoodModel.deliveryTime)分钟 \(shopFoodModel.distance)km"

            shopProductView.reloadData()
            
            
            
            
        } else {
            starView.removeFromSuperview()
            shopProductView.removeFromSuperview()
            
            
            backView.addSubview(priceView)
            priceView.snp.makeConstraints { make in
                make.top.equalTo(homeEvaluatView.snp_bottom).offset(kFindMargin)
                make.right.equalToSuperview().offset(-kFindMargin)
                make.left.equalToSuperview().offset(kFindMargin)
                make.height.equalTo(kFindViewH)
            }
            
            backView.addSubview(meituanInfoView)
            meituanInfoView.snp.makeConstraints { make in
                make.top.equalTo(priceView.snp_bottom).offset(kFindMargin)
                make.left.right.equalToSuperview()
                make.height.equalTo(kFindViewH)
               // make.bottom.equalToSuperview().offset(-10)
            }
            
            
            
            priceView.finalPriceLabel.text = "¥\(shopFoodModel.originalPrice)"
            priceView.previousPriceLabel.text = "¥\(shopFoodModel.finalPrice)"
            priceView.reduceDownPriceLabel.text = "\(shopFoodModel.discountRate)折"
                
            meituanInfoView.monthSaleNumLab.text = "月销\(shopFoodModel.monthlySales)"
            meituanInfoView.hightCommentLab.text = "\(shopFoodModel.favorableRate)%好评率"
            meituanInfoView.timeInfoLab.text = "\(shopFoodModel.deliveryTime)分钟"
            
            
            
            
        }
        
    }
}


extension XSFindShopFoodArrivePayCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.groupBuyModel.details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSCollectionTicketViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XSMineCollectTicketCollectionViewCell", for: indexPath) as! XSMineCollectTicketCollectionViewCell
        cell.detailModel = self.groupBuyModel.details[indexPath.section]
        return cell
    }
    
  
    
    
}
