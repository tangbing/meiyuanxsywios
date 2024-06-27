//
//  CLTimeSelectRightCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/26.
//

import UIKit

class CLTimeSelectRightCell: XSBaseTableViewCell {
    
    
    var model : String! {
        didSet{
            self.lable.text = model
        }
    }
    
    let lable = UILabel().then{
        $0.text = "17:40(可预约)"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let selectedView = UIImageView().then{
        $0.image = UIImage(named: "mine_tick_selected")
        $0.isHidden = true
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        
        if selected == true {
            self.selectedView.isHidden = false
            self.lable.textColor = .king
        }else{
            self.selectedView.isHidden = true
            self.lable.textColor = .text
        }
    }
    
    override func configUI() {
        
        self.contentView.addSubviews(views: [lable,selectedView,line])
        
        lable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        selectedView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(22)
            make.height.equalTo(22)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
    }

}
