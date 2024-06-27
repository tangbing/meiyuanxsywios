//
//  XSBaseXIBTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2021/9/12.
//

import UIKit
import Reusable

class XSBaseXIBTableViewCell: UITableViewCell,NibReusable {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configUI()
    }
    
    func configUI() {
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
