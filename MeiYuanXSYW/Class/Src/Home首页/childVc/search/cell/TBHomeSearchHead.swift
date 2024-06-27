//
//  TB.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/12.
//

import UIKit

class TBHomeSearchHead: UBaseCollectionReusableView {
    public lazy var titleLab: UILabel = {
        let vl = UILabel()
        vl.text = "历史搜索"
        vl.textColor = .text
        vl.font = UIFont.systemFont(ofSize: 14)
        return vl
    }()
    
    public lazy var rightButton: UIButton = {
        let sn = UIButton(type: .custom)
        sn.setTitleColor(UIColor.hex(hexString: "#979797"), for: .normal)
        sn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return sn
    }()
    
    override func configUI() {
        self.backgroundColor = UIColor.lightBackground
        addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(titleLab)
            make.size.equalTo(CGSize(width: 60, height: 18))
        }
    }
}
