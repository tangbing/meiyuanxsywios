//
//  XSDiscoverTopTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/2.
//

import UIKit
import QMUIKit

class XSDiscoverTopStackSubView: TBBaseView {
    
    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        iv.isUserInteractionEnabled = true
        //iv.contentMode = .scaleToFill
        iv.hg_setAllCornerWithCornerRadius(radius: 4)
        iv.image = UIImage(named: "group buy_picture4")
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "分享\n最好蛋挞"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = MYFont(size: 12)
        return label
    }()
    
    lazy var seeNumAll: QMUIButton = {
        let see = QMUIButton(type: .custom)
        see.contentHorizontalAlignment = .right
        see.setImage(UIImage(named: "discover_top_look"), for: .normal)
        see.setTitle("4,836", for: .normal)
        see.spacingBetweenImageAndTitle = 0
        see.setTitleColor(.white, for: .normal)
        see.titleLabel?.font = MYBlodFont(size: 9)
        //all.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
        return see
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let colors = [UIColor.hexStringColor(hexString: "#000000", alpha: 0.24),
                      UIColor.hexStringColor(hexString: "#000000", alpha: 0.45)]
        nameLabel.hg_addGradientColor(colors, size: nameLabel.tb_size, startPoint: CGPoint(x: 1.02, y: 0.5), endPoint: CGPoint(x: 0.5, y: 0.5))
    }
    
    
    override func configUI() {
        super.configUI()
        self.addSubview(merchIcon)
        merchIcon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.addSubview(seeNumAll)
        seeNumAll.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(60)
            make.height.equalTo(16)
        }
        
    }
}

class XSDiscoverTopTableViewCell: XSBaseTableViewCell {

    lazy var stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        /// 子视图填充StackView。
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    override func configUI() {
        super.configUI()
        self.contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.top.equalToSuperview()
            make.height.equalTo(82)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        for _ in 0..<3 {
            let container = XSDiscoverTopStackSubView()
            stackView.addArrangedSubview(container)
        }
        
        
    }

}
