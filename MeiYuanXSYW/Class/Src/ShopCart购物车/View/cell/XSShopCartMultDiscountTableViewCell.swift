//
//  XSMultDiscountTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/29.
//

import UIKit

class XSShopCartMultDiscountTableViewCell: XSBaseTableViewCell {

    lazy var leftView: UILabel = {
        let iv = UILabel()
        iv.text = "新"
        iv.textAlignment = .center
        iv.font = MYFont(size: 10)
        iv.hg_setAllCornerWithCornerRadius(radius: 4)
        iv.backgroundColor = .red
        iv.textColor = .white
        return iv
    }()
    
    lazy var leftImagView: UIImageView = {
        let leftImView = UIImageView()
        leftImView.isHidden = true
        leftImView.image = UIImage(named: "wallet(1)")
        return leftImView
    }()
    
    lazy var contentlab: UILabel = {
        let lab = UILabel()
        lab.text = "配送减免"
        lab.textColor = .text
        lab.font = MYFont(size: 14)
        return lab
    }()
    
    lazy var discountMsglab: UILabel = {
        let lab = UILabel()
        lab.text = "满105减5"
        lab.textColor = UIColor.hex(hexString: "#B3B3B3")
        lab.font = MYFont(size: 14)
        return lab
    }()
    
    lazy var lastPricelab: UILabel = {
        let lab = UILabel()
        lab.text = "-¥0"
        lab.textColor = UIColor.hex(hexString: "#737373")
        lab.font = MYFont(size: 16)
        return lab
    }()
    
    lazy var rightArrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(named: "merchInfo_detail_down")
        return arrow
    }()
    
    func configImageViewDataUI(isHidden: Bool){
        leftView.isHidden = isHidden
        leftImagView.isHidden = !isHidden
        discountMsglab.isHidden = isHidden
    }
    
    override func configUI() {
        super.configUI()
        self.contentView.addSubview(leftView)
        leftView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.left.equalToSuperview().offset(0)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(leftImagView)
        leftImagView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.left.equalToSuperview().offset(0)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(contentlab)
        contentlab.snp.makeConstraints { make in
            make.left.equalTo(leftView.snp_right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(discountMsglab)
        discountMsglab.snp.makeConstraints { make in
            make.left.equalTo(contentlab.snp_right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(rightArrow)
        rightArrow.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(0)
            make.size.equalTo(CGSize(width: 0, height: 0))
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(lastPricelab)
        lastPricelab.snp.makeConstraints { make in
            make.right.equalTo(rightArrow.snp_left).offset(0)
            make.centerY.equalToSuperview()
        }

    }
    

}
