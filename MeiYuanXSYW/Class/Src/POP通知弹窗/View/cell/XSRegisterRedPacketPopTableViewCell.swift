//
//  XSRegisterRedPacketPopTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/8.
//

import UIKit

class XSRegisterRedPacketPopTableViewCell: XSBaseTableViewCell {

    lazy var backView: UIView = {
        let backV = UIView()
        backV.backgroundColor = .red
        return backV
    }()
    
    lazy var bgimageContainer: UIImageView = {
        let bg = UIImageView()
        bg.contentMode = .scaleAspectFit
        bg.image = UIImage(named: "register_redpacket_cell_bg")
        return bg
    }()
    
    lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.textColor = .text
        name.font = MYBlodFont(size: 16)
        name.text = "满100元可用"
        return name
    }()
    
    lazy var ruleLabel: UILabel = {
        let rule = UILabel()
        rule.textColor = UIColor.hex(hexString: "#979797")
        rule.font = MYFont(size: 12)
        rule.text = "仅莱斯加粉指定商品可用"
        return rule
    }()
    
    lazy var priceLabel: UILabel = {
        let priceLab = UILabel()
        priceLab.textColor = UIColor.hex(hexString: "#E61016")
        priceLab.font = MYBlodFont(size: 16)
        priceLab.text = "¥10"
        priceLab.jk.setsetSpecificTextFont("10", font:MYBlodFont(size: 30))
//        priceLab.jk.setSpecificTextColor("8", color: .red)
//        priceLab.jk.setSpecificTextColor("¥", color: .red)
        return priceLab
    }()
    
    
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .clear
        //self.backgroundView?
        
        self.contentView.addSubview(bgimageContainer)
        bgimageContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgimageContainer.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22)
            make.centerY.equalToSuperview()
        }
        
        bgimageContainer.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(priceLabel.snp_right).offset(40)
            make.top.equalToSuperview().offset(22)
        }
        
        bgimageContainer.addSubview(ruleLabel)
        ruleLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottom).offset(5)
        }
        
        
    }

}
