//
//  XSMineEvaluateTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/13.
//

import UIKit


protocol XSMineEvaluateTableViewCellDelegate: NSObjectProtocol {
    func deleteBtnClick(in cell: XSMineEvaluateTableViewCell)
    func editBtnClick(in cell: XSMineEvaluateTableViewCell)
    func shareBtnClick(in cell: XSMineEvaluateTableViewCell)

}

class XSMineEvaluateTableViewCell: XSBaseXIBTableViewCell {
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var picView: UIView!
    
    @IBOutlet weak var contenView: UIView!
    @IBOutlet weak var picViewHConstraint: NSLayoutConstraint!
    @IBOutlet weak var evaluteContentLabel: UILabel!
    
    
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentHConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var repeatView: UIView!
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var picStackView: UIStackView!
    
    @IBOutlet weak var repeatLabel: UILabel!
    @IBOutlet weak var repeatTimeLab: UILabel!

    
    @IBOutlet weak var startView: TBStartView!
    
    @IBOutlet weak var userEvaluateTimeLab: UILabel!
    
    @IBOutlet weak var taskEnvironScoreLab: UILabel!
    
    @IBOutlet weak var merchantInfoView: UIView!
    @IBOutlet weak var merchantLogo: UIImageView!
    @IBOutlet weak var merchantNameLab: UILabel!
    @IBOutlet weak var merchantScoreBtn: UIButton!
    @IBOutlet weak var merchantPerCapitaLab: UILabel!
    @IBOutlet weak var merchantAddressLab: UILabel!
    
    @IBOutlet weak var repeatTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var repeatBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var repeatTimeLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var repeatContentLabelTopConstraint: NSLayoutConstraint!

    @IBOutlet weak var repeatTimeHConstraint: NSLayoutConstraint!
    
    
    weak var delegate: XSMineEvaluateTableViewCellDelegate?
    
    var evaluateModel: CLCommentModel? {
        didSet {
            guard let model = evaluateModel else {
                return
            }
            
            startView.startView(score: model.totalComment)
            
            evaluteContentLabel.text = model.userComment
            if model.commentPic.count != 0 {
                picStackView.isHidden = false
                picViewHConstraint.constant = 75

                for (idex,contentView) in picStackView.subviews.enumerated() {
                    guard let imageView = contentView as? UIImageView else { return }
                    imageView.xs_setImage(urlString: model.commentPicStr[idex])
                }

            } else {
                picStackView.isHidden = true
                picViewHConstraint.constant = 0
            }
           
            
            repeatLabel.text = model.merchantReplyComment
            
            repeatView.isHidden = model.merchantReplyComment.isEmpty
            repeatBottomConstraint.constant = model.merchantReplyComment.isEmpty ? 0 : 15
            repeatTopConstraint.constant = model.merchantReplyComment.isEmpty ? 0 : 10
            repeatContentLabelTopConstraint.constant = model.merchantReplyComment.isEmpty ? 0 : 10
            
            repeatTimeLabelTopConstraint.constant = model.merchantReplyComment.isEmpty ? 0 : 8
            repeatTimeHConstraint.constant = model.merchantReplyComment.isEmpty ? 0 : 15
            
            repeatTimeLab.text = model.merchantReplyDate
            
            
            taskEnvironScoreLab.text = "口味\(model.tasteComment)   环境\(model.environmentComment)"
            userEvaluateTimeLab.text = model.userCommentTime
            
            merchantLogo.xs_setImage(urlString: model.merchantLogo)
            merchantNameLab.text = model.merchantName
            merchantScoreBtn.setTitle("\(model.commentScore)分", for: .normal)
            merchantPerCapitaLab.text = "人均¥\(model.perCapita)"
            merchantAddressLab.text = model.address
            
            
            /// 推荐
//            if model.commendStr != nil {
//                commentLabel.text = model.commendStr
//                commentHConstraint.constant = 38
//                commentView.isHidden = false
//
//            } else {
                commentLabel.text = ""
                commentHConstraint.constant = 0
                commentView.isHidden = true
           // }
            

            
            
        }
    }
    

//    override var frame: CGRect {
//        didSet {
//            var newFrame = frame
//            newFrame.origin.y += 10
//            newFrame.size.height -= 10
//            super.frame = newFrame
//        }
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contenView.hg_setAllCornerWithCornerRadius(radius: 10)
        self.backgroundColor = .clear
        
        editBtn.jk.addBorder(borderWidth: 1, borderColor: UIColor.hex(hexString: "#737373"))
        editBtn.hg_setAllCornerWithCornerRadius(radius: 13.5)
        deleteBtn.hg_setAllCornerWithCornerRadius(radius: 13.5)
        
        
    }
    
    @IBAction func deleteBtnClick(_ sender: UIButton) {
        self.delegate?.deleteBtnClick(in: self)
    }
    
    @IBAction func editBtnClick(_ sender: UIButton) {
        self.delegate?.editBtnClick(in: self)
    }
    
    @IBAction func shareBtnClick(_ sender: UIButton) {
        self.delegate?.shareBtnClick(in: self)
    }
    
   
    
}
