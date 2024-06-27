//
//  CLOrderSubmitDeliverMarkCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/7.
//

import UIKit
import QMUIKit

class CLOrderSubmitDeliverMarkCell: XSBaseTableViewCell {
        
    var height = 62
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let label = UILabel().then{
        $0.text = "备注"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let des = UILabel().then{
        $0.text = "推荐使用无接触配送"
        $0.textColor = .twoText
        $0.font = MYFont(size: 14)
        $0.textAlignment = .right
    }
    
    let accessImage = UIImageView().then{
        $0.image = UIImage(named: "mine_arrow")
    }

    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        baseView.hg_setCorner(conrner: QMUICornerMask.layerAllCorner, radius: 10)
        
        baseView.addSubviews(views: [label,des,accessImage])
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        accessImage.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        
        des.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right).offset(20)
            make.right.equalTo(accessImage.snp.left).offset(-5)
            make.centerY.equalToSuperview()
        }
    }
}
