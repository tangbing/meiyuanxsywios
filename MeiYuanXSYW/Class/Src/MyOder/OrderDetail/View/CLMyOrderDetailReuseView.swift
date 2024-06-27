//
//  CLMyOrderDetailReuseView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/24.
//

import UIKit

class CLMyOrderDetailReuseView: TBBaseView {
    
    let label = UILabel().then{
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let desLabel = UILabel().then{
        $0.textColor = .twoText
        $0.font = MYFont(size: 12)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }

    
    public func setting(_ title:String ,_ desTitle:String, _ hideLine:Bool){
        self.label.text = title
        self.desLabel.text  = desTitle
        if hideLine == true {
            self.line.isHidden = true
        }

    }
    
    override func configUI() {
        self.addSubviews(views: [line,label,desLabel])
        line.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        desLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

}
