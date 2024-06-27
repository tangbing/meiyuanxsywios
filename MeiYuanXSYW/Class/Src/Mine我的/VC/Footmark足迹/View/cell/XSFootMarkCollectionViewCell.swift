//
//  XSFootMarkCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/18.
//

import UIKit
import QMUIKit


class XSFootMarkCollectionViewCell: XSBaseCollectionViewCell {
    
    var model:CLGoodListModel? {
        didSet{
            guard let model = model else { return }
            footMarkMerchNameLabel.text = model.goodsName
            footMarkMerchEvaluate.text = model.praise + "%好评率"
            footMarkMerchFinalPriceLabel.text = "￥" + model.minPrice
            footMarkMerchPreviousPriceLabel.text = "￥" + model.originalPrice
            footMarkMerchIcon.xs_setImage(urlString: model.topPic)
        }
    }

    lazy var backView: UIView! = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var footMarkMerchIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 5
//        iv.hg_setAllCornerWithCornerRadius(radius: 5)
        iv.image = #imageLiteral(resourceName: "login_LOGO")
        return iv
    }()
    
    lazy var footMarkMerchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "康美甄营养餐菜品名称"
        label.textColor = .twoText
        label.font = MYBlodFont(size: 16)
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
    
    lazy var footMarkMerchFinalPriceLabel: UILabel = {
        let ib = UILabel()
        ib.textColor = UIColor.hex(hexString: "#E61016")
        ib.font = MYBlodFont(size: 12)
        ib.text = "￥28.5"
        return ib
    }()
    
    lazy var footMarkMerchPreviousPriceLabel: UILabel = {
        let ib = UILabel()
        ib.textColor = UIColor.hex(hexString: "#B3B3B3")
        ib.font = MYFont(size: 11)
        ib.text = "￥110"
        ib.jk.setSpecificTextDeleteLine("￥110", color: .twoText)
        return ib
    }()
    
    lazy var footMarkMerchShopCartBtn: QMUIButton = {
        let btn = QMUIButton()
        btn.setImage(UIImage(named: "collect_Shopping_Cart"), for: .normal)
        btn.addTarget(self, action: #selector(footMarkMerchGoCartBtnClick), for: .touchUpInside)
        btn.isHidden = true
        return btn
    }()
   // cell.footMarkMerchShopCartBtn.setImage(<#T##image: UIImage?##UIImage?#>, for: .normal)

    override func configUI() {
       
        self.contentView.addSubview(backView)
        backView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.top.equalToSuperview()
        }
        
        backView.addSubview(footMarkMerchIcon)
        footMarkMerchIcon.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.top.equalToSuperview().offset(5)
            $0.height.equalTo(55)
            $0.width.equalTo(74)
            $0.bottom.equalToSuperview().offset(-5)
        }
        
        backView.addSubview(footMarkMerchNameLabel)
        footMarkMerchNameLabel.snp.makeConstraints {
            $0.left.equalTo(footMarkMerchIcon.snp_right).offset(5)
            $0.top.equalTo(footMarkMerchIcon)
            $0.right.equalToSuperview().offset(-5)
        }


        backView.addSubview(footMarkMerchFinalPriceLabel)
        footMarkMerchFinalPriceLabel.snp.makeConstraints {
            $0.left.equalTo(footMarkMerchNameLabel)
            $0.top.equalTo(footMarkMerchNameLabel.snp_bottom).offset(2)
            
        }

        backView.addSubview(footMarkMerchPreviousPriceLabel)
        footMarkMerchPreviousPriceLabel.snp.makeConstraints {
            $0.left.equalTo(footMarkMerchFinalPriceLabel.snp_right).offset(2)
            $0.bottom.equalTo(footMarkMerchFinalPriceLabel)
        }

        backView.addSubview(footMarkMerchEvaluate)
        footMarkMerchEvaluate.snp.makeConstraints {
            $0.left.equalTo(footMarkMerchNameLabel).offset(0)
            $0.bottom.equalTo(footMarkMerchIcon)
        }
        
        backView.addSubview(footMarkMerchShopCartBtn)
        footMarkMerchShopCartBtn.snp.makeConstraints {
            $0.left.equalTo(footMarkMerchEvaluate.snp_right).offset(6)
            $0.centerY.equalTo(footMarkMerchEvaluate)
            $0.size.equalTo(CGSize(width: 15, height: 15))
        }
    }
    
    /// event click
    @objc func footMarkMerchGoCartBtnClick(){
       
    }

}
