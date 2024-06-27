//
//  TBMerchInfoLeftTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/8.
//

import UIKit

class TBMerchInfoLeftTableViewCell: XSBaseTableViewCell {
    
   
    lazy var titlabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .twoText
        lab.font = MYFont(size: 13)
        return lab
    }()
    
    override func configUI() {
        super.configUI()
        self.contentView.addSubview(titlabel)
        titlabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.titlabel.textColor = .text
        } else {
            self.titlabel.textColor = .twoText
        }
    }
}
