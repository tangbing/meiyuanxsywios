//
//  XSVipMoreCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
/// 添加cell点击代理方法
protocol XSVipMoreCellDelegate:NSObjectProtocol {
    func clickAllOrder()
}

class XSVipMoreCell: XSBaseTableViewCell {
    weak var delegate : XSVipMoreCellDelegate?

    var backView : UIView={
        let backView = UIView()
        backView.backgroundColor = .white
        return backView
    }()

    var arrowBtn : QMUIButton = {
        let arrowBtn = QMUIButton()
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("查看更多", for: UIControl.State.normal)
        arrowBtn.setImage(UIImage(named: "vip_more"), for: UIControl.State.normal)
        arrowBtn.setTitleColor(.twoText, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYFont(size: 13)
        arrowBtn.addTarget(self, action: #selector(clickMoreAction), for: .touchUpInside)

        return arrowBtn
    }()

    @objc func clickMoreAction() {
        delegate?.clickAllOrder()
    }
    
    var dataSource = [Any]()
    
    override func configUI() {
        contentView.backgroundColor = .background
        contentView.addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-10)
        }

        backView.addSubview(arrowBtn)
        arrowBtn.snp.makeConstraints { make in
            make.left.top.right.equalTo(0)
            make.bottom.equalTo(-14)
        }

    }


    
}
