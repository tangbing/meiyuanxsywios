//
//  TBDeliverHeaderHotSearchTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/22.
//

import UIKit
import QMUIKit


class TBDeliverHeaderHotSearchTableViewCell: XSBaseTableViewCell {

    lazy var hotTitlabel: UILabel = {
        let lb = UILabel()
        lb.text = "热搜："
        lb.textColor = .text
        lb.font = MYFont(size: 10)
        return lb
    }()
    
    lazy var scroll: UIScrollView = {
        let iv = UIScrollView()
        iv.backgroundColor = .clear
        iv.showsVerticalScrollIndicator = false
        iv.showsHorizontalScrollIndicator = false
        iv.bounces = false
        return iv
    }()
    
    var lastHotBtn: QMUIButton?

    var delieveHotBtnClick: ((String) -> Void)?
    
    var recommands: [String]? {
        didSet {
            guard let command = recommands else {
                return
            }
            setupScrollView()
        }
    }
    
    override func configUI() {
        self.backgroundColor = .clear
        
       
    }
    
    private func setupScrollView(){
        
        lastHotBtn = nil
        self.contentView.clearAll()
        
        
        self.contentView.addSubview(hotTitlabel)
        hotTitlabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(scroll)
        scroll.snp.makeConstraints { make in
            make.left.equalTo(hotTitlabel.snp_right).offset(0)
            make.top.bottom.right.equalToSuperview()
        }
        
        let containerView = UIView()
        scroll.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        for i in 0..<(recommands?.count ?? 0) {
            let hotBtn = QMUIButton(type: .custom)
            hotBtn.setTitle(recommands?[i], for: .normal)
            hotBtn.backgroundColor = UIColor.hex(hexString: "#ECECEC")
            hotBtn.setTitleColor(UIColor.text, for: .normal)
            hotBtn.titleLabel?.font = MYFont(size: 10)
            containerView.addSubview(hotBtn)
            hotBtn.sizeToFit()
            hotBtn.contentEdgeInsets = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
            hotBtn.addTarget(self, action: #selector(hotBtnClick(hotBtn:)), for: .touchUpInside)
            hotBtn.hg_setAllCornerWithCornerRadius(radius: 8)
            hotBtn.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.left.equalTo(lastHotBtn != nil ? lastHotBtn!.snp_right : containerView.snp_left).offset(4)
            }
            lastHotBtn = hotBtn
        }
        
        if lastHotBtn != nil {
            containerView.snp.makeConstraints { make in
                make.right.equalTo(lastHotBtn!.snp_right).offset(10)
            }
        }
       
    }
    
    @objc func hotBtnClick(hotBtn: QMUIButton) {
        delieveHotBtnClick?(hotBtn.currentTitle ?? "")
    }

}
