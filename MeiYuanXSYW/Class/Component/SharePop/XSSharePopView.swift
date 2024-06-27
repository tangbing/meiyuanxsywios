//
//  XSSharePopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/9.
//

import UIKit


enum XSShareStyle {
   case weixin
   case weixinCircle
   case largePicture
}

struct XSShareModel {
    var style: XSShareStyle
    var imageName: String
    var titleName: String
    
    init(style: XSShareStyle, imageName: String, titleName: String) {
        self.style = style
        self.imageName = imageName
        self.titleName = titleName
    }
    
}



class XSSharePopView: TBBaseView {
    
    let colNum = 4
    let models = [XSShareModel(style: .weixin,       imageName: "share_wechat", titleName: "微信好友"),
                  XSShareModel(style: .weixinCircle, imageName: "share_weixin_circle", titleName: "朋友圈"),
                  XSShareModel(style: .largePicture, imageName: "share_large_picture", titleName: "生成长图")]
    
    var didSelectShareCompleteBlock: ((_ popViewModel: XSShareModel) -> Void)?
    
    lazy var overlayView: UIControl = {
        let control = UIControl(frame: UIScreen.main.bounds)
        control.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.7)
        control.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        control.isHidden = true
        return control
    }()
    
    lazy var shareTitleLab: UILabel = {
        let shareTitle = UILabel()
        shareTitle.text = "分享到"
        shareTitle.textColor = .text
        shareTitle.font = MYBlodFont(size: 16)
        return shareTitle
    }()
    
    lazy var toptitleView: UIView = {
        let topView = UIView()
        return topView
    }()
    
    lazy var shareCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = ((screenWidth - CGFloat(24 * 2)) - CGFloat(55 * colNum)) / CGFloat((colNum - 1))
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = 55
        let itemH:CGFloat = 80
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(cellType: XSShareCollectionViewCell.self)

        return collectionView
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: screenWidth, height: 206)
    }
    
    override func configUI() {
        super.configUI()
        self.backgroundColor = .white
        
        toptitleView.addSubview(shareTitleLab)
        shareTitleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(toptitleView)
        toptitleView.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.top.left.right.equalToSuperview()
        }
        
        self.addSubview(shareCollectionView)
        shareCollectionView.snp.makeConstraints { make in
            make.top.equalTo(toptitleView.snp_bottom).offset(15)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(80)
        }
    }
}

extension XSSharePopView {
    // MARK: - public event
    func show(){
        let window = UIApplication.shared.keyWindow
        window?.addSubview(overlayView)
        window?.addSubview(self)
        self.frame = CGRect(x: 0, y: screenHeight, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
        fadeIn()
    }
    
    func fadeIn() {
     
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = false
            self.frame = CGRect(x: 0, y: screenHeight - self.intrinsicContentSize.height, width: screenWidth, height: self.intrinsicContentSize.height)
        } 
    }
    
    @objc func fadeOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = true
            self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: self.intrinsicContentSize.height)
        } completion: { (finish) in
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }

}

extension XSSharePopView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSShareCollectionViewCell.self)
        let shareModel = models[indexPath.item]
        cell.shareModel = shareModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fadeOut()
        let shareModel = models[indexPath.item]
        self.didSelectShareCompleteBlock?(shareModel)

    }

}
