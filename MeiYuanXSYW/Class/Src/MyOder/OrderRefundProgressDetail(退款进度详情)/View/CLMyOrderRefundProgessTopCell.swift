//
//  CLMyOrderRefundProgessTopCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

class CLMyOrderRefundProgessTopCell: XSBaseTableViewCell {

    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let statusImage = UIImageView().then{
        $0.image = UIImage(named: "warn_fill")
    }
    
    let statusLabel = UILabel().then{
        $0.text = "退款失败"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 18)
    }
    
    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [statusImage,statusLabel])
        
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
            make.centerX.equalToSuperview()
        }
    }
}
