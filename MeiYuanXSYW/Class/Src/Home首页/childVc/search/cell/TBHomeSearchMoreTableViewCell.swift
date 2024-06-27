//
//  TBHomeSearchMoreTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/13.
//

import UIKit
import QMUIKit

class TBHomeSearchMoreTableViewCell: XSBaseTableViewCell {

    //进店
    lazy var addBtn : QMUIButton = {
        let arrowBtn = QMUIButton(type: .custom)
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("查看更多商家", for: UIControl.State.normal)
        arrowBtn.setTitleColor(.text, for: UIControl.State.normal)
        arrowBtn.setImage(UIImage(named: "home_search_more_arrow_right"), for: .normal)
        arrowBtn.titleLabel?.font = MYFont(size: 14)
        arrowBtn.addTarget(self, action: #selector(clickMoreAction), for: .touchUpInside)
        return arrowBtn
    }()
    
    override func configUI() {
        self.contentView.addSubview(addBtn)
        addBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
    @objc func clickMoreAction(){
        
    }

    
}
