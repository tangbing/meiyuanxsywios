//
//  TBBottomMsgView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/9.
//

import UIKit

class TBBottomMsgView: UIView {

    var msgText: String = ""
    
    lazy var msgLabel: UILabel = {
        let msg = UILabel()
        msg.font = MYFont(size: 16)
        msg.textColor = .white
        return msg
    }()
    
    
    init(msgText: String) {
        self.msgText = msgText
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.backgroundColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.6)
        self.addSubview(msgLabel)
        msgLabel.text = msgText
        msgLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
