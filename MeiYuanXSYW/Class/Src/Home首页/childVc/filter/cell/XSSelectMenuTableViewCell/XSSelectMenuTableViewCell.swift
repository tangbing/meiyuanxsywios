//
//  XSSelectMenuTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/8.
//

import UIKit

class XSSelectMenuTableViewCell: XSBaseTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.textLabel?.textColor = .tag
            } else {
                self.textLabel?.textColor = .twoText
            }
        }
    }

}
