//
//  XSCalendarCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/17.
//

import UIKit

class XSCalendarCell: XSBaseXIBCollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var numLab: UILabel!
    
    var dataModel: XSFootMarkModel? {
        didSet {
            guard let model = dataModel else {
                return
            }
            bgView.backgroundColor = model.isSelect ? UIColor.tag : .clear
            numLab.textColor = model.isSelect ? UIColor.white : UIColor.text

            numLab.text = "\(model.cmps?.day ?? 0)"
            
            if !model.isCurrentDate {
                numLab.textColor = .threeText
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
