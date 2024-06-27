//
//  XSSetLogoutCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/1.
//

import UIKit

class XSSetLogoutCell: XSBaseTableViewCell {
    
    var outBtn :UIButton={
        let btn = UIButton()
        btn.titleLabel?.font = MYBlodFont(size: 16)
        btn.setTitleColor(.white, for: UIControl.State.normal)
        btn.setTitle("退出登录", for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage(named: "btnBackImg"), for: UIControl.State.normal)
        btn.hg_setAllCornerWithCornerRadius(radius: 22)
        return btn
    }()
    
    override func configUI() {
        contentView.backgroundColor = .background
        contentView.addSubview(outBtn)
        outBtn.snp_makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalToSuperview()
        }
    }

    
}
