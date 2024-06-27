//
//  TBHomeSecondTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/14.
//

import UIKit
import QMUIKit

//评分
class TBHomeSecondScoreView: UIView {
    
    ///评分
    var scoreIcon : UIImageView = {
        let scoreIcon = UIImageView()
        scoreIcon.image = UIImage(named: "vip_score")
        return scoreIcon
    }()
    
    //评分
    var scoreLab : UILabel={
        let scoreLab = UILabel()
        scoreLab.font = MYFont(size: 12)
        scoreLab.textColor = .warn
        scoreLab.text = "4.9分"
        return scoreLab
    }()
    
    lazy var hightCommentLab: QMUILabel = {
        let iv = QMUILabel()
        iv.contentEdgeInsets = UIEdgeInsets(top: 1, left: 8, bottom: 1, right: 8)
        iv.text = "97%好评率"
        iv.font = MYFont(size: 10)
        iv.textColor = .king
        iv.jk.addBorder(borderWidth: 1, borderColor:.king)
        iv.hg_setAllCornerWithCornerRadius(radius: 2)
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViewUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViewUI() {
        
        self.addSubview(scoreIcon)
        scoreIcon.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.width.height.equalTo(12)
            make.centerY.equalToSuperview()
        }

        self.addSubview(scoreLab)
        scoreLab.snp.makeConstraints { make in
            make.bottom.top.equalTo(0)
            make.left.equalTo(scoreIcon.snp_right).offset(2)
        }
        
        self.addSubview(hightCommentLab)
        hightCommentLab.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(scoreLab.snp_right).offset(10)
        }
        
    }
    
}

class TBHomeSecondRightView: UIView {
    lazy var merchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "康美甄营养餐菜品名称"
        label.textColor = .twoText
        label.font = MYBlodFont(size: 16)
        return label
    }()
    
    lazy var merchDistanceLabel: UILabel = {
        let label = UILabel()
        label.text = "1.2km"
        label.textAlignment = .right
        label.textColor = .twoText
        label.font = MYFont(size: 12)
        return label
    }()
    
    lazy var merchAddresssLabel: UILabel = {
        let label = UILabel()
        label.text = "康美甄（世界金融中心）"
        label.numberOfLines = 1
        label.textColor = .text
        label.font = MYFont(size: 13)
        return label
    }()
    
    lazy var scoreView: TBHomeSecondScoreView = {
        return TBHomeSecondScoreView()
    }()
    
    lazy var priceView: XSCollectPriceView = {
        return XSCollectPriceView()
    }()
    
    lazy var lessCountLabel: UILabel = {
        let label = UILabel()
        label.text = "限量100件"
        label.numberOfLines = 1
        label.textColor = .text
        label.font = MYFont(size: 10)
        return label
    }()
    
    lazy var buyEdNumLabel: UILabel = {
        let label = UILabel()
        label.text = "已抢35%"
        label.numberOfLines = 1
        label.textColor = .text
        label.font = MYFont(size: 10)
        return label
    }()
    
    //购买
    var nowBuyBtn : QMUIButton={
        let buyBtn = QMUIButton()
        buyBtn.setTitleColor(.white, for: UIControl.State.normal)
        buyBtn.setTitle("立即抢", for: UIControl.State.normal)
        buyBtn.titleLabel?.font = MYFont(size: 14)
        buyBtn.setImage(UIImage(named: "vip_shopping_cart"), for: UIControl.State.normal)
        buyBtn.hg_setAllCornerWithCornerRadius(radius: 12)
        buyBtn.setBackgroundImage(UIImage(named: "cartBackImg"), for: UIControl.State.normal)
        buyBtn.spacingBetweenImageAndTitle = 5
        return buyBtn
    }()
    
    lazy var progressView: UIProgressView = {
        let pg = UIProgressView(progressViewStyle: .default)
        pg.hg_setAllCornerWithCornerRadius(radius: 2)
        pg.jk.addBorder(borderWidth: 0.5, borderColor: UIColor.hex(hexString: "#F6094C"))
        //UIProgressView,默认高度为4，修改UIProgressView控件的大小
//        let transform = CGAffineTransform(scaleX: 1.0, y: 0.5)
//        pg.transform = transform
      
        /// 已加载部分颜色
        pg.progressTintColor = UIColor.hex(hexString: "#F6094C")
        /// 未加载部分的颜色
        pg.trackTintColor = .white
        pg.progress = 0.6
        return pg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        seutpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func seutpUI() {
        self.addSubview(merchNameLabel)
        merchNameLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(23)
        }
        
        self.addSubview(merchDistanceLabel)
        merchDistanceLabel.snp.makeConstraints { make in
            make.top.equalTo(merchNameLabel.snp_bottom).offset(3)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(18)
        }
        
        self.addSubview(merchAddresssLabel)
        merchAddresssLabel.snp.makeConstraints { make in
            make.top.equalTo(merchNameLabel.snp_bottom).offset(3)
            make.left.equalToSuperview()
            make.right.equalTo(merchDistanceLabel.snp_left).offset(4)
            make.height.equalTo(18)
        }
        
        self.addSubview(scoreView)
        scoreView.snp.makeConstraints { make in
            make.top.equalTo(merchAddresssLabel.snp_bottom).offset(2)
            make.left.right.equalToSuperview()
            make.height.equalTo(16)
        }
        
        self.addSubview(priceView)
        priceView.snp.makeConstraints { make in
            make.top.equalTo(scoreView.snp_bottom).offset(2)
            make.width.equalTo(120)
            make.left.equalToSuperview()
            make.height.equalTo(24)
        }
        
        self.addSubview(lessCountLabel)
        lessCountLabel.snp.makeConstraints { make in
            make.top.equalTo(priceView.snp_bottom).offset(4)
            make.left.equalToSuperview()
        }
        
        self.addSubview(buyEdNumLabel)
        buyEdNumLabel.snp.makeConstraints { make in
            make.centerY.equalTo(lessCountLabel)
            make.left.equalTo(self.snp_right).offset(-96)
        }
        
        self.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.centerY.equalTo(buyEdNumLabel)
            make.width.equalTo(45)
            make.left.equalTo(buyEdNumLabel.snp_right).offset(1)
        }
        
        self.addSubview(nowBuyBtn)
        nowBuyBtn.snp.makeConstraints { make in
            make.bottom.equalTo(buyEdNumLabel.snp_top).offset(-6)
            make.right.equalTo(merchDistanceLabel)
            make.size.equalTo(CGSize(width: 86, height: 24))
        }
        
    }
}

