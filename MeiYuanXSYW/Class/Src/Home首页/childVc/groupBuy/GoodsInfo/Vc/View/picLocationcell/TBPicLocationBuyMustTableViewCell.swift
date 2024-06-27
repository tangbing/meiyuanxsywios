//
//  TBPicLocationBuyMustTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/17.
//

import UIKit

class TBPicLocationBuyMustTableViewCell: XSBaseTableViewCell {

   
    
    var infoModel: TBShopInfoBuyMustKnowModel? {
        didSet {
            guard let model = infoModel else {
                return
            }
            
            self.titleLab.text = model.titleText
            
            self.iconView.image = UIImage(named: model.contentIcon)
            if let content = model.contentText {
                self.contentLabel.text = content
            } else {
                contentLabel.snp.remakeConstraints({ make in
                    make.left.equalTo(titleLab)
                    make.top.equalTo(titleLab.snp_bottom).offset(0)
                    make.bottom.equalToSuperview().offset(0)
                    make.height.equalTo(0)
                    make.right.equalToSuperview().offset(-22)
                })
            }
           

            if model.hasTopRadius {
                containView.hg_setCornerOnTopWithRadius(radius: 10)
            }else {
                containView.hg_setCornerOnTopWithRadius(radius: 0)
            }
        }
    }
    
    lazy var containView: UIView = {
        let contain = UIView()
        contain.backgroundColor = .white
        return contain
    }()
    
    lazy var iconView: UIImageView = {
        let icon = UIImageView()
        return icon
    }()
    
    //有效期
    lazy var titleLab : UILabel={
        let nameLab = UILabel()
        nameLab.numberOfLines = 1
        nameLab.font = MYBlodFont(size: 14)
        nameLab.textColor = .text
        return nameLab
    }()
    
    lazy var contentLabel: UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.textColor = .twoText
        lab.font = MYFont(size: 12)
        return lab
    }()
    
    
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .clear

        
        self.contentView.addSubview(containView)
        containView.snp_makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        containView.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 22, height: 22))
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(13)
        }
        
        containView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp_right).offset(5)
            make.centerY.equalTo(iconView)
        }
        
        containView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLab)
            make.top.equalTo(titleLab.snp_bottom).offset(8)
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(-22)
        }
        
        
    }


}
