//
//  CLMyOrderAddressSelectButtonCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/29.
//

import UIKit

class CLMyOrderAddressSelectButtonCell:XSBaseTableViewCell
{
    
    let addButton = UIButton().then{
        $0.setTitle("新增地址", for: .normal)
        $0.setTitleColor(.king, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.king.cgColor
        $0.layer.cornerRadius = 22

    }
    
    let doneButton = UIButton().then{
        $0.setTitle("确定，下一步", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func configUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(addButton)
        contentView.addSubview(doneButton)
        
        addButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(165)
            make.height.equalTo(44)
        }
        
        doneButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(165)
            make.height.equalTo(44)
        }
        
    }

}
