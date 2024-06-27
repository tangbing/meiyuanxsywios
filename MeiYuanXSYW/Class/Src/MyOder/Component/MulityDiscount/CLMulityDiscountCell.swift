//
//  CLMulityDiscountCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/31.
//

import UIKit

class CLMulityDiscountCell: XSBaseTableViewCell {
    var title = UILabel().then{
        $0.text = ""
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    
    let discount = UILabel().then{
        $0.text = "9折"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
    }
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .white
        self.contentView.addSubviews(views: [title,discount])
        title.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        discount.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
        }
    }
}
