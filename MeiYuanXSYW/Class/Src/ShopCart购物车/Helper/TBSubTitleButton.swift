//
//  TBMultRowButton.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/23.
//

import Foundation
import UIKit


class TBSubTitleButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.titleLabel?.textAlignment = .center
        adddSubTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let margin: CGFloat = 4
    
    private lazy var subTitleLab: UILabel = {
        let lab = UILabel()
        lab.textAlignment = .center
        lab.font = .systemFont(ofSize: 12)
        lab.textColor = .white
        lab.isHidden = true
        return lab
    }()
    
    var subTitleText: String? {
        didSet {
            guard let subTitle = subTitleText else {
                subTitleLab.isHidden = true
                subTitleLab.text = ""
                setupLayout()
                return
            }
            subTitleLab.isHidden = false
            subTitleLab.text = subTitle
            setupLayout()
        }
    }
    
    func adddSubTitleLabel(){
        self.addSubview(subTitleLab)
    }
    
    func setSubTitleColor(_ color: UIColor?) {
        guard let color = color else { return }
        subTitleLab.textColor = color
    }
    
    func setSubTitleFont(_ font: UIFont?) {
        guard let font = font else { return }
        subTitleLab.font = font
    }
    

    func setupLayout(){
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if subTitleLab.isHidden {
            return
        }
        
        self.titleLabel?.tb_x = 0
        self.titleLabel?.tb_y = margin
        self.titleLabel?.tb_width = self.tb_width
        self.titleLabel?.tb_height = self.tb_height * 0.5
        //print("title:\(self.titleLabel?.frame)")
        
        
        
        self.subTitleLab.tb_y = self.titleLabel!.tb_bottom
        self.subTitleLab.tb_width = self.tb_width
        self.subTitleLab.tb_height = self.tb_height - self.subTitleLab.tb_y
        
        //print("subtitleLab:\(self.subTitleLab.frame)")
    }
}
