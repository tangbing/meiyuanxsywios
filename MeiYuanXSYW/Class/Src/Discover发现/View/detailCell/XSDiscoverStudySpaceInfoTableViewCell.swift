//
//  XSDiscoverStudySpaceInfoTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit

class XSDiscoverStudySpaceInfoTableViewCell: XSBaseTableViewCell {

    var infoModel: XSStudySpaceInfoModel? {
        didSet {
            guard let model = infoModel else {
                return
            }
            if model.hasTopRadius {
                containerView.hg_setCornerOnBottomWithRadius(radius: 10)
            }
        }
    }
    
    lazy var merchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "康美甄营养餐菜品名称 | 康美甄营养餐菜品名称"
        label.textColor = .text
        label.font = MYBlodFont(size: 16)
        return label
    }()
    
    lazy var timeInfoView: XSDiscoverStudySpaceListInfoView = {
        let infoView = XSDiscoverStudySpaceListInfoView()
        infoView.topicBtn.isHidden = true
        return infoView
    }()
    
    lazy var shopInfoView: XSDiscoverRecommandTopInfoView = {
        let infoView = XSDiscoverRecommandTopInfoView()
        infoView.showTopic()
        return infoView
    }()
    
    lazy var containerView: UIView = {
        let contain = UIView()
        contain.backgroundColor = .white
        return contain
    }()
    

    override func configUI() {
        self.contentView.backgroundColor = .background
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        containerView.addSubview(merchNameLabel)
        merchNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        containerView.addSubview(timeInfoView)
        timeInfoView.snp.makeConstraints { make in
            make.top.equalTo(merchNameLabel.snp_bottom).offset(4)
            make.left.right.equalTo(merchNameLabel)
            make.height.equalTo(22)
        }
        
        containerView.addSubview(shopInfoView)
        shopInfoView.snp.makeConstraints { make in
            make.left.right.equalTo(merchNameLabel)
            make.height.equalTo(54)
            make.top.equalTo(timeInfoView.snp_bottom).offset(4)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }


}
