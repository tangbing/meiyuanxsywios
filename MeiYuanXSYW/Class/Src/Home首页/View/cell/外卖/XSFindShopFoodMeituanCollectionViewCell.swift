//
//  XSFindShopFoodMeituanCollectionViewCell.swift
//  TestWaterFlowDemo
//
//  Created by Tb on 2021/10/6.
//

import UIKit
import QMUIKit


class XSFindShopFoodInfoView: UIView {
    
    // 起送¥20
    lazy var firstInfoLab : UILabel={
        let firstInfoLab = UILabel()
        firstInfoLab.font = MYFont(size: 12)
        firstInfoLab.textColor = .twoText
        firstInfoLab.text = "起送¥20"
        return firstInfoLab
    }()
    
    //
    lazy var lastInfoLab : UILabel={
        let lastInfoLab = UILabel()
        lastInfoLab.textAlignment = .right
        lastInfoLab.font = MYFont(size: 11)
        lastInfoLab.textColor = .twoText
        lastInfoLab.text = "28分钟 5.2km"
        return lastInfoLab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(firstInfoLab)
        firstInfoLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview()
        }
        
        self.addSubview(lastInfoLab)
        lastInfoLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-5)
            make.top.equalToSuperview()

        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class XSFindShopFoodMeituanInfoView: UIStackView {
    
    lazy var monthSaleNumLab : UILabel={
        let monthSaleNumLab = UILabel()
        monthSaleNumLab.font = MYFont(size: 12)
        monthSaleNumLab.textColor = .twoText
        monthSaleNumLab.text = "月销1314"
        return monthSaleNumLab
    }()
    
    lazy var hightCommentLab: QMUILabel = {
        let iv = QMUILabel()
        iv.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        iv.text = "97%好评率"
        iv.font = MYFont(size: 10)
        iv.textColor = .white
        iv.backgroundColor = .tag
        iv.hg_setAllCornerWithCornerRadius(radius: 2)
        return iv
    }()
    
    lazy var timeInfoLab : UILabel={
        let firstInfoLab = UILabel()
        firstInfoLab.font = MYFont(size: 12)
        firstInfoLab.textColor = .twoText
        firstInfoLab.text = "35分钟"
        return firstInfoLab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
        alignment = .fill
        distribution = .fillEqually
        spacing = 8
        addArrangedSubview(monthSaleNumLab)
        addArrangedSubview(hightCommentLab)
        addArrangedSubview(timeInfoLab)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let kFindTipImageH: CGFloat = homeW * 3 / 4
let kshopProductViewH: CGFloat = 140
let kFindViewH: CGFloat     = 20
let kFindMargin: CGFloat    = 5


class XSFindShopFoodMeituanCollectionViewCell: XSHomeFindShopFoodBaseCollectionViewCell {
   
    
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
        let itemW:CGFloat = homeW
        let itemH:CGFloat = homeW * 3 / 4
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
        
        
        self.shopFoodModel = shopFoodModel
        
        if shopFoodModel.bizType == 0 {
            
            priceView.removeFromSuperview()
            meituanInfoView.removeFromSuperview()
            
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
                make.height.equalTo(kshopProductViewH)
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
            infoView.removeFromSuperview()
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
                //make.bottom.equalToSuperview().offset(-10)
            }
            
            
        
        priceView.finalPriceLabel.text = "¥\(shopFoodModel.originalPrice)"
        priceView.previousPriceLabel.text = "¥\(shopFoodModel.finalPrice)"
        priceView.reduceDownPriceLabel.text = "\(shopFoodModel.discountRate)折"
            
        meituanInfoView.monthSaleNumLab.text = "月销\(shopFoodModel.monthlySales)"
        meituanInfoView.hightCommentLab.text = "\(shopFoodModel.favorableRate)%好评率"
        meituanInfoView.timeInfoLab.text = "\(shopFoodModel.deliveryTime)分钟"

            
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
 
    }
}

extension XSFindShopFoodMeituanCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
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

