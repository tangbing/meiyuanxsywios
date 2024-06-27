//
//  TBMerchInfoExpendMerchPublishInfoCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/29.
//

import UIKit

class TBMerchInfoExpendMerchPublishInfoCell: XSBaseTableViewCell {

    lazy var contentLabel: UILabel = {
        let iv = UILabel()
        iv.numberOfLines = 0
        iv.textColor = .twoText
        iv.text = "注意事项注意事项注意事项注意事项注意事项注意事项注意事项注意事项注意事项注意事项注意事项注意事项注意事项注意事项注意事项"
        iv.font = MYFont(size: 12)
        return iv
    }()
    override func configUI() {
        self.contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
}
