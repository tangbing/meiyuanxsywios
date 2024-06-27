//
//  TBStandardButton.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/11.
//

import UIKit

class TBStandardButton: UIButton {

    lazy var leftLabel: UILabel = {
        let left = UILabel()
        left.textColor = .text
        left.textAlignment = .center
        left.text = "大"
        left.font = MYFont(size: 14)
        return left
    }()
    
    lazy var rightLabel: UILabel = {
        let right = UILabel()
        right.text = "28.5"
        right.textAlignment = .center
        right.textColor = .text
        right.font = MYFont(size: 14)
        return right
    }()
    
    lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.hex(hexString: "#B3B3B3")
        return line
    }()

    var isHasLeftRihtLabel: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(_ isHasLeftRihtLabel : Bool) {
        self.isHasLeftRihtLabel = isHasLeftRihtLabel
        
        hg_setAllCornerWithCornerRadius(radius: 16)
        jk.addBorder(borderWidth: 1.0, borderColor: UIColor.hex(hexString: "#B3B3B3"))

        if isHasLeftRihtLabel {
            self.addSubview(line)
            line.snp.makeConstraints { make in
                make.width.equalTo(1)
                make.top.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
            }
            
            
            self.addSubview(leftLabel)
            leftLabel.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(17)
                make.right.equalTo(line.snp_left).offset(-17)
                make.centerY.equalToSuperview()
            }
            
            self.addSubview(rightLabel)
            rightLabel.snp.makeConstraints { make in
                make.right.equalToSuperview().offset(-6)
                make.left.equalTo(line.snp_right).offset(6)
                make.centerY.equalToSuperview()
            }
        }
        

        
    }
    
    override var isSelected: Bool {
        didSet {
            
            if isHasLeftRihtLabel {
                if isSelected {
                    leftLabel.textColor = .king
                    rightLabel.textColor = UIColor.hex(hexString: "#E61016")
                    self.backgroundColor(UIColor(r: 252, g: 242, b: 230, a: 1.0))
                    //jk.addBorder(borderWidth: 1.0, borderColor: UIColor.hex(hexString: "#979797"))
                    line.backgroundColor = .king
                    jk.addBorder(borderWidth: 1.0, borderColor: UIColor.king)

                } else {
                    leftLabel.textColor = .twoText
                    rightLabel.textColor = .twoText
                    self.backgroundColor(UIColor.white)
                    //jk.addBorder(borderWidth: 1.0, borderColor: UIColor.hex(hexString: "#B3B3B3"))
                    line.backgroundColor = UIColor.hex(hexString: "#B3B3B3")
                    jk.addBorder(borderWidth: 1.0, borderColor: UIColor.hex(hexString: "#979797"))

                }
            }
        }
      
    }

}
