//
//  CLOrderSubmitNoteView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/10.
//

import UIKit

class CLOrderSubmitNoteView: TBBaseView {
    var closeBlock:(()->())?
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.hg_setAllCornerWithCornerRadius(radius: 16)
    }
    
    let title = UILabel().then{
        $0.text = "内容"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
        $0.numberOfLines = 0
    }
    
    let close = UIButton().then{
        $0.isHidden = true
        $0.setImage(UIImage(named: "icon_delete1"), for: .normal)
        $0.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
    }
    @objc func deleteAction(){
        guard let action = closeBlock else { return }
        action()
    }
    
    override func configUI() {
        self.addSubview(baseView)
        self.addSubview(close)
        baseView.addSubview(title)
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        close.snp.makeConstraints { make in
            make.right.top.equalToSuperview()
            make.height.width.equalTo(20)
        }
        
    }
}
