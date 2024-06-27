//
//  XSDiscoverRecommandTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/2.
//

import UIKit
import QMUIKit

class XSDiscoverRecommandTopInfoView: TBBaseView {
    
    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        iv.hg_setAllCornerWithCornerRadius(radius: 17.5)
        //iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "group buy_picture4")
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "老李家的亲戚"
        label.numberOfLines = 1
        label.textColor = .text
        label.font = MYBlodFont(size: 14)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let time = UILabel()
        time.text = "48分钟前"
        time.textAlignment = .right
        time.numberOfLines = 1
        time.textColor = UIColor.hex(hexString: "#B3B3B3")
        time.font = MYFont(size: 12)
        return time
    }()
    
    lazy var topicBtn: QMUIButton = {
        let topic = QMUIButton(type: .custom)
        topic.contentHorizontalAlignment = .right
        topic.setTitle("#撸串天堂", for: .normal)
        topic.setTitleColor(.king, for: .normal)
        topic.titleLabel?.font = MYFont(size: 12)
        topic.isHidden = true
        //all.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
        return topic
    }()
    
    lazy var introlLabel: UILabel = {
        let introl = UILabel()
        introl.text = "深圳罗湖吃货"
        introl.numberOfLines = 1
        introl.textColor = .twoText
        introl.font = MYFont(size: 12)
        return introl
    }()
    
    override func configUI() {
        
        self.addSubview(merchIcon)
        merchIcon.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(10)
        }
        
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(merchIcon.snp_top).offset(2)
            make.left.equalTo(merchIcon.snp_right).offset(5)
        }
        
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel).offset(0)
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(nameLabel.snp_right).offset(10)
        }
        
        self.addSubview(topicBtn)
        topicBtn.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel).offset(0)
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(nameLabel.snp_right).offset(10)
        }
        
        
        self.addSubview(introlLabel)
        introlLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottom).offset(4)
            make.right.equalToSuperview().offset(-10)
        }
    
    }
    
    func showTopic(){
        topicBtn.isHidden = false
        timeLabel.isHidden = true
    }
}

class XSDiscoverRecommandZanView: TBBaseView {
    
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
    
    lazy var zanNumBtn: QMUIButton = {
        let zan = QMUIButton(type: .custom)
        zan.contentHorizontalAlignment = .right
        zan.setImage(UIImage(named: "dscover_zan"), for: .normal)
        zan.setTitle("4,836", for: .normal)
        zan.spacingBetweenImageAndTitle = 2
        zan.setTitleColor(.text, for: .normal)
        zan.titleLabel?.font = MYFont(size: 12)
        //all.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
        return zan
    }()
    
    lazy var repeatNumBtn: QMUIButton = {
        let repet = QMUIButton(type: .custom)
        repet.contentHorizontalAlignment = .right
        repet.setImage(UIImage(named: "discover_message"), for: .normal)
        repet.setTitle("4,836", for: .normal)
        repet.spacingBetweenImageAndTitle = 2
        repet.setTitleColor(.text, for: .normal)
        repet.titleLabel?.font = MYFont(size: 12)
        //all.addTarget(self, action: #selector(selectAllAction), for: .touchUpInside)
        return repet
    }()
    
    lazy var shareBtn: QMUIButton = {
        let share = QMUIButton(type: .custom)
        share.setImage(UIImage(named: "mine_evaluate_share"), for: .normal)
        share.addTarget(self, action: #selector(shareBtnAction), for: .touchUpInside)
        return share
    }()
    
    override func configUI() {
        self.addSubview(shareBtn)
        shareBtn.snp.makeConstraints { make in
            make.height.width.equalTo(22)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            
        }
        
        self.addSubview(repeatNumBtn)
        repeatNumBtn.snp.makeConstraints { make in
            make.centerY.equalTo(shareBtn)
            make.right.equalTo(shareBtn.snp_left).offset(-36)
            make.height.equalTo(shareBtn)
            make.width.equalTo(84)
        }
        
        self.addSubview(zanNumBtn)
        zanNumBtn.snp.makeConstraints { make in
            make.centerY.equalTo(shareBtn)
            make.right.equalTo(repeatNumBtn.snp_left).offset(-23)
            make.height.equalTo(shareBtn)
            make.width.equalTo(84)
        }
        
        self.addSubview(seeNumBtn)
        seeNumBtn.snp.makeConstraints { make in
            make.centerY.equalTo(shareBtn)
            make.right.equalTo(zanNumBtn.snp_left).offset(-23)
            make.height.equalTo(shareBtn)
            make.width.equalTo(84)
        }
    }
    
    @objc func shareBtnAction() {
        
    }
    
    
}

class XSDiscoverRecommandMerchInfoView: TBBaseView {
    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        //iv.contentMode = .scaleToFill
        iv.image = UIImage(named: "group buy_picture4")
        return iv
    }()
    
