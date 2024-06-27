//
//  CLOrderSubmitDeliverButtonCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/7.
//

import UIKit
import QMUIKit
import Kingfisher

class CLOrderSubmitDeliverButtonCell: XSBaseTableViewCell {
    
    var clickBlock:((_ tag:Int)->())?
    
    let deliverButton = UIButton().then{
        $0.setTitle("外卖配送", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size:16)
        $0.setBackgroundImage(UIImage(named: "order_bg"), for: .normal)
        $0.tag = 101
        $0.backgroundColor = .white
    }
    
    let takeBySelfButton = UIButton().then{
        $0.setTitle("到店自取", for: .normal)
        $0.setTitleColor(.text, for: .normal)
        $0.titleLabel?.font = MYFont(size:16)
//        $0.setBackgroundImage(UIImage(named: ""), for: .normal)
        $0.tag = 102
        $0.backgroundColor = .white

    }
    
    
    @objc func click(sender:UIButton){
        
        if sender.tag == 101 {
            deliverButton.setBackgroundImage(UIImage(named: "order_bg"), for: .normal)
            deliverButton.setTitleColor(.white, for: .normal)
            
            takeBySelfButton.setBackgroundImage(UIImage(named: ""), for: .normal)
            takeBySelfButton.setTitleColor(.text, for: .normal)
        }else{
            takeBySelfButton.setBackgroundImage(UIImage(named: "order_bg1"), for: .normal)
            takeBySelfButton.setTitleColor(.white, for: .normal)
            
            deliverButton.setBackgroundImage(UIImage(named: ""), for: .normal)
            deliverButton.setTitleColor(.text, for: .normal)
        }
        
        guard let action = self.clickBlock else { return }
        action(sender.tag)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        deliverButton.hg_setCorner(conrner: .layerMinXMinYCorner, radius: 10)
        takeBySelfButton.hg_setCorner(conrner: .layerMaxXMinYCorner, radius: 10)
    }
    
    override func configUI() {
//        super.configUI()
        self.selectionStyle = .none
        contentView.backgroundColor = .lightBackground
        contentView.addSubviews(views: [deliverButton,takeBySelfButton])
        
        deliverButton.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
        takeBySelfButton.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
        
    
        
        deliverButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(screenWidth/2 - 10)
            make.height.equalTo(45)
        }
        
        takeBySelfButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(screenWidth/2 - 10)
            make.height.equalTo(45)
        }
    
    
        
    }
}
