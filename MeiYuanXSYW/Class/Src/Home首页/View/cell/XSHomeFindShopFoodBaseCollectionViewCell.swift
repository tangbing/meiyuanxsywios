//
//  XSHomeFindShopFoodBaseCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/27.
//

import UIKit
import SnapKit
import Reusable


class XSHomeFindShopFoodEvaluatView: UIView {
    
    // 线
    var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .borad
        return lineView
    }()
    
    // 线
    var lineView1 : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .borad
        return lineView
    }()
    
    // 广东菜
    var vegWhereLabel: UILabel = {
        let vegWhere = UILabel()
        vegWhere.text = "广东菜"
        vegWhere.textColor = .tag
        vegWhere.font = MYFont(size: 11)
        return vegWhere
    }()
    
    // 鸡煲
    var vegNameLabel : UILabel = {
        let lb = UILabel()
        lb.text = "鸡煲"
        lb.textColor = .tag
        lb.font = MYFont(size: 11)
        return lb
    }()
    
    // 晚餐
    var dinnerLabel : UILabel = {
        let ib = UILabel()
        ib.text = "晚餐"
        ib.textColor = .tag
        ib.font = MYFont(size: 11)
        return ib
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(vegWhereLabel)
        vegWhereLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(vegWhereLabel.snp_right).offset(6)
            make.width.equalTo(1)
        }
        
        self.addSubview(vegNameLabel)
        vegNameLabel.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp_right).offset(6)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(lineView1)
        lineView1.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(vegNameLabel.snp_right).offset(6)
            make.width.equalTo(1)
        }
        
        self.addSubview(dinnerLabel)
        dinnerLabel.snp.makeConstraints { make in
            make.left.equalTo(lineView1.snp_right).offset(6)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSHomeFindShopFoodBaseCollectionViewCell: UICollectionViewCell, Reusable {
    
    
    func configureUI(shopFoodModel: XSHomeFindShopFoodData) {
        var name = shopFoodModel.goodsName
        var picAddress = shopFoodModel.goodsPic
        
        if shopFoodModel.bizType == 0 || shopFoodModel.bizType == 1 {
            name = shopFoodModel.merchantName
            //picAddress = shopFoodModel.merchantLogo
        }
        nameLab.text = name
        
        tipImg.xs_setImage(urlString: picAddress)
        tipImg.xs_setImage(urlString: shopFoodModel.merchantLogo)
        
        
        nameIcon.icon.isHidden = !(shopFoodModel.takeout == 1)
        nameIcon.icon2.isHidden = !(shopFoodModel.group == 1)
        nameIcon.icon3.isHidden = !(shopFoodModel.privateChef == 1)

        homeEvaluatView.layoutWithtags(tags: shopFoodModel.tagName, praise: nil)

        
    }
   
    
    var backView : UIView={
        let backView = UIView()
        backView.hg_setAllCornerWithCornerRadius(radius: 6)
        backView.backgroundColor = .white
        return backView
    }()
    
    //图片
    lazy var tipImg : UIImageView = {
        let tipImg = UIImageView()
        tipImg.image = UIImage(named: "normal_placeholder")
        tipImg.hg_setAllCornerWithCornerRadius(radius: 6)
        return tipImg
    }()
    
    lazy var merchantLogo: UIImageView = {
        let tipImg = UIImageView()
        tipImg.image = UIImage(named: "normal_placeholder")
        return tipImg
    }()
    
    //商家名称加标签
    lazy var nameLab : UILabel={
        let nameLab = UILabel()
        nameLab.font = MYBlodFont(size: 14)
        nameLab.textColor = .text
        nameLab.numberOfLines = 0
        return nameLab
    }()
    
    lazy var nameIcon : VipNameIcon={
        let nameIcon = VipNameIcon()
        return nameIcon
    }()
    
    /// 广东菜 鸡煲 晚餐
    lazy var homeEvaluatView: XSCollectHightEvaluatView = {
        let homeEvaluatView = XSCollectHightEvaluatView()
        return homeEvaluatView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     func configUI() {
        
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backView.addSubview(tipImg)
        tipImg.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(homeW)
            make.height.equalTo(self.snp_width).multipliedBy(0.75)
        }
        
        backView.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.left.equalTo(backView.snp_left).offset(kFindMargin)
            make.right.equalTo(backView.snp_right).offset(-kFindMargin)
            make.top.equalTo(tipImg.snp_bottom).offset(kFindMargin)
        }
         
         //商家标签
         backView.addSubview(nameIcon)
         nameIcon.snp.makeConstraints { make in
             make.left.top.equalToSuperview().offset(0)
         }
         
         tipImg.addSubview(merchantLogo)
         merchantLogo.snp.makeConstraints { make in
             make.size.equalTo(CGSize(width: 30, height: 30))
             make.right.equalToSuperview().offset(-5)
             make.bottom.equalToSuperview().offset(-5)
         }
         
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
}
