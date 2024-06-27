//
//  XSShopCartBottomMsgTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/25.
//

import UIKit

class XSShopCartBottomOutBoundsTableViewCell: XSBaseTableViewCell {

    lazy var msgLabel: UILabel = {
        let lab = UILabel()
        lab.text = "超出配送范围"
        lab.textAlignment = .center
        lab.font = MYFont(size: 14)
        lab.textColor = .text
        return lab
    }()
    
    var outBounds: XSShopCartOutBoundsModel? {
        didSet {
            guard let model = outBounds else {
                return
            }
            if model.hasBottomRadius {
                self.contentView.hg_setCornerOnBottomWithRadius(radius: 10)
            }
            
        }
    }
    
    override func configUI() {
        super.configUI()
        
        self.contentView.addSubview(msgLabel)
        msgLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
    }

}
