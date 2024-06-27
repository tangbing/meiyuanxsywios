//
//  XSHomeHeaderAdvTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/24.
//

import UIKit
import JKSwiftExtension

class XSHomeHeaderAdvTableViewCell: XSBaseXIBTableViewCell {

    var idex: Int = 0
    var signDataArray: [NoticeDetail]? {
        didSet {
            setuptimer()
        }
    }
    
    @IBOutlet weak var publishNoticeLabel: UILabel!
    @IBOutlet weak var publicAdvLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.hg_setAllCornerWithCornerRadius(radius: 5)
    }

    private func setuptimer(){
        let timer = Timer.scheduledTimer(timeInterval: 2.0, target:self , selector: #selector(scroll), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func scroll(){
       
        if idex == (signDataArray?.count ?? 0) {
            idex = 0
        }
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        transition.type = CATransitionType.init(rawValue: "cube")
        transition.subtype = CATransitionSubtype.fromTop
        publishNoticeLabel.layer.add(transition, forKey: nil)

        publishNoticeLabel.text = signDataArray?[idex].title
        
        idex += 1
    }
    
}
