//
//  XSMineHeaderCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import SwiftUI
/// 添加cell点击代理方法
protocol XSMineHeaderCellDelegate:NSObjectProtocol {
    func clickUser()
}

class XSMineHeaderCell: XSBaseXIBTableViewCell {
    
    
    var userInfoModel: XSMineHomeUserInfoModel? {
        didSet {
            guard let model = userInfoModel else {
                return
            }
            userName.text = model.nickname
            userImg.xs_setImage(urlString: model.headImg)
            vipLab.isHidden = !(model.memberStatus == 1)
            vipView.isHidden = model.mobile.isEmpty
            phoneLab.text = model.mobile

        }
    }
    
    weak var delegate : XSMineHeaderCellDelegate?
    

    @IBOutlet weak var phoneLab: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var vipView: UIView!
    @IBOutlet weak var vipLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.clear
        selectionStyle = .none
        userImg.hg_setAllCornerWithCornerRadius(radius: 25)
        userName.jk.addGestureTap { gesture in
            self.delegate?.clickUser()
        }
        vipLab.textColor = .tag
        vipLab.backgroundColor = .black
        vipLab.hg_setAllCornerWithCornerRadius(radius: 3)
        phoneLab.font = MYFont(size: 13)
        phoneLab.textColor = .twoText
        
        vipView.isHidden = true
        vipLab.isHidden = true
        
    }
    
}
