//
//  XSSelectStandardItemHeaderView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/22.
//

import UIKit

class XSSelectStandardItemHeaderView: UBaseCollectionReusableView {

    public lazy var titleLab: UILabel = {
        let vl = UILabel()
        vl.text = "历史搜索"
        vl.textColor = .text
        vl.font = UIFont.systemFont(ofSize: 14)
        return vl
    }()

    
    override func configUI() {
        self.backgroundColor = UIColor.white
        addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
    }
}
