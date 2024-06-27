//
//  CLUpgradeMemberHeadCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/10.
//

import UIKit

class CLUpgradeMemberHeadCell: XSBaseTableViewCell {
    
    func setting(_ title:String,_ color:UIColor){
        self.title.text = title
        self.title.textColor = color
    }
    
    let title = UILabel().then{
        $0.text = "可使用红包"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
        }
    }
}
