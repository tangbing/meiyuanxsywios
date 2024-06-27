//
//  TBPicLocationPacketContentTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/17.
//

import UIKit

class TBPicLocationPacketContentTableViewCell: XSBaseTableViewCell {
    
   
    
    var infoModel: TBShopInfoPacketDetailInfoContentModel? {
        didSet {
            guard let model = infoModel else {
                return
            }
            
            self.titleLab.text = model.nameTitleText
            self.numLabel.text = "(\(model.numShop))"
            self.priceLabel.text = model.priceTitleText

            if model.hasTopRadius {
                containView.hg_setCornerOnTopWithRadius(radius: 10)
            } else {
                containView.hg_setCornerOnTopWithRadius(radius: 0)
            }
            
            if model.hasBottomRadus {
                containView.hg_setCornerOnBottomWithRadius(radius: 10)
            } else {
                containView.hg_setCornerOnBottomWithRadius(radius: 0)
            }
        }
    }
    

    lazy var containView: UIView = {
        let contain = UIView()
        contain.backgroundColor = .white
        return contain
    }()
    
   
    
    //招牌推荐
    lazy var titleLab : UILabel={
        let nameLab = UILabel()
        nameLab.numberOfLines = 1
        nameLab.font = MYFont(size: 12)
        nameLab.textColor = .text
        let str = "招牌推荐"
        nameLab.text = str
        return nameLab
    }()
    
    lazy var numLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .twoText
        lab.font = MYFont(size: 12)
        return lab
    }()
    
    lazy var priceLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = .text
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
        
        containView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        containView.addSubview(numLabel)
        numLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(titleLab.snp_right).offset(5)
        }
        
        containView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        
        
    }

}
