//
//  CLMyOrderCommonStatusCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/2.
//

import UIKit

class CLMyOrderCommonStatusCell: XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.hg_setAllCornerWithCornerRadius(radius: 10)
    }
    
    let statusImage = UIImageView().then{
        $0.image = UIImage(named: "we-icon-success-fill")
    }
    
    let statusLabel = UILabel().then{
        $0.text = "评价完成"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 18)
    }
    
    let des = UILabel().then{
        $0.text = "您的评论已提交,可到我的评价中查看"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }

    override func configUI() {
        contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [statusImage,statusLabel,des])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        statusImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(statusImage.snp.bottom).offset(16)
            make.centerX.equalTo(statusImage.snp.centerX)
        }
        
        des.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
            make.centerX.equalTo(statusLabel.snp.centerX)
        }
        
    }
}
