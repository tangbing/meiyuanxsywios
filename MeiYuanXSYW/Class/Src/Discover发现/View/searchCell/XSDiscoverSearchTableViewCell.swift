//
//  XSDiscoverSearchTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/3.
//

import UIKit

class XSDiscoverSearchTableViewCell: XSBaseTableViewCell {

    var historyDeleteBtnHandler: ((_ searchText: String) -> Void)?
    
    var searchText: String? {
        didSet {
            guard let text = searchText else {
                return
            }
            self.searchNameLabel.text = text
        }
    }
    
    lazy var searchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "康美甄营养餐菜品名称"
        label.textColor = .twoText
        label.font = MYFont(size: 14)
        return label
    }()
    
    lazy var historyDeleteBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: "discover_search_clear"), for: .normal)
        btn.addTarget(self, action: #selector(historyDeleteBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var line: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: 59, width: screenWidth, height: 1))
        line.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        return line
    }()
    
    override func configUI() {
        super.configUI()
        
        self.contentView.addSubview(line)
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.height.equalTo(1)
            make.right.bottom.equalToSuperview().offset(0)
        }
        
        self.contentView.addSubview(searchNameLabel)
        searchNameLabel.snp.makeConstraints { make in
            make.left.equalTo(line)
            make.centerY.equalToSuperview()
        }
        
        self.contentView.addSubview(historyDeleteBtn)
        historyDeleteBtn.snp.makeConstraints { make in
            make.height.width.equalTo(11)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        
    }
    
    @objc func historyDeleteBtnClick() {
        self.historyDeleteBtnHandler?(searchText ?? "")
    }

}