class TBHomeSecondTableViewCell: XSBaseTableViewCell {
    
    var goodsListModel: GoodsListVoList = GoodsListVoList() {
        didSet {
            let goodsItem = goodsListModel.goodsItemVo
            
            merchIcon.xs_setImage(urlString: goodsItem.topPic)
            rightView.merchNameLabel.text = goodsItem.goodsName
            //rightView.merchAddresssLabel.text = goodsItem.
            rightView.merchDistanceLabel.text = "\(goodsItem.distance)km"
            rightView.lessCountLabel.text = "限量\(goodsItem.goodsSales)件"
            rightView.priceView.reduceDownPriceLabel.text =  "\(goodsItem.discountRate)折"
            rightView.priceView.finalPriceLabel.text =  "¥\(goodsItem.finalPrice)"
            rightView.priceView.previousPriceLabel.text =  "¥\(goodsItem.originalPrice)"

        }
    }
    
    var secondColor: UIColor?  {
        didSet {
            guard let color = secondColor else {
                fatalError()
            }
            self.rightView.progressView.progressTintColor = color
            self.rightView.progressView.jk.addBorder(borderWidth: 0.5, borderColor: color)

            self.rightView.nowBuyBtn.setBackgroundImage(color.image(), for: UIControl.State.normal)
        }
    }
    
    lazy var backView: UIView! = {
        let view = UIView()
        view.backgroundColor = .white
        view.hg_setAllCornerWithCornerRadius(radius:10)
        return view
    }()
    
    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.hg_setAllCornerWithCornerRadius(radius: 5)
        iv.image = #imageLiteral(resourceName: "login_LOGO")
        return iv
    }()
    
    // 是否是外卖，私厨
    lazy var merchTypeIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "vip_Takeaway")
        return iv
    }()
    // 自营标志
    lazy var merchSelfIcon: UIImageView = {
        let iv = UIImageView()
        iv.isHidden = true
        iv.image = #imageLiteral(resourceName: "vip_Self_employed")
        return iv
    }()
    
    lazy var rightView: TBHomeSecondRightView = {
//        let rightIV = UIView()
//        rightIV.backgroundColor = .red
        return TBHomeSecondRightView()
    }()
    
   
    
    override func configUI() {
        
        self.backgroundColor = .clear
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.bottom.equalToSuperview()
        }
        
        backView.addSubview(merchIcon)
        merchIcon.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(120)
            $0.height.equalTo(90)
        }
        
        merchIcon.addSubview(merchTypeIcon)
        merchTypeIcon.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.size.equalTo(CGSize(width: 30, height: 15))
        }
        
        merchIcon.addSubview(merchSelfIcon)
        merchSelfIcon.snp.makeConstraints {
            $0.top.equalToSuperview().offset(3)
            $0.right.equalToSuperview().offset(-6)
            $0.size.equalTo(CGSize(width: 29, height: 13))
        }
        
        backView.addSubview(rightView)
        rightView.snp.makeConstraints {
            $0.top.equalTo(merchIcon.snp_top).offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.left.equalTo(merchIcon.snp_right).offset(8)
            $0.bottom.equalToSuperview().offset(0)
        }
        
    }

}
