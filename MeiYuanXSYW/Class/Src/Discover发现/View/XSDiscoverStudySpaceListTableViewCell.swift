//
//  XSDiscoverStudySpaceListTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit
import QMUIKit


class XSDiscoverStudySpaceListInfoView: TBBaseView {
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-05-14  14:25:36"
        label.textColor = UIColor.hex(hexString: "#B3B3B3")
        label.font = MYFont(size: 12)
        return label
    }()
    
    lazy var seeNumBtn: QMUIButton = {
        let see = QMUIButton(type: .custom)
        see.contentHorizontalAlignment = .right
        see.setImage(UIImage(named: "discover_black_look"), for: .normal)
        see.setTitle("4,836", for: .normal)
        see.spacingBetweenImageAndTitle = 2
        see.setTitleColor(.text, for: .normal)
        see.titleLabel?.font = MYFont(size: 12)
        //all.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
        return see
    }()
    
    lazy var topicBtn: QMUIButton = {
        let topic = QMUIButton(type: .custom)
        topic.contentHorizontalAlignment = .right
        topic.setTitle("#撸串天堂", for: .normal)
        topic.setTitleColor(.king, for: .normal)
        topic.titleLabel?.font = MYFont(size: 12)
        //all.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
        return topic
    }()
    
    
    
    
    override func configUI() {
        super.configUI()
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(seeNumBtn)
        seeNumBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalTo(timeLabel)
            make.height.equalTo(22)
        }
        
        self.addSubview(topicBtn)
        topicBtn.snp.makeConstraints { make in
            make.right.equalTo(seeNumBtn.snp_left).offset(0)
            make.centerY.equalTo(timeLabel)
            make.width.equalTo(180)
            make.height.equalTo(22)
        }
        
    }
    
}

class XSDiscoverStudySpaceListTableViewCell: XSBaseTableViewCell {

    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        //iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "group buy_picture4")
        return iv
    }()
    
    lazy var merchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "康美甄营养餐菜品名称 | 康美甄营养餐菜品名称"
        label.textColor = .text
        label.font = MYBlodFont(size: 16)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let content = UILabel()
        content.numberOfLines = 2
        content.text = "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合，与众不同之处就在于它既有梨子酒的清香和"
        content.textColor = .twoText
        content.font = MYFont(size: 13)
        return content
    }()
    
    lazy var infoView: XSDiscoverStudySpaceListInfoView = {
        return XSDiscoverStudySpaceListInfoView()
    }()
    
//    lazy var line: UIView = {
//        let line = UIView(frame: CGRect(x: 0, y: 59, width: screenWidth, height: 1))
//        line.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
//        return line
//    }()
//
//    lazy var merchNameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "康美甄营养餐菜品名称 |"
//        label.textColor = .twoText
//        label.font = MYBlodFont(size: 16)
//        return label
//    }()
    
    override func configUI() {
        super.configUI()
        self.contentView.backgroundColor = .white
        self.contentView.hg_setAllCornerWithCornerRadius(radius: 10)
        
        self.contentView.addSubview(merchIcon)
        merchIcon.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(FMScreenScaleFrom(200))
        }
        
        self.contentView.addSubview(merchNameLabel)
        merchNameLabel.snp.makeConstraints { make in
            make.top.equalTo(merchIcon.snp_bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
        }
        
        self.contentView.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.left.right.equalTo(merchNameLabel)
            make.height.equalTo(22)
            make.top.equalTo(merchNameLabel.snp_bottom).offset(4)
        }
        
        self.contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.left.right.equalTo(merchNameLabel)
            make.top.equalTo(infoView.snp_bottom).offset(4)
            make.bottom.equalToSuperview().offset(-15)
        }
        
    }

}