    lazy var merchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "康美甄营养餐菜品名称"
        label.textColor = .twoText
        label.font = MYBlodFont(size: 16)
        return label
    }()
    
    lazy var evaluatView: XSCollectHightEvaluatView = {
        let evaluatView = XSCollectHightEvaluatView()
        //evaluatView.configMerchInfo()
        return evaluatView
    }()
    
    lazy var priveView: XSCollectPriceView = {
        let priveView = XSCollectPriceView()
        return priveView
    }()
    
    lazy var shopCartBtn: QMUIButton = {
        let btn = QMUIButton()
        btn.setImage(UIImage(named: "collect_Shopping_Cart"), for: .normal)
        btn.addTarget(self, action: #selector(goCartBtnClick), for: .touchUpInside)
        return btn
    }()
    
    
    override func configUI() {
        self.backgroundColor = UIColor.hex(hexString: "#FCFCFC")
        
        self.addSubview(merchIcon)
        merchIcon.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(93)
        }
        
        self.addSubview(merchNameLabel)
        merchNameLabel.snp.makeConstraints { make in
            make.left.equalTo(merchIcon.snp_right).offset(5)
            make.top.equalTo(merchIcon)
            make.right.equalToSuperview().offset(-10)
        }
        
        self.addSubview(evaluatView)
        evaluatView.snp.makeConstraints { make in
            make.top.equalTo(merchNameLabel.snp_bottom).offset(5)
            make.left.equalTo(merchNameLabel)
        }
        
        
        self.addSubview(shopCartBtn)
        shopCartBtn.snp.makeConstraints { make in
            make.height.width.equalTo(25)
            make.right.bottom.equalToSuperview().offset(-10)
        }
        
        self.addSubview(priveView)
        priveView.snp.makeConstraints { make in
            make.bottom.equalTo(merchIcon.snp_bottom).offset(0)
            make.left.equalTo(merchNameLabel)
            make.height.equalTo(20)
        }

    }
    
    @objc func goCartBtnClick() {
        
    }
}

class XSDiscoverRecommandTableViewCell: XSBaseTableViewCell {

    lazy var topInfoView: XSDiscoverRecommandTopInfoView = {
        let infoView = XSDiscoverRecommandTopInfoView()
        return infoView
    }()
    
    lazy var zanView: XSDiscoverRecommandZanView = {
        let zanView = XSDiscoverRecommandZanView()
        return zanView
    }()
    
    lazy var bottomMerchInfoView: XSDiscoverRecommandMerchInfoView = {
        let merchInfo = XSDiscoverRecommandMerchInfoView()
        return merchInfo
    }()
    
    private lazy var imageContainer : TbImageViewContainer = {
        let im = TbImageViewContainer()
        return im
    }()
    
    lazy var containerView: UIView = {
        let containe = UIView()
        containe.backgroundColor = .white
        containe.hg_setAllCornerWithCornerRadius(radius: 10)
        return containe
    }()
    
    lazy var contentLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .text
        lab.font = MYFont(size: 13)
        lab.numberOfLines = 0
        return lab
    }()
    
    func bindViewModel(viewModel model : XSDiscoverRecomandModel) {
        contentLab.text = model.content
        
        self.imageContainer.setData(imageData: model.pics)

        imageContainer.snp.updateConstraints { make in
            make.height.equalTo(model.photoViewHeight)
        }
        
    }
    
    override func configUI() {
        super.configUI()
        
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        }
        
        containerView.addSubview(topInfoView)
        topInfoView.snp.makeConstraints { make in
            make.height.equalTo(54)
            make.top.left.right.equalToSuperview()
        }
        
        containerView.addSubview(contentLab)
        contentLab.snp.makeConstraints { make in
            make.top.equalTo(topInfoView.snp_bottom).offset(6)
            make.left.equalTo(topInfoView.nameLabel)
            make.right.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(imageContainer)
        imageContainer.snp.makeConstraints { make in
            make.top.equalTo(contentLab.snp_bottom).offset(6)
            make.left.equalTo(contentLab)
            make.height.equalTo(0)
            make.right.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(zanView)
        zanView.snp.makeConstraints { make in
            make.top.equalTo(imageContainer.snp_bottom).offset(0)
            make.left.equalTo(topInfoView)
            make.height.equalTo(42)
            make.right.equalToSuperview().offset(-10)
        }
        
        containerView.addSubview(bottomMerchInfoView)
        bottomMerchInfoView.snp.makeConstraints { make in
            make.top.equalTo(zanView.snp_bottom).offset(0)
            make.left.right.equalTo(topInfoView)
            make.height.equalTo(90)
            make.bottom.equalToSuperview().offset(-15)
        }

    }

}
