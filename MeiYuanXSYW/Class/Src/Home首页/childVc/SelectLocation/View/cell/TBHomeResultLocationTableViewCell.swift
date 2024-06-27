//
//  TBHomeResultLocationTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/19.
//

import UIKit

class TBHomeResultLocationTableViewCell: XSBaseXIBTableViewCell {

    @IBOutlet weak var distanceLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var detailAddressLab: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
