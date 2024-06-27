//
//  XSVipHistoryCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit

class XSVipHistoryCell: XSBaseTableViewCell {
    
    var model :CLMemberBuyRecordListModel?{
        didSet {
            guard let cellModel = model else { return }
            tipLab.text = cellModel.title
            subLab.text = "有效期：\(cellModel.endTime)"
            timeLab.text = cellModel.createTime
            priceLab.text = "¥" + cellModel.payAmt
            priceLab.jk.setsetSpecificTextFont("¥", font: MYBlodFont(size: 16))
        }
    }
    var backView : UIView={
        let backView = UIView()
        backView.backgroundColor = .white
        backView.hg_setAllCornerWithCornerRadius(radius: 10)
        return backView
    }()

    var tipLab : UILabel={
        let lab = UILabel()
        lab.font = MYBlodFont(size: 15)
        lab.textColor = .text
        lab.text = "续费行膳有味会员月卡"
        return lab
    }()
    
    var subLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .twoText
        lab.text = "有效期：2021.6.20  10:00"
        return lab
    }()

    var timeLab : UILabel={
        let lab = UILabel()
        lab.font = MYFont(size: 12)
        lab.textColor = .twoText
        lab.text = "2021.6.20  10:00"
        return lab
    }()
    var priceLab : UILabel={
        let lab = UILabel()
        lab.font = MYBlodFont(size: 30)
        lab.textColor = .red
        lab.text = "¥6"
        return lab
    }()
    
    override func configUI() {
        contentView.backgroundColor = .background
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.left.top.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(0)
        }
        backView.addSubview(priceLab)
        priceLab.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
        }

        backView.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(12)
        }
        backView.addSubview(subLab)
        subLab.snp.makeConstraints { make in
            make.left.equalTo(tipLab.snp_left)
            make.top.equalTo(tipLab.snp_bottom).offset(6)
        }
        backView.addSubview(timeLab)
        timeLab.snp.makeConstraints { make in
            make.left.equalTo(tipLab.snp_left)
            make.top.equalTo(subLab.snp_bottom).offset(8)
        }

    }


    
}
