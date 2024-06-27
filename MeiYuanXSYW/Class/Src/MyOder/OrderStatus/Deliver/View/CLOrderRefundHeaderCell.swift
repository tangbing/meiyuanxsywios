//
//  CLOrderRefundHeaderCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/28.
//

import UIKit

class CLOrderRefundHeaderCell: XSBaseTableViewCell {
    
    var select: Bool = false{
        didSet{
            if select == true {
                selectedView.setImage(UIImage(named: "mine_tick_selected"), for: .normal)
            }else{
                selectedView.setImage(UIImage(named: "mine_tick_normal"), for: .normal)
            }
        }
    }
    
    let baseview = UIView().then{
        $0.backgroundColor = .white
        $0.isUserInteractionEnabled = true

    }
    
    let selectedView = UIButton().then{
        $0.setImage(UIImage(named:"mine_tick_normal"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    
    let shopName = UILabel().then{
        $0.text = "BBBB商家"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)

    }
    
    
    override func configUI() {
        
        self.contentView.backgroundColor = .lightBackground
        self.selectionStyle = .none
        self.contentView.addSubview(baseview)
        baseview.addSubviews(views: [selectedView,shopName,line])
        
        baseview.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        selectedView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(9)
            make.top.equalToSuperview()
            make.width.height.equalTo(22)
        }
        shopName.snp.makeConstraints { make in
            make.left.equalTo(selectedView.snp.right).offset(10)
            make.centerY.equalTo(selectedView.snp.centerY)
        }
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
