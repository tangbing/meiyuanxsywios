//
//  XSDiscoverResultBaseTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/3.
//

import UIKit

class XSDiscoverResultBaseTableViewCell: XSBaseTableViewCell {

    lazy var topInfoView: XSDiscoverRecommandTopInfoView = {
        let infoView = XSDiscoverRecommandTopInfoView()
        return infoView
    }()
    
    lazy var contentLab: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.hex(hexString: "#B3B3B3")
        lab.text = "内容的文字详情最多展示1行文和友"
        lab.font = MYFont(size: 12)
        lab.numberOfLines = 1
        return lab
    }()
    lazy var line: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: 59, width: screenWidth, height: 1))
        line.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        return line
    }()
    

    override func configUI() {
        super.configUI()
        
        self.contentView.hg_setAllCornerWithCornerRadius(radius: 10)
        
        self.contentView.addSubview(topInfoView)
        topInfoView.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.top.left.right.equalToSuperview()
        }
        
        self.contentView.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.left.equalTo(topInfoView.merchIcon)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(topInfoView.snp_bottom).offset(15)
            make.height.equalTo(17)
        }
        
        self.contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.right.equalTo(contentLab)
            make.height.equalTo(1)
            make.top.equalTo(contentLab.snp_bottom).offset(8)
            
        }
        
    }


}
