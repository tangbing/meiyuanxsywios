//
//  CLMyOrderCommentFinishButtonCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/9.
//

import UIKit

class CLMyOrderCommentFinishButtonCell:XSBaseTableViewCell{
    
    var clickBlock:(()->())?

    @objc func click(){
        guard let action = clickBlock else { return }
        action()
    }
    
    let commitButton = UIButton().then{
        $0.setTitle("分享我的评价", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
        $0.setBackgroundImage(UIImage(named: "btnBackImg"), for: .normal)
        $0.addTarget(self, action: #selector(click), for: .touchUpInside)
            
    }

    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(commitButton)
        
        
        commitButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(35)
            make.height.equalTo(44)
        }
        
    }

}
