//
//  XSDiscoverStudySpaceWaitTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit

class XSDiscoverStudySpaceWaitTableViewCell: XSBaseTableViewCell {

    var waitModel: XSStudySpaceWaitModel? {
        didSet {
            guard let model = waitModel else {
                return
            }
            if model.hasBottomRadius {
                containerView.hg_setCornerOnBottomWithRadius(radius: 10)
            }
        }
    }
    
    lazy var containerView: UIView = {
        let contain = UIView()
        contain.backgroundColor = .white
        return contain
    }()
    
    lazy var contentLabel: UILabel = {
        let lab = UILabel()
        lab.text = "具体内容，后台编辑"
        lab.textAlignment = .center
        lab.textColor = .twoText
        lab.backgroundColor = UIColor.hex(hexString: "#F5F5F5")
        lab.font = MYFont(size: 18)
        return lab
    }()
    
    override func configUI() {
        self.contentView.backgroundColor = .background

        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        }
        
        containerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }

}
