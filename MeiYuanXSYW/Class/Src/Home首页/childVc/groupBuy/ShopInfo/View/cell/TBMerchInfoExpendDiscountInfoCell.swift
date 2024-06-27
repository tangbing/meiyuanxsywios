//
//  TBMerchInfoPublishInfoCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/29.
//

import UIKit

class TBMerchInfoExpendDiscountInfoCell: XSBaseTableViewCell {

    lazy var leftView: UIImageView = {
        let iv = UIImageView()
        iv.hg_setAllCornerWithCornerRadius(radius: 4)
        return iv
    }()
    
    lazy var contentlab: UILabel = {
        let lab = UILabel()
        lab.text = "XXX联盟活动 满40减8元"
        lab.numberOfLines = 0
        lab.textColor = .twoText
        lab.font = MYFont(size: 12)
        return lab
    }()
    
    override func configUI() {
        self.contentView.addSubview(leftView)
        leftView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 16, height: 16))
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(contentlab)
        contentlab.snp.makeConstraints { make in
            make.left.equalTo(leftView.snp_right).offset(5)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(leftView)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        
    }
}
