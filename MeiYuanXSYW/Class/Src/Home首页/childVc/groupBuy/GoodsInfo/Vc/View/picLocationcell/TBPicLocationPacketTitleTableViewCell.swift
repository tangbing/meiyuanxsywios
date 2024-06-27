//
//  TBPicLocationPacketTitleTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/17.
//

import UIKit

class TBPicLocationPacketTitleTableViewCell: XSBaseTableViewCell {
    
    
    var infoModel: TBShopInfoPacketDetailInfoTitleModel? {
        didSet {
            guard let model = infoModel else {
                return
            }
            
            self.titleLab.text = model.nameTitleText
            self.titleLab.font = model.nameTitleFont
            

            /// 这里给分组设置圆角，是分别给第一个的cell设置顶部圆角，最后一个cell设置底部圆角
            /// 但这里，同时设置，不生效，故要这样设置
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if model.hasTopRadius {
                    self.containView.jk.addCorner(conrners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius: 10)
                    //self.containView.hg_setCornerOnTopWithRadius(radius: 10)
                } else {
                    self.containView.jk.addCorner(conrners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius: 0)
                   // self.containView.hg_setCornerOnTopWithRadius(radius: 0)
                }
            }

            if model.hasBottomRadus {
                self.containView.hg_setCornerOnBottomWithRadius(radius: 10)
            }
            else {
                self.containView.hg_setCornerOnBottomWithRadius(radius: 0)
            }
        }
    }

    lazy var containView: UIView = {
        let contain = UIView()
        contain.backgroundColor = .white
        return contain
    }()
    
    lazy var dian: UILabel = {
        let lab = UILabel()
        lab.backgroundColor = .text
        lab.hg_setAllCornerWithCornerRadius(radius: 1.5)
        return lab
    }()
    
    //招牌推荐
    lazy var titleLab : UILabel={
        let nameLab = UILabel()
        nameLab.numberOfLines = 0
        nameLab.font = MYBlodFont(size: 16)
        nameLab.textColor = .text
        let str = "招牌推荐"
        nameLab.text = str
        return nameLab
    }()
    
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(containView)
        containView.snp_makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        containView.addSubview(dian)
        dian.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(23)
            make.size.equalTo(CGSize(width: 3, height: 3))
        }
        
        containView.addSubview(titleLab)
        titleLab.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(dian.snp_right).offset(5)
            make.right.equalToSuperview().offset(-22)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        
    }
   

}
