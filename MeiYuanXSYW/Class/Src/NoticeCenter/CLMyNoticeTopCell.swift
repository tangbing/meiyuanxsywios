//
//  CLMyNoticeTopCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/16.
//

import UIKit
import QMUIKit

class CLMyNoticeTopCell: XSBaseTableViewCell {
    
    var clickBlock:((_ para:Int)->())?
    
    @objc func click(sender:UIButton){
        guard let action = clickBlock else { return }
        action(sender.tag)
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.hg_setAllCornerWithCornerRadius(radius: 10)
    }
    
    let imageArray = ["service","notify","activity","information","cus_service"]
    
    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.bottom.right.equalToSuperview().offset(-10)
        }
        
        for i in 0 ... 4 {
            let button = QMUIButton(type: .custom)
            button.setTitle("服务消息", for: .normal)
            button.setTitleColor(.text, for: .normal)
            button.titleLabel?.font = MYFont(size: 12)
            button.setImage(UIImage(named: imageArray[i]), for: .normal)
            button.imagePosition = .top
            button.spacingBetweenImageAndTitle = 7
            button.addTarget(self, action: #selector(click(sender:)), for: .touchUpInside)
            button.tag = i
            baseView.addSubview(button)
            
            let width = (screenWidth - 20)/5
            button.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(16)
                make.bottom.equalToSuperview().offset(-16)
                make.left.equalToSuperview().offset(width * CGFloat(i))
                make.width.equalTo(width)
            }
        }
        
    }
}
