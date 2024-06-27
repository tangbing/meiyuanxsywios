//
//  TBMerchInfoCompainTextViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/10.
//

import UIKit
import QMUIKit


class TBMerchInfoCompainTextViewCell: XSBaseXIBTableViewCell {

    var textViewDidChange: ((_ cell: TBMerchInfoCompainTextViewCell) -> Void)?
    
    @IBOutlet weak var textView: QMUITextView!
    @IBOutlet weak var limitLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .background
        containerView.hg_setAllCornerWithCornerRadius(radius: 10)
    }
}

extension TBMerchInfoCompainTextViewCell: QMUITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        //uLog(textView.text)
        let textLength = textView.text.qmui_lengthWhenCountingNonASCIICharacterAsTwo
        //uLog(textView.text + "size:\(textLength)")
        limitLabel.text = "\(textLength)/200"
        
        if textLength <= 200 {
            textViewDidChange?(self)
        }
        
    }
}
