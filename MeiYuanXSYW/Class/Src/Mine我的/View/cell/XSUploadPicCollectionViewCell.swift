//
//  XSUploadPicCollectionViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/10.
//

import UIKit

protocol XSUploadPicCollectionViewCellDeleDelegate: NSObjectProtocol {
    func deleteIndexOfPic(idx: NSInteger)
}

class XSUploadPicCollectionViewCell: XSBaseXIBCollectionViewCell {
    weak var delegate : XSUploadPicCollectionViewCellDeleDelegate?
    
    @IBOutlet weak var picImagView: UIImageView!
    @IBOutlet weak var msgLabel: UILabel!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var tagIdx: Int = 0 {
        didSet {
            deleteButton.tag = tagIdx
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func deleteButtonClick(_ sender: UIButton) {
        delegate?.deleteIndexOfPic(idx: sender.tag)
    }
    

}
