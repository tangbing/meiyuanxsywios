//
//  CLMyOrderHeadView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/23.
//

import UIKit

class CLMyOrderHeadView: TBBaseView {
    var clickAction : (()->())?
    var pullAction : (()->())?

    
    let back = UIButton().then{
        $0.setImage(UIImage(named: "nav_back_black"), for: .normal)
        $0.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    let searchTextField = TBSearchTextField().then{
        $0.placeholderText = "请输入要查找的订单信息"
    }
    
    let searchButton = UIButton().then{
        $0.setTitle("筛选", for: .normal)
        $0.titleLabel?.font = MYBlodFont(size: 16)
        $0.setTitleColor(UIColor.hex(hexString: "#252525"), for: .normal)
        $0.addTarget(self, action: #selector(pullDown), for: .touchUpInside)
    }

    @objc func pullDown(){
        guard let action = pullAction else {
            return
        }
        action()
    }
    
    @objc func click(){
        guard let action = clickAction else {
            return
        }
        action()
    }
    
    override func configUI() {
        
        self.addSubviews(views: [back,searchTextField,searchButton])
        
        back.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            
        }
        
        searchButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(40)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(back.snp.right)
            make.centerY.equalToSuperview()
            make.right.equalTo(searchButton.snp.left).offset(-27)
            make.height.equalTo(30)
        }

        
    }
    
}
