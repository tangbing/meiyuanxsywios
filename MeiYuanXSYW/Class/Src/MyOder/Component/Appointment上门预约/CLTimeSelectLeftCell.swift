//
//  CLTimeSelectLeftCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/26.
//

import UIKit

class CLTimeSelectLeftCell: XSBaseTableViewCell {
    
    var model:String!{
        didSet{
            lable.text = model
        }
        
    }
    
    let lable = UILabel().then{
        $0.text = "准确重量单位"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        
        if selected == true {
            self.contentView.backgroundColor = .white
        }else{
            self.contentView.backgroundColor = .lightBackground
        }
    }
    
    
    override func configUI() {
        
        self.contentView.addSubview(lable)
        self.contentView.backgroundColor = .lightBackground
        
        self.selectionStyle = .none
        
        lable.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
    }
    
}
