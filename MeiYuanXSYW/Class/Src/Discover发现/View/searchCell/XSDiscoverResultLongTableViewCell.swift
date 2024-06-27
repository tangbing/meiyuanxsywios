//
//  XSDiscoverResultLongTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/3.
//

import UIKit

class XSDiscoverResultLongRichView: TBBaseView {
    
    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        iv.hg_setAllCornerWithCornerRadius(radius: 17.5)
        //iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "group buy_picture4")
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "老李家的亲戚"
        label.numberOfLines = 1
        label.textColor = .text
        label.font = MYBlodFont(size: 14)
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let detail = UILabel()
        detail.text = "48分钟前"
        detail.numberOfLines = 1
        detail.text = "展示文章内容中包含的搜索词文和友…"
        detail.textColor = UIColor.hex(hexString: "#B3B3B3")
        detail.font = MYFont(size: 12)
        return detail
    }()
    
    override func configUI() {
        super.configUI()
        
        self.addSubview(merchIcon)
        merchIcon.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(5)
            make.size.equalTo(CGSize(width: 74, height: 55))
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(merchIcon.snp_right).offset(10)
            make.top.equalTo(merchIcon)
            make.right.equalToSuperview().offset(0)
        }
        
        self.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel).offset(0)
            make.top.equalTo(nameLabel.snp_bottom).offset(8)
            make.right.equalToSuperview()
        }
        
    }
}

class XSDiscoverResultLongTableViewCell: XSDiscoverResultBaseTableViewCell {

    lazy var richView: XSDiscoverResultLongRichView = {
        
        return XSDiscoverResultLongRichView()
    }()
    
    override func configUI() {
        super.configUI()
        
        self.contentView.addSubview(richView)
        richView.snp.makeConstraints { make in
            make.top.equalTo(line.snp_bottom).offset(10)
            make.left.right.equalTo(line)
            make.height.equalTo(65)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }

}
