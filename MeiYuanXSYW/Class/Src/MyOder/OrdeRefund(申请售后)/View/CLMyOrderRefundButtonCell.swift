//
//  CLMyOrderRefundButtonCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit

class CLMyOrderRefundButtonCell: XSBaseTableViewCell {
    
    var click:(()->())?

    let commitButton = UIButton().then{
        $0.setTitle("提交评价", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.hg_setAllCornerWithCornerRadius(radius: 22)
        $0.setBackgroundImage(UIImage(named: "cartBackImg"), for: .normal)
        $0.setBackgroundImage(UIColor.borad.image(), for: .disabled)
//        $0.isEnabled = false
        $0.addTarget(self, action: #selector(upload), for: .touchUpInside)
    }
    
    @objc func upload(){
        guard let action = click else { return }
        action()
    }

    override func configUI() {
        super.configUI()
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(commitButton)
        
        commitButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
    }

}
