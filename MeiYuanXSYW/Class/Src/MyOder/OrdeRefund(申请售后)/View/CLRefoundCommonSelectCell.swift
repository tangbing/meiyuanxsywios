//
//  CLRefoundCommonSelectCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit

class CLRefoundCommonSelectCell: XSBaseTableViewCell {
    
    var model : String! {
        didSet{
            self.lable.text = model
        }
    }
    
    let selectedView = UIImageView().then{
        $0.image = UIImage(named: "mine_tick_normal")
    }
    
    let lable = UILabel().then{
        $0.text = "计划有变,没时间消费"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    var select: Bool = false{
        didSet{
            if select == true {
                self.selectedView.image = UIImage(named: "mine_tick_selected")
            }else{
                self.selectedView.image = UIImage(named: "mine_tick_normal")
            }
        }
    }
    
    override func configUI() {
        
        self.contentView.addSubviews(views: [lable,selectedView])
        
        
        selectedView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(22)
            make.height.equalTo(22)
        }
        
        lable.snp.makeConstraints { (make) in
            make.left.equalTo(selectedView.snp.right).offset(8)
            make.centerY.equalTo(selectedView.snp.centerY)
        }
        

        
    }

}
