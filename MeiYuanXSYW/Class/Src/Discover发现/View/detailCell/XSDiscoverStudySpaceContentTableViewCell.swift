//
//  XSDiscoverStudySpaceContentTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit

class XSDiscoverStudySpaceContentTableViewCell: XSBaseTableViewCell {

    lazy var containerView: UIView = {
        let contain = UIView()
        contain.backgroundColor = .white
        return contain
    }()
    
    lazy var contentLabel: UILabel = {
        let lab = UILabel()
        lab.text = "非常有格调的小众英伦香氛的味道，威廉梨和"
        lab.textAlignment = .center
        lab.textColor = .twoText
        lab.font = MYFont(size: 13)
        return lab
    }()
    
    override func configUI() {
        self.contentView.backgroundColor = .clear

        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        containerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }


}
