//
//  TBHomeSelectLocationTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/19.
//

import UIKit

class TBHomeSelectLocationTableViewCell: XSBaseXIBTableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var detailAddressLab: UILabel!
    @IBOutlet weak var userInfoLab: UILabel!
    
    
    var model:CLReceiverAddressModel? {
        didSet{
            guard let model = model else { return }
            
            detailAddressLab.text = model.receiverDetailAddress
            
            let sexStr = model.receiverSex == 0 ? "女士" : "男士"
            userInfoLab.text = "\(model.receiverName) \(sexStr) \(model.receiverPhone)"

        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
