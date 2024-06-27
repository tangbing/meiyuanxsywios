//
//  TBHomeSearchResultLessTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/13.
//

import UIKit

class TBHomeSearchResultLessTableViewCell: XSBaseTableViewCell {

    lazy var label: UILabel = {
        let iv = UILabel()
        iv.text = "-搜索结果太少，为您发现更多相关内容-"
        iv.textColor = UIColor.hex(hexString: "#B3B3B3")
        iv.font = MYFont(size: 11)
        return iv
    }()
    
    override func configUI() {
        self.contentView.backgroundColor = .background
        self.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
}
