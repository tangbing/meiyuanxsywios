//
//  XSHomeFindShopFoodCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/27.
//

import UIKit
import QMUIKit


////评分、销量、均价行布局
//class XSHomeFindShopFoodStarScore : UIView {
//
//    lazy var lineView : UIView = {
//       let lineView = UIView()
//        lineView.backgroundColor = .twoText
//        return lineView
//    }()
//
//    lazy var lineView1 : UIView = {
//       let lineView = UIView()
//        lineView.backgroundColor = .twoText
//        return lineView
//    }()
//
//    ///评分
//    lazy var scoreIcon : UIImageView = {
//        let scoreIcon = UIImageView()
//        scoreIcon.image = UIImage(named: "vip_score")
//        return scoreIcon
//    }()
//    //评分
//    lazy var scoreLab : UILabel={
//        let scoreLab = UILabel()
//        scoreLab.font = MYFont(size: 12)
//        scoreLab.textColor = .warn
//        scoreLab.text = "4.9分"
//        return scoreLab
//    }()
//
//    // 距离
//    var distanceLab : UILabel={
//        let saleLab = UILabel()
//        saleLab.font = MYFont(size: 12)
//        saleLab.textColor = .twoText
//        saleLab.text = "5.2Km"
//        return saleLab
//    }()
//    //均价
//    var priceLab : UILabel={
//        let priceLab = UILabel()
//        priceLab.font = MYFont(size: 11)
//        priceLab.textColor = .twoText
//        priceLab.text = "人均¥25"
//        return priceLab
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        self.addSubview(lineView)
//        lineView.snp.makeConstraints { make in
//            make.left.equalTo(self.snp_width).multipliedBy(0.33)
//            make.top.bottom.equalTo(self)
//            make.width.equalTo(1)
//        }
//
//        self.addSubview(lineView1)
//        lineView1.snp.makeConstraints { make in
//            make.left.equalTo(self.snp_width).multipliedBy(0.66)
//            make.top.bottom.equalTo(self)
//            make.width.equalTo(1)
//        }
//
//
//        self.addSubview(scoreIcon)
//        scoreIcon.snp.makeConstraints { make in
//            make.left.equalTo(0)
//            make.width.height.equalTo(12)
//            make.centerY.equalToSuperview()
//        }
//
//        self.addSubview(scoreLab)
//        scoreLab.snp.makeConstraints { make in
//            make.bottom.top.equalTo(0)
//            make.left.equalTo(scoreIcon.snp_right).offset(2)
//        }
//
//        self.addSubview(priceLab)
//        priceLab.snp.makeConstraints { make in
//            make.bottom.top.equalTo(0)
//            make.left.equalTo(lineView1.snp_right).offset(10)
//        }
//
//        self.addSubview(distanceLab)
//        distanceLab.snp.makeConstraints { make in
//            make.bottom.top.equalTo(0)
//            make.right.equalToSuperview().offset(-5)
//        }
//
//
//
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

class XSHomeFindShopFoodDaoEvalate: UIView {
    
    lazy var saleNumLabel: UILabel = {
        let label = UILabel()
        label.text = "月销1314"
        label.textColor = UIColor.twoText
        label.font = MYFont(size: 12)
        return label
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "1.5km"
        label.textColor = UIColor.twoText
        label.font = MYFont(size: 12)
        return label
    }()
    
    lazy var footMarkMerchEvaluate: QMUILabel = {
        let iv = QMUILabel()
        iv.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        iv.text = "97%好评率"
        iv.font = MYFont(size: 10)
        iv.textColor = .white
        iv.backgroundColor = .tag
        iv.hg_setAllCornerWithCornerRadius(radius: 2)
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.addSubview(saleNumLabel)
        saleNumLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
        
        self.addSubview(footMarkMerchEvaluate)
        footMarkMerchEvaluate.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(saleNumLabel.snp_right).offset(10)
        }
        
        self.addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(saleNumLabel.snp_right).offset(10)
            make.right.equalToSuperview()
        }
        
    }
}

class XSHomeFindShopFoodCollectionViewCell: XSBaseCollectionViewCell {
    
    
    // 商家，菜品
    // 外卖，到店，私厨
    
//    >1. 私厨：商家，菜品
//    >2. 外卖: 商家，菜品
//    >3. 到店: 商家，菜品
//    >4. 外卖 + 到店: == 外卖
    
    
    lazy var backView : UIView={
        let backView = UIView()
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
    
    //商家名称加标签
    lazy var nameLab : UILabel={
        let nameLab = UILabel()
        nameLab.font = MYBlodFont(size: 16)
        nameLab.textColor = .text
        nameLab.numberOfLines = 2
        nameLab.text = "行膳有味行膳食界康美甄营养套餐商家名称的"
        return nameLab
    }()
    
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
    
    /// 广东菜 鸡煲 晚餐
    lazy var evaluatView: XSCollectHightEvaluatView = {
        let evaluatView = XSCollectHightEvaluatView()
        return evaluatView
    }()
    
//    lazy var starScore: XSHomeFindShopFoodStarScore = {
//        let starScore = XSHomeFindShopFoodStarScore()
//        return starScore
//    }()
    
    /// 价格一栏
    lazy var priveView: XSCollectPriceView = {
        let priveView = XSCollectPriceView()
        return priveView
    }()
    
    override func configUI() {
        setupSubviews()
    }
    
    private func setupSubviews() {
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backView.addSubview(tipImg)
        tipImg.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.width.equalTo(172)
            make.height.equalTo(self.snp_width).multipliedBy(0.75)
        }
        
        backView.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(tipImg.snp_bottom).offset(7)
        }
        
        backView.addSubview(nameLab)
        nameLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.top.equalTo(tipImg.snp_bottom).offset(7)
        }
        
//        // 广东菜
//        backView.addSubview(evaluatView)
//        evaluatView.snp.makeConstraints { make in
//            make.left.equalTo(nameLab.snp.left)
//            make.top.equalTo(nameLab.snp_bottom).offset(4)
//        }
        
        
        
        
        
        
    }
}
