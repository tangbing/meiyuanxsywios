//
//  CLBottomCornerRadioCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

class CLBottomCornerRadioCell: XSBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }

    override func configUI() {
        self.contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        contentView.addSubview(baseView)
        
        baseView.hg_setCornerOnBottomWithRadius(radius: 10)
        
        baseView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
}
