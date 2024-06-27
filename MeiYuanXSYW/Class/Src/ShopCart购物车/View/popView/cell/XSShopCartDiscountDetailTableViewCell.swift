//
//  XSShopCartDiscountDetailTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/1.
//

import UIKit
import QMUIKit

class XSShopCartDiscountDetailCollectionViewCell: XSBaseCollectionViewCell {

    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        //iv.contentMode = .scaleToFill
        iv.hg_setAllCornerWithCornerRadius(radius: 4)
        iv.image = UIImage(named: "group buy_picture4")
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "菜品名称"
        label.textColor = .twoText
        label.font = MYFont(size: 14)
        return label
    }()
    
    lazy var selectBtn: UIButton = {
        let all = UIButton(type: .custom)
        all.setImage(UIImage(named: "shopcart_detail_unselected"), for: .normal)
        all.setImage(UIImage(named: "mine_tick_selected"), for: .selected)
        all.addTarget(self, action: #selector(selectAction(select:)), for: .touchUpInside)
        all.isHidden = true
        return all
    }()
    
    lazy var singLabel: QMUILabel = {
        let sign = QMUILabel()
        sign.backgroundColor = UIColor.hex(hexString: "#518DFF")
        sign.textColor = .white
        sign.text = "外卖"
        sign.font = MYFont(size: 9)
        sign.contentEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        sign.isHidden = true
        return sign
    }()
    
//    lazy var rightNumLabel: UILabel = {
//        let lab = UILabel()
//        lab.textAlignment = .center
//        lab.text = "共\n7\n件"
//        lab.numberOfLines = 3
//        lab.textColor = .twoText
//        lab.font = MYFont(size: 11)
//        return lab
//    }()
    
//    lazy var rightNumView: UIView = {
//        let rightView = UIView()
//        rightView.backgroundColor = UIColor.clear
//        //UIColor(r: 255, g: 255, b: 255, a: 0.6)
//        return rightView
//    }()
    
    override func configUI() {
        super.configUI()
        
//        self.contentView.addSubview(rightNumView)
//        rightNumView.snp.makeConstraints { make in
//            make.top.right.equalTo(self.contentView)
//            make.height.equalTo(60)
//            make.width.equalTo(18)
//       }
//
//        rightNumView.addSubview(rightNumLabel)
//        rightNumLabel.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
        
        self.contentView.addSubview(merchIcon)
        merchIcon.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            //make.right.equalTo(rightNumView.snp_left).offset(0)
            make.right.equalToSuperview().offset(0)
            /// multipliedBy, 120 * 0.75 , dividedBy , 直接除以一个数值
            make.height.equalTo(merchIcon.snp_width).multipliedBy(0.75)
        }

//        self.contentView.addSubview(nameLabel)
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(merchIcon.snp_bottom).offset(6)
//            make.left.right.equalToSuperview()
//        }
//
//        merchIcon.addSubview(selectBtn)
//        selectBtn.snp.makeConstraints { make in
//            make.top.equalTo(merchIcon.snp_top).offset(4)
//            make.right.equalTo(merchIcon.snp_right).offset(-2)
//            make.size.equalTo(CGSize(width: 22, height: 22))
//        }
//
//        merchIcon.addSubview(singLabel)
//        singLabel.snp.makeConstraints { make in
//            make.top.left.equalToSuperview().offset(0)
//            make.size.equalTo(CGSize(width: 30, height: 15))
//        }
        
       

    }
    
    @objc func selectAction(select button: UIButton) {
        button.isSelected  = !button.isSelected
        
    }

}
