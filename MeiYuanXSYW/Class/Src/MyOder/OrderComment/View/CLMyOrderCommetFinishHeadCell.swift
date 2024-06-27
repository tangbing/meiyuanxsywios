//
//  CLMyOrderCommetFinishHeadCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/9.
//

import UIKit

class CLMyOrderCommetFinishHeadCell: XSBaseTableViewCell {

    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.hg_setCornerOnTopWithRadius(radius: 10)
    }
    
    let title = UILabel().then{
        $0.text = "评价其他订单"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let underLine = UIView().then{
        $0.backgroundColor = .borad
    }
    
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        baseView.addSubviews(views: [title,underLine])
        
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(16.5)
        }
        
        underLine.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
