//
//  CLMyOrderCommentGroupCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/17.
//

import UIKit
import Kingfisher
import QMUIKit

class CLMyOrderCommentGroupCell: XSBaseTableViewCell{
    
    var rateBlock:((_ tag:Int,_ rate:CGFloat)->())?

    var cellModel :[String] = ["add"]
    var viewHeight:CGFloat =  0.0
    var maxNum :Int = 9
    
    let baseView = UIView().then{
        $0.hg_setAllCornerWithCornerRadius(radius: 10)
        $0.backgroundColor = .white
    }
    
    let shopImage = UIImageView().then{
        $0.image = UIImage(named: "test")
        $0.contentMode = .scaleToFill
    }
    
    let shopName = UILabel().then{
        $0.text = "老李家的亲戚"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let totalLabel = UILabel().then{
        $0.text = "总体"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let totalStar = SwiftyStarRatingView().then{
        $0.backgroundColor = .white
        $0.maximumValue = 5
        $0.minimumValue = 0
        $0.allowsHalfStars = false
        $0.halfStarImage = UIImage(named: "stars5")
        $0.emptyStarImage = UIImage(named: "stars4")
        $0.filledStarImage = UIImage(named: "stars3")
        $0.tag = 1001
    }
    
    let tasteLabel = UILabel().then{
        $0.text = "口味"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }

    let tasteStar = SwiftyStarRatingView().then{
        $0.backgroundColor = .white
        $0.maximumValue = 5
        $0.minimumValue = 0
        $0.allowsHalfStars = false
        $0.halfStarImage = UIImage(named: "stars5")
        $0.emptyStarImage = UIImage(named: "stars2")
        $0.filledStarImage = UIImage(named: "stars1")
        $0.tag = 1002
    }
    
    let environmentLabel = UILabel().then{
        $0.text = "环境"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    
    let environmentStar = SwiftyStarRatingView().then{
        $0.backgroundColor = .white
        $0.maximumValue = 5
        $0.minimumValue = 0
        $0.allowsHalfStars = false
        $0.halfStarImage = UIImage(named: "stars5")
        $0.emptyStarImage = UIImage(named: "stars2")
        $0.filledStarImage = UIImage(named: "stars1")
        $0.tag = 1004
    }
    
    let serviceLabel = UILabel().then{
        $0.text = "服务"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    
    let serviceStar = SwiftyStarRatingView().then{
        $0.backgroundColor = .white
        $0.maximumValue = 5
        $0.minimumValue = 0
        $0.allowsHalfStars = false
        $0.halfStarImage = UIImage(named: "stars5")
        $0.emptyStarImage = UIImage(named: "stars2")
        $0.filledStarImage = UIImage(named: "stars1")
        $0.tag = 1005
    }
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(cellType: CLMyOrderLikeCell.self)
        $0.separatorStyle = .none
    }
    
    
    
    let commitButton = UIButton().then{
        $0.setTitle("提交评价", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
    }
    
    
    let commentView = UIView().then{
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#F9FAF9")!
        $0.hg_setAllCornerWithCornerRadius(radius: 10)
    }
    
    
    let textField = QMUITextView().then{
        //$0.placeholdFont = MYFont(size: 14)
        $0.setValue("口味好,包装好,推荐给大家", forKeyPath: "placeholder")
        $0.setValue(UIColor.fourText, forKeyPath: "placeholderColor")
        $0.setValue(UIColor.fourText, forKeyPath: "textColor")
        $0.setValue(MYFont(size: 14), forKeyPath: "font")
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#F9FAF9")!
    }
    
    var collectionView:UICollectionView!


    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @objc func click(_ sender:SwiftyStarRatingView){
        guard let action = rateBlock else { return }
        action(sender.tag,sender.value)
    }
    
    override func configUI() {
        
        contentView.backgroundColor = .lightBackground
        self.contentView.addSubview(baseView)
        self.contentView.addSubview(tableView)

        baseView.addSubviews(views: [shopImage,shopName,totalLabel,totalStar,tasteLabel,tasteStar,environmentLabel,environmentStar,serviceLabel,serviceStar,commentView])
        commentView.addSubview(textField)
        
        totalStar.addTarget(self, action: #selector(click(_:)), for: .valueChanged)
        tasteStar.addTarget(self, action: #selector(click(_:)), for: .valueChanged)
        environmentStar.addTarget(self, action: #selector(click(_:)), for: .valueChanged)
        serviceStar.addTarget(self, action: #selector(click(_:)), for: .valueChanged)


        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        shopImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        
        shopName.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.right).offset(10)
            make.centerY.equalTo(shopImage.snp.centerY)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.left.equalTo(shopImage.snp.left)
            make.top.equalTo(shopImage.snp.bottom).offset(18)
        }
        
        totalStar.snp.makeConstraints { make in
            make.left.equalTo(totalLabel.snp.right).offset(10)
            make.centerY.equalTo(totalLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(210)
        }
        
        tasteLabel.snp.makeConstraints { make in
            make.left.equalTo(totalLabel.snp.left)
            make.top.equalTo(totalLabel.snp.bottom).offset(20)
        }
        
        tasteStar.snp.makeConstraints { make in
            make.left.equalTo(tasteLabel.snp.right).offset(10)
            make.centerY.equalTo(tasteLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(205)
        }
        
        environmentLabel.snp.makeConstraints { make in
            make.left.equalTo(tasteLabel.snp.left)
            make.top.equalTo(tasteLabel.snp.bottom).offset(20)
        }
        
        environmentStar.snp.makeConstraints { make in
            make.left.equalTo(environmentLabel.snp.right).offset(10)
            make.centerY.equalTo(environmentLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(205)
        }
        
        serviceLabel.snp.makeConstraints { make in
            make.left.equalTo(environmentLabel.snp.left)
            make.top.equalTo(environmentLabel.snp.bottom).offset(20)
        }
        
        serviceStar.snp.makeConstraints { make in
            make.left.equalTo(serviceLabel.snp.right).offset(10)
            make.centerY.equalTo(serviceLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(205)
        }
        
        commentView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(serviceLabel.snp.bottom).offset(25)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(100)
        }
        
        let layout =  UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 75, height: 75)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CLMyOrderCommentCollectionCell.self, forCellWithReuseIdentifier: "CLMyOrderCommentCollectionCell")

        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .lightBackground
        commentView.addSubview(collectionView)

        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.top.equalTo(textField.snp.bottom).offset(15)
//            make.height.equalTo(85)
        }
    }
}
