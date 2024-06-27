//
//  XSShareCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/9.
//

import UIKit

class XSShareCollectionViewCell: XSBaseCollectionViewCell {
    
    var shareModel: XSShareModel? {
        didSet {
            guard let model = shareModel else {
                return
            }
            iconImage.image = UIImage(named: model.imageName)
            titleLab.text = model.titleName
        }
    }
    
    
    lazy var iconImage: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    lazy var titleLab: UILabel = {
        let title = UILabel()
        title.textColor = .text
        title.font = MYFont(size: 12)
        return title
    }()
    
    override func configUI() {
        super.configUI()
        self.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(55)
            make.top.left.right.equalToSuperview()
        }
        
        self.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp_bottom).offset(0)
            make.left.right.bottom.equalToSuperview()
        }
        
        
    }
}
