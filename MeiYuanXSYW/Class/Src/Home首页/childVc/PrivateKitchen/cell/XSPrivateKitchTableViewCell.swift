//
//  XSPrivateKitchTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/22.
//

import UIKit
import QMUIKit


class XSPrivateKitchTableViewCell: XSBaseTableViewCell {
    
    var privateKitchenModel: XSHomePrivateKitchenData = XSHomePrivateKitchenData()  {
        didSet {
            
            namelab.text = privateKitchenModel.merchantName
            pricelab.text = "¥\(privateKitchenModel.avgPrice.doubleValue)/人"
            topBgImageView.xs_setImage(urlString: privateKitchenModel.merchantPlaque, placeholder: UIImage.placeholder)
            detailLab.text = privateKitchenModel.merchantRecommend
            serviceView.layoutWithtags(tags: privateKitchenModel.merchantTag, praise: nil)
            serviceView.themeColor = .white
        }
    }

    lazy var container: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        iv.hg_setAllCornerWithCornerRadius(radius: 10)
        return iv
    }()
    
    lazy var topBgImageView: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: "img31")
        return bg
    }()
    
    lazy var pricelab: UILabel = {
        let lab = UILabel()
        lab.text = "¥200/人"
        lab.textColor = UIColor.white
        lab.font = MYFont(size: 14)
        return lab
    }()
    
    lazy var namelab: UILabel = {
        let lab = UILabel()
        lab.text = "御膳私厨"
        lab.textColor = .text
        lab.font = MYFont(size: 16)
        return lab
    }()
    
    //进店
    lazy var addBtn : QMUIButton = {
        let arrowBtn = QMUIButton(type: .custom)
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("进店", for: .normal)
        arrowBtn.setTitleColor(UIColor.white, for: .normal)
        arrowBtn.hg_setAllCornerWithCornerRadius(radius: 4)
        arrowBtn.titleLabel?.font = MYFont(size: 13)
        let colors = [UIColor.hex(hexString: "#EFCB9C"),
                      UIColor.hex(hexString: "#E8C089")]
        arrowBtn.hg_addGradientColor(colors, size: CGSize(width: 45, height: 19), startPoint: CGPoint(x: 0.03, y: 0.15), endPoint: CGPoint(x: 0.8, y: 0.8))
        arrowBtn.addTarget(self, action: #selector(clickShopAction), for: .touchUpInside)
        return arrowBtn
    }()
    
    lazy var detailLab: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.text = "旧食宫廷，今食御膳，寻常人家的饕餮盛宴。御膳私厨是全新个性化定制、上门私厨服务品牌，由全国…"
        lab.textColor = .twoText
        lab.font = MYFont(size: 14)
        return lab
    }()
    
    
    
    lazy var serviceView: XSCollectHightEvaluatView  = {
        let evaluatView = XSCollectHightEvaluatView()
        evaluatView.themeColor = UIColor.white
        return evaluatView
    }()
    
  
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        }
        
        container.addSubview(topBgImageView)
        topBgImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(FMScreenScaleFrom(150))
        }
        
        topBgImageView.addSubview(serviceView)
        serviceView.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(14)
        }
        
        topBgImageView.addSubview(pricelab)
        pricelab.snp.makeConstraints { make in
            make.right.equalTo(serviceView.snp_left).offset(-10)
            make.centerY.equalTo(serviceView)
            make.height.equalTo(14)
        }
        
        container.addSubview(namelab)
        namelab.snp.makeConstraints { make in
            make.top.equalTo(topBgImageView.snp_bottom).offset(15)
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(16)
        }
        
        container.addSubview(addBtn)
        addBtn.snp.makeConstraints { make in
            make.centerY.equalTo(namelab)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 45, height: 19))
        }
        
        container.addSubview(detailLab)
        detailLab.snp.makeConstraints { make in
            make.top.equalTo(namelab.snp_bottom).offset(10)
            make.left.equalTo(namelab)
            make.right.equalTo(addBtn)
            make.bottom.equalToSuperview().offset(-16)
        }

    }
    
    @objc func clickShopAction() {
        
    }


}
