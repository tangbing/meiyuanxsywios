//
//  XSVipSectionCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
/// 添加cell点击代理方法
protocol XSVipSectionCellDelegate:NSObjectProtocol {
    func clickAllOrder()
}

class XSVipSectionCell: XSBaseTableViewCell {
    weak var delegate : XSVipSectionCellDelegate?

    var backView : UIView={
        let backView = UIView()
        backView.backgroundColor = .white
        return backView
    }()
    var tipIcon : UIImageView = {
        let tipIcon = UIImageView()
        tipIcon.image = UIImage(named: "vip_SectionIcon")
        return tipIcon
    }()

    var tipLab : UILabel={
        let tipLab = UILabel()
        tipLab.font = MYBlodFont(size: 16)
        tipLab.textColor = .text
        return tipLab
    }()
    
    
    var subLab : UILabel={
        let subLab = UILabel()
        subLab.font = MYFont(size: 12)
        subLab.textColor = .twoText
        return subLab
    }()

    
    @objc func clickAllOrderAction() {
        delegate?.clickAllOrder()
    }
    
    var dataSource = [Any]()
    
    override func configUI() {
        contentView.backgroundColor = .background
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        backView.addSubview(tipIcon)
        tipIcon.snp.makeConstraints { make in
            make.left.equalTo(10)
        }

        backView.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.left.equalTo(tipIcon.snp_right).offset(4)
            make.top.equalTo(12)
            make.centerY.equalTo(tipIcon)
        }

        backView.addSubview(subLab)
        subLab.snp.makeConstraints { make in
            make.left.equalTo(tipIcon.snp_left)
            make.top.equalTo(tipLab.snp_bottom).offset(6)
        }

    }


    
}
