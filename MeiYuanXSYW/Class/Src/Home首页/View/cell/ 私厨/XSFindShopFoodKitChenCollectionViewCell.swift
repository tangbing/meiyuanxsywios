//
//  XSFindShopFoodKitChenCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/27.
//

import UIKit
import QMUIKit
import JKSwiftExtension

//评分、销量、均价行布局
class XSHomeFindShopFoodStarScore : UIView {
    
    lazy var lineView : UIView = {
       let lineView = UIView()
        lineView.backgroundColor = .twoText
        return lineView
    }()
    
    lazy var lineView1 : UIView = {
       let lineView = UIView()
        lineView.backgroundColor = .twoText
        return lineView
    }()
    
    ///评分
    lazy var scoreIcon : UIImageView = {
        let scoreIcon = UIImageView()
        scoreIcon.image = UIImage(named: "vip_score")
        return scoreIcon
    }()
    //评分
    lazy var scoreLab : UILabel={
        let scoreLab = UILabel()
        scoreLab.font = MYFont(size: 12)
        scoreLab.textColor = .warn
        scoreLab.text = "4.9分"
        return scoreLab
    }()

    // 距离
    var distanceLab : UILabel={
        let saleLab = UILabel()
        saleLab.font = MYFont(size: 12)
        saleLab.textColor = .twoText
        saleLab.text = "5.2Km"
        return saleLab
    }()
    //均价
    var priceLab : UILabel={
        let priceLab = UILabel()
        priceLab.font = MYFont(size: 11)
        priceLab.textColor = .twoText
        priceLab.text = "人均¥25"
        return priceLab
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.left.equalTo(homeW * 0.33)
            make.top.equalTo(self.snp_top).offset(4)
            make.bottom.equalTo(self.snp_bottom).offset(-4)
            make.width.equalTo(1)
        }
        
        self.addSubview(lineView1)
        lineView1.snp.makeConstraints { make in
            make.left.equalTo(homeW * 0.66)
            make.top.equalTo(self.snp_top).offset(4)
            make.bottom.equalTo(self.snp_bottom).offset(-4)
            make.width.equalTo(1)
        }
        
        
        self.addSubview(scoreIcon)
        scoreIcon.snp.makeConstraints { make in
            make.left.equalTo(4)
            make.width.height.equalTo(12)
            make.centerY.equalToSuperview()
        }

        self.addSubview(scoreLab)
        scoreLab.snp.makeConstraints { make in
            make.bottom.top.equalTo(0)
            make.left.equalTo(scoreIcon.snp_right).offset(2)
        }
        
        self.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.bottom.top.equalTo(0)
            make.left.equalTo(lineView1.snp_right).offset(10)
        }
        
        self.addSubview(distanceLab)
        distanceLab.snp.makeConstraints { make in
            make.bottom.top.equalTo(0)
            make.left.equalTo(lineView.snp_right).offset(8)
        }

       

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSFindShopFoodKitChenCollectionViewCell: XSHomeFindShopFoodBaseCollectionViewCell {
    
    override func configureUI(shopFoodModel: XSHomeFindShopFoodData) {
        super.configureUI(shopFoodModel: shopFoodModel)

        // // 0 商家，1菜、品
        if shopFoodModel.bizType == 0 {
            starView.removeFromSuperview()
            
            rankBtn.snp.updateConstraints { make in
                make.height.equalTo(15)
            }
            
            backView.addSubview(priceView)
            priceView.snp.makeConstraints { make in
                make.top.equalTo(homeEvaluatView.snp_bottom).offset(kFindMargin)
                make.right.equalToSuperview().offset(-kFindMargin)
                make.left.equalToSuperview().offset(kFindMargin)
                make.height.equalTo(kFindViewH)
                //make.bottom.equalToSuperview().offset(-10)
            }
            
            priceView.finalPriceLabel.text = "¥\(shopFoodModel.originalPrice)"
            priceView.previousPriceLabel.text = "¥\(shopFoodModel.finalPrice)"
            priceView.reduceDownPriceLabel.text = "\(shopFoodModel.discountRate)折"
            
            
            
        } else {
            priceView.removeFromSuperview()
            
            rankBtn.snp.updateConstraints { make in
                make.height.equalTo(0)
            }

            backView.addSubview(starView)
            starView.snp.makeConstraints { make in
                make.top.equalTo(homeEvaluatView.snp_bottom).offset(kFindMargin)
                make.left.right.equalToSuperview()
                make.height.equalTo(kFindViewH)
                make.bottom.equalToSuperview().offset(-10)
            }
            
            starView.scoreLab.text = "\(shopFoodModel.score)分"
            starView.distanceLab.text = "月销\(shopFoodModel.monthlySales)"
            starView.priceLab.text = "人均¥\(shopFoodModel.perCapita)"
            
            
        }
    }
    
   
    
    //榜单
    lazy var rankBtn : QMUIButton = {
        let rankBtn = QMUIButton()
        rankBtn.titleLabel?.font = MYFont(size: 10)
        rankBtn.setTitle("罗湖区热评榜第1名", for: UIControl.State.normal)
        rankBtn.setTitleColor(.warn, for: UIControl.State.normal)
        rankBtn.setImage(UIImage(named: "vip_Reviews_HotList"), for: UIControl.State.normal)
        rankBtn.backgroundColor = UIColor.hex(hexString: "FFFCF1")
        rankBtn.imagePosition = QMUIButtonImagePosition.left
        rankBtn.jk.addBorder(borderWidth: 0.5, borderColor: .warn)
        rankBtn.contentEdgeInsets = UIEdgeInsets.init(top: 1, left: 2, bottom: 1, right: 4)
        rankBtn.hg_setAllCornerWithCornerRadius(radius: 5)
        return rankBtn
    }()
    
    lazy var priceView: XSCollectPriceView = {
        let priceView = XSCollectPriceView()
        return priceView
    }()
    
    lazy var starView: XSHomeFindShopFoodStarScore = {
        let starView = XSHomeFindShopFoodStarScore()
        return starView
    }()
    
    override func configUI() {
        super.configUI()
        
        backView.addSubview(rankBtn)
        rankBtn.snp.makeConstraints { make in
            make.top.equalTo(nameLab.snp_bottom).offset(0)
            make.left.equalTo(nameLab)
            //make.width.equalTo(120)
            make.height.equalTo(15)
        }
        
        backView.addSubview(homeEvaluatView)
        homeEvaluatView.snp.makeConstraints { make in
            make.left.equalTo(nameLab)
            make.height.equalTo(18)
            make.top.equalTo(rankBtn.snp_bottom).offset(4)
        }
        
    }
    
}


