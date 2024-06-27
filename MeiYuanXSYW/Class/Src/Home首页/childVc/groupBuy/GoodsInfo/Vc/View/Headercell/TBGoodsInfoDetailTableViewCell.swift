//
//  TBGoodsInfoDetailTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/16.
//

import UIKit

class TBGoodsInfoDetailTableViewCell: XSBaseTableViewCell {


    var detailModel: TBShopInfoDetailModel? {
        didSet {
            guard let model = detailModel else {
                return
            }
            
            self.detailTitleLabel.text = model.titleText
            self.detailContentLabel.text = model.titleContent
            if model.hasTopRadius {
                contain.hg_setCornerOnTopWithRadius(radius: 10)
            }
            if model.hasBottomRadus {
                contain.hg_setCornerOnBottomWithRadius(radius: 10)
            }
        }
    }
    
    lazy var contain: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        return iv
    }()
    
    lazy var detailTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .text
        label.font = MYBlodFont(size: 14)
        return label
    }()

    lazy var detailContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .twoText
        label.numberOfLines = 0
        label.font = MYFont(size: 13)
        return label
    }()
    
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(contain)
        contain.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        contain.addSubview(detailTitleLabel)
        detailTitleLabel.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }

        contain.addSubview(detailContentLabel)
        detailContentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalTo(detailTitleLabel.snp_right).offset(10)
            make.right.equalToSuperview().offset(-5)
        }
        
    }

}
