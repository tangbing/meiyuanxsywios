//
//  XSQuestSelectTypeTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/10.
//

import UIKit

class XSQuestSelectTypeTableViewCell: XSBaseXIBTableViewCell {
    
    
    @IBOutlet weak var selectStateBtn: UIButton!
    @IBOutlet weak var selectTypeNameLabel: UILabel!
    
    var merchantFeedBackModel: FeedbackModel? {
        didSet {
            guard let model = merchantFeedBackModel else {
                return
            }
            selectTypeNameLabel.text = model.title
            selectStateBtn.isSelected = model.isSelect
        }
    }
    
    var feedBackModel: XSFeedbackTypeListModel? {
        didSet {
            guard let model = feedBackModel else {
                return
            }
            selectTypeNameLabel.text = model.describes
            selectStateBtn.isSelected = model.isSelect
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
