//
//  XSMineOrderCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
/// 添加cell点击代理方法
protocol XSMineOrderCellDelegate:NSObjectProtocol {
    func clickAllOrder()
}

class XSMineOrderCell: XSBaseTableViewCell {
    weak var delegate : XSMineOrderCellDelegate?

    var backView : UIView={
        let backView = UIView()
        backView.backgroundColor = .white
        return backView
    }()
    var tipLab : UILabel={
        let tipLab = UILabel()
        tipLab.font = MYBlodFont(size: 16)
        tipLab.textColor = .text
        return tipLab
    }()
    var arrowBtn : QMUIButton = {
        let arrowBtn = QMUIButton()
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("全部订单", for: UIControl.State.normal)
        arrowBtn.setImage(UIImage(named: "mine_arrow"), for: UIControl.State.normal)
        arrowBtn.setTitleColor(.twoText, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYFont(size: 13)
        arrowBtn.addTarget(self, action: #selector(clickAllOrderAction), for: .touchUpInside)

        return arrowBtn
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
        backView.addSubview(tipLab)
        tipLab.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(15)
        }
        backView.addSubview(arrowBtn)
        arrowBtn.snp.makeConstraints { make in
            make.centerY.equalTo(tipLab.snp_centerY)
            make.right.equalTo(-8)
        }


    }


    
}
