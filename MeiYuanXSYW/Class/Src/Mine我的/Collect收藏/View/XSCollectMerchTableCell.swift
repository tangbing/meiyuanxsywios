//
//  XSCollectMerchTableCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/15.
//  收藏商品cell

import UIKit
import JKSwiftExtension
import QMUIKit
import SwiftUI


class XSCollectionBg: UIView {
    
    lazy var stateImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "vip_Used"))
        iv.bounds.size = CGSize(width: 60, height: 60)
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        self.addSubview(stateImageView)
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stateImageView.center = self.center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSCollectionAddressView: UIView {
    lazy var merchTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "35分钟"
        label.textAlignment = .right
//        label.backgroundColor = .yellow
        label.textColor = .twoText
        label.font = MYFont(size: 12)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 751), for: NSLayoutConstraint.Axis.horizontal)
        return label
    }()
    
    lazy var merchDistanceLabel: UILabel = {
        let label = UILabel()
        label.text = "1.2km"
        label.textAlignment = .right
        label.textColor = .twoText
//        label.backgroundColor = .purple
        label.font = MYFont(size: 12)
        label.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 751), for: NSLayoutConstraint.Axis.horizontal)
        return label
    }()
    
    lazy var merchAddresssLabel: UILabel = {
        let label = UILabel()
        label.text = "表示一个控件抗压缩的优先级。优先级越高，越不容易被压缩，默认是750"
        label.numberOfLines = 1
        label.textColor = .text
        label.font = MYFont(size: 13)
        /// 表示一个控件抗压缩的优先级。优先级越高，越不容易被压缩，默认是750
//        label.setContentCompressionResistancePriority(UILayoutPriority.init(rawValue: 749), for: NSLayoutConstraint.Axis.horizontal)
        return label
    }()
    
    // 线
    var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .borad
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setupUI(){
        self.addSubview(merchDistanceLabel)
        merchDistanceLabel.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
        }
        
        self.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.right.equalTo(merchDistanceLabel.snp_left).offset(-4)
            make.width.equalTo(1)
        }
        
        self.addSubview(merchTimeLabel)
        merchTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(merchDistanceLabel)
            make.right.equalTo(lineView.snp_left).offset(-4)
        }
        
        self.addSubview(merchAddresssLabel)
        merchAddresssLabel.snp.makeConstraints { make in
            make.centerY.equalTo(merchDistanceLabel)
            make.left.equalToSuperview()
            make.width.greaterThanOrEqualTo(127)
            make.right.equalTo(merchTimeLabel.snp_left).offset(-2)
            //make.right.equalTo(merchDistanceLabel.snp_left).offset(-2).priorityMedium()
            //make.right.equalToSuperview().offset(-2).priorityLow()
        }
    }
//    /// 外卖收藏cell
//    public func configDelieve(){
//    }
    
    /// 团购的收藏
    public func configGroupBuy() {
        merchTimeLabel.isHidden = true
        
        lineView.snp.updateConstraints { make in
            make.width.equalTo(0)
            make.right.equalTo(merchDistanceLabel.snp_left).offset(0)
        }

        merchTimeLabel.snp.updateConstraints { make in
            make.right.equalTo(lineView.snp_left).offset(0)
        }
        
        merchAddresssLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(merchDistanceLabel)
            make.left.equalToSuperview()
            make.width.greaterThanOrEqualTo(127)
            make.right.equalTo(merchDistanceLabel.snp_left).offset(-2)
        }
    }
    /// 私厨
    func configPrivateKitchen() {
        
        lineView.isHidden = true
        merchTimeLabel.isHidden = true
        merchDistanceLabel.isHidden = true
        
        merchAddresssLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(merchDistanceLabel)
            make.left.equalToSuperview()
            make.width.greaterThanOrEqualTo(127)
            make.right.equalToSuperview().offset(-2)
        }
    }
}

class XSEvaluatCustomLabel: UIView {
    
    // 广东菜
    var vegWhereLabel: UILabel = {
        let vegWhere = UILabel()
        vegWhere.text = "广东菜"
        vegWhere.textColor = .tag
        vegWhere.font = MYFont(size: 11)
        return vegWhere
    }()
    
    // 线
    var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .borad
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews(views: [vegWhereLabel, lineView])
        
        vegWhereLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp_left).offset(2)
            make.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(0)
            make.height.equalTo(vegWhereLabel)
            make.left.equalTo(vegWhereLabel.snp_right).offset(6)
            make.width.equalTo(1)
            make.right.equalToSuperview().offset(0)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSCollectHightEvaluatView: UIView {
    
    var themeColor: UIColor = .king {
        didSet {
            tagLabes.forEach {
                $0.vegWhereLabel.textColor = themeColor
                $0.lineView.backgroundColor = themeColor
            }
        }
    }
        
    var lastTagLabel: XSEvaluatCustomLabel?
    var tagLabes = [XSEvaluatCustomLabel]()
    
    lazy var hightEvaluate: QMUILabel = {
        let iv = QMUILabel()
        iv.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        iv.text = "97%好评率"
        iv.font = MYFont(size: 10)
        iv.textColor = .white
        iv.backgroundColor = .tag
        iv.hg_setAllCornerWithCornerRadius(radius: 2)
        /// 表示一个控件抗伸缩的优先级。优先级越高，越不容易被伸缩，默认是750
        iv.setContentHuggingPriority(UILayoutPriority.init(rawValue: 751), for: NSLayoutConstraint.Axis.horizontal)

        return iv
    }()
    
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
    
//    // 鸡煲
//    var vegNameLabel : UILabel = {
//        let lb = UILabel()
//        lb.text = "鸡煲"
//        lb.textColor = .tag
//        lb.font = MYFont(size: 11)
//        return lb
//    }()
//
//    // 晚餐
//    var dinnerLabel : UILabel = {
//        let ib = UILabel()
//        ib.text = "晚餐"
//        ib.textColor = .tag
//        ib.font = MYFont(size: 11)
//        return ib
//    }()
    
    func layoutWithtags(tags: [String], praise: String?) {
        
        lastTagLabel = nil
        self.clearAll()
        
        
        if praise != nil {
            hightEvaluate.text = praise
            self.addSubview(hightEvaluate)
            hightEvaluate.snp.makeConstraints { make in
                make.left.centerY.equalToSuperview()
            }
        }
        
        for (idx,tag) in tags.enumerated() {
            let tagLabel = XSEvaluatCustomLabel()
            tagLabel.vegWhereLabel.text = tag
            self.addSubview(tagLabel)
            tagLabes.append(tagLabel)
            
            tagLabel.lineView.isHidden = (idx == (tags.count - 1))
            
            if praise != nil {
                tagLabel.snp.makeConstraints { make in
                    make.left.equalTo(lastTagLabel != nil ? lastTagLabel!.snp_right : hightEvaluate.snp_right).offset(6)
                    make.centerY.equalToSuperview()
                }
            } else {
                tagLabel.snp.makeConstraints { make in
                    make.left.equalTo(lastTagLabel != nil ? lastTagLabel!.snp_right : self.snp_left).offset(6)
                    make.centerY.equalToSuperview()
                }
            }
           
            
            lastTagLabel = tagLabel
        }
        
        if lastTagLabel != nil {
            lastTagLabel!.snp.makeConstraints { make in
                make.right.equalToSuperview()
            }
        }
            
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func configMerchInfo(){
        vegWhereLabel.snp.remakeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
        hightEvaluate.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XSCollectMerchTableCell: XSBaseTableViewCell {
    

    var findFoodModel: XSHomeFindFoodData = XSHomeFindFoodData()  {
        didSet {
            merchIcon.xs_setImage(urlString: findFoodModel.topPic)
            merchNameLabel.text = findFoodModel.goodsName
            
            //addressView.merchTimeLabel.text = "\(findFoodModel.deliveryTime)分钟"
            addressView.merchAddresssLabel.text = findFoodModel.merchantAddress
            addressView.merchDistanceLabel.text = "\(findFoodModel.distance)km"
            
            let tagNames = findFoodModel.tagName.components(separatedBy: ",")
            evaluatView.layoutWithtags(tags: tagNames, praise: "\(findFoodModel.praise)%好评率")
            
            
            priveView.finalPriceLabel.text = "¥\(findFoodModel.minPrice)"
            priveView.previousPriceLabel.text = "¥\(findFoodModel.originalPrice)"
            priveView.previousPriceLabel.jk.setSpecificTextDeleteLine("¥\(findFoodModel.originalPrice)", color: UIColor.hex(hexString: "#B3B3B3"))
            priveView.reduceDownPriceLabel.text = "\(findFoodModel.discountRate)折"
            
            
            // 商品类型(0:外卖;1:团购;2:私厨)
            if findFoodModel.goodsType == 1 {
                merchTypeIcon.image = UIImage(named: "vip_Toshop")
            } else if findFoodModel.goodsType == 2 {
                merchTypeIcon.image = UIImage(named: "vip_private_kitchen")
            }
        }
    }
    

    var model: CLMyCollectGoodsListModel? {
        didSet {
            guard let model = model else { return }
            
            merchIcon.xs_setImage(urlString: model.topPic)
            merchNameLabel.text = model.goodsName
            
            addressView.merchTimeLabel.text = "\(model.deliveryTime)分钟"
            addressView.merchAddresssLabel.text = model.merchantAddress
            addressView.merchDistanceLabel.text = "\(model.distance)km"

            
            let tagNames = model.tagName.components(separatedBy: ",")
            evaluatView.layoutWithtags(tags: tagNames, praise: "\(model.praise)%好评率")
            
            
            priveView.finalPriceLabel.text = "¥\(model.minPrice)"
            priveView.previousPriceLabel.text = "¥\(model.originalPrice)"
            priveView.previousPriceLabel.jk.setSpecificTextDeleteLine("¥\(model.originalPrice)", color: UIColor.hex(hexString: "#B3B3B3"))
            priveView.reduceDownPriceLabel.text = "\(model.discountRate)折"
            
            
            // 商品类型(0:外卖;1:团购;2:私厨)
            if model.goodsType == 1 {
                merchTypeIcon.image = UIImage(named: "vip_Toshop")
            } else if model.goodsType == 2 {
                merchTypeIcon.image = UIImage(named: "vip_private_kitchen")
            }
            
        }
    }
    
    
    var goodsModel: TBHomeSearchGoodsModel? {
        didSet {
            guard let model = goodsModel?.searchGoodsModel else { return }
            
            merchIcon.xs_setImage(urlString: model.topPic)
            merchNameLabel.text = model.goodsName
            
            addressView.merchTimeLabel.text = "\(model.deliveryTime)分钟"
            addressView.merchAddresssLabel.text = model.merchantAddress
            addressView.merchDistanceLabel.text = "\(model.distance)km"

            
            let tagNames = model.tagName.components(separatedBy: ",")
            evaluatView.layoutWithtags(tags: tagNames, praise: "\(model.praise)%好评率")
            
            
            priveView.finalPriceLabel.text = "¥\(model.minPrice)"
            priveView.previousPriceLabel.text = "¥\(model.originalPrice)"
            priveView.previousPriceLabel.jk.setSpecificTextDeleteLine("¥\(model.originalPrice)", color: UIColor.hex(hexString: "#B3B3B3"))
            priveView.reduceDownPriceLabel.text = "\(model.discountRate)折"
            
            
            // 商品类型(0:外卖;1:团购;2:私厨)
            if model.goodsType == 1 {
                merchTypeIcon.image = UIImage(named: "vip_Toshop")
            } else if model.goodsType == 2 {
                merchTypeIcon.image = UIImage(named: "vip_private_kitchen")
            }
            
        }
    }
    
    lazy var backView: UIView! = {
        let view = UIView()
        view.backgroundColor = .clear
        view.hg_setAllCornerWithCornerRadius(radius:10)
        return view
    }()
    
    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
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
    
    lazy var rightView: UIView = {
        let rightIV = UIView()
        rightIV.backgroundColor = .clear
        return rightIV
    }()
    
    lazy var merchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "康美甄营养餐菜品名称"
        label.textColor = .twoText
        label.font = MYBlodFont(size: 16)
        return label
    }()
    
    lazy var addressView: XSCollectionAddressView = {
        let addressView = XSCollectionAddressView()
        return addressView
    }()
    
    lazy var evaluatView: XSCollectHightEvaluatView = {
        let evaluatView = XSCollectHightEvaluatView()
        return evaluatView
    }()
    
    lazy var priveView: XSCollectPriceView = {
        let priveView = XSCollectPriceView()
        return priveView
    }()
    
    lazy var merchBgView: XSCollectionBg = {
        let merchBgView = XSCollectionBg()
        merchBgView.isHidden = true
        return merchBgView
    }()
    
    lazy var shopCartBtn: QMUIButton = {
        let btn = QMUIButton()
        btn.setImage(UIImage(named: "collect_Shopping_Cart"), for: .normal)
        btn.addTarget(self, action: #selector(goCartBtnClick), for: .touchUpInside)
        return btn
    }()
    
    
    
    var addCartClickHandler: ((Int) -> ())?
    
    var index: Int = 0 {
        didSet {
            shopCartBtn.tag = index
        }
    }
    
    override func configUI() {
        super.configUI()
        self.contentView.hg_setAllCornerWithCornerRadius(radius: 10)
      
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
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
        
        merchIcon.addSubview(merchBgView)
        merchBgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
            $0.right.equalToSuperview().offset(-10)
            $0.left.equalTo(merchIcon.snp_right).offset(8)
            $0.bottom.equalTo(merchIcon.snp_bottom).offset(0)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        rightView.addSubview(merchNameLabel)
        merchNameLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        rightView.addSubview(addressView)
        addressView.snp.makeConstraints { make in
            make.top.equalTo(merchNameLabel.snp_bottom).offset(3)
            make.left.right.equalTo(rightView)
            make.height.equalTo(20)
        }
        
        rightView.addSubview(shopCartBtn)
        shopCartBtn.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 25, height: 25))
            $0.right.equalToSuperview().offset(-2)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        rightView.addSubview(evaluatView)
        evaluatView.snp.makeConstraints { make in
            make.top.equalTo(addressView.snp_bottom).offset(7)
            make.left.equalTo(rightView)
            make.right.equalTo(shopCartBtn.snp_left).offset(-2)
            make.height.equalTo(18)
        }
        
        rightView.addSubview(priveView)
        priveView.snp.makeConstraints {
            $0.top.equalTo(evaluatView.snp_bottom).offset(0)
            $0.left.equalTo(rightView)
            $0.height.equalTo(24)
            $0.right.equalTo(shopCartBtn.snp_left).offset(-10)
        }

    }
    
   @objc func goCartBtnClick(){
      addCartClickHandler?(shopCartBtn.tag)
   }
}
