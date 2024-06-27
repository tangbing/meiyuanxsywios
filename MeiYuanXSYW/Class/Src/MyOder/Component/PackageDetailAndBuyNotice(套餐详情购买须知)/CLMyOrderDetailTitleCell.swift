//
//  CLMyOrderDetailTitleView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

class CLMyOrderDetailTitleCell: XSBaseTableViewCell {
    
    let height = 25.0
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let dot = UIView().then{
        $0.backgroundColor = .text
        $0.layer.cornerRadius = 1.5
    }
    
    let title = UILabel().then{
        $0.text = "招牌推荐"
        $0.textColor = .text
        $0.font  = MYBlodFont(size: 14)
    }
    
    func setting(_ title:String){
        self.title.text = title
    }
    
    override func configUI() {
        contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [dot,title])
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(25.5)
        }
        
        dot.snp.makeConstraints { make in
            make.centerY.equalTo(title.snp.centerY)
            make.right.equalTo(title.snp.left).offset(-6)
            make.width.height.equalTo(3)
        }
        

    }

}
