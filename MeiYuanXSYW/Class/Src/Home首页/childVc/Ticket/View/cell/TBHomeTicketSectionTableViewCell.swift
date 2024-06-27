//
//  TBHomeTicketSectionTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/21.
//

import UIKit

class TBHomeTicketSectionTableViewCell: XSBaseTableViewCell {

    let sectionImg: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "home_ticket_section_icon")
        return imgView
    }()
    
    lazy var sectionTitleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .text
        lb.font = MYBlodFont(size: 16)
        lb.text = "免费领券"
        return lb
    }()
    
    override func configUI() {
        
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(sectionImg)
        sectionImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 22, height: 18))
        }
        
        self.contentView.addSubview(sectionTitleLabel)
        sectionTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(sectionImg.snp_right).offset(6)
        }
    }

}
