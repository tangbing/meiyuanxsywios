//
//  XSNomalCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/1.
//

import UIKit
class XSNomalCell: XSBaseTableViewCell {
    var leftView : UIStackView={
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.spacing = 4
//        view.distribution = .fillEqually
        return view
    }()
    
    var iconImg : UIImageView={
        let img = UIImageView()
        return img
    }()

    var titleView : UIStackView={
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 4
        return view
    }()

    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 14)
        lab.textColor = .text
        lab.text = .placeholder
        return lab
    }()
    
    var subLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .twoText
        lab.text = .placeholder
        return lab
    }()

    var desLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .twoText
        lab.text = .placeholder
        return lab
    }()

    var arrowImg : UIImageView={
        let img = UIImageView()
        img.image = UIImage(named: "vip_buy_envelope_icon")
        return img
    }()

    override func configUI() {
        super.configUI()
        contentView.addSubview(leftView)
        leftView.snp_makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
        
        leftView.addArrangedSubview(iconImg)
        iconImg.snp_makeConstraints { make in
            make.width.height.equalTo(16)
        }
        
        titleView.addArrangedSubview(tipLab)
        titleView.addArrangedSubview(subLab)

        leftView.addArrangedSubview(titleView)

        contentView.addSubview(arrowImg)
        arrowImg.snp_makeConstraints { make in
            make.right.equalTo(-10)
            make.width.height.equalTo(16)
            make.centerY.equalToSuperview()
        }
        contentView.addSubview(desLab)
        desLab.snp_makeConstraints { make in
            make.right.equalTo(arrowImg.snp_left).offset(-4)
            make.centerY.equalToSuperview()
        }

    }
}
