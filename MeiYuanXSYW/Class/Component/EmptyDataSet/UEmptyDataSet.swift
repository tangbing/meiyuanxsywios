//
//  UEmptyDataSet.swift
//  U17
//
//  Created by charles on 2017/11/28.
//  Copyright © 2017年 None. All rights reserved.
//

import Foundation
import EmptyDataSet_Swift
import UIKit
import QMUIKit
import Kingfisher

extension UIScrollView {
    
    private struct AssociatedKeys {
        static var uemptyKey: Void?
    }
    
    var uempty: UEmptyView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.uemptyKey) as? UEmptyView
        }
        set {
            self.emptyDataSetDelegate = newValue
            self.emptyDataSetSource = newValue
           objc_setAssociatedObject(self, &AssociatedKeys.uemptyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

enum UEmptyViewState {
    /// 空数据
    case noDataState
    /// 网络异常
    case networkingErrorState
    /// 加载中
    case loading
}

class UEmptyView: EmptyDataSetSource, EmptyDataSetDelegate {
    
    var image: UIImage?
    
    var allowShow: Bool = false
    var verticalOffset: CGFloat = 0
    var emptyState: UEmptyViewState = .loading
    var description: String?
    var tapButtonTitle: String?
    
    private var tapClosure: (() -> Void)?
    
    init(description: String? = nil,tapButtonTitle: String? = nil, verticalOffset: CGFloat = 0, tapClosure: (() -> Void)? = nil) {
        self.description = description
        self.tapButtonTitle = tapButtonTitle
        self.verticalOffset = verticalOffset
        self.tapClosure = tapClosure
    }
    
    
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return -100
    }
        
    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
        
        let customView = UIView()
        customView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 300)
        customView.backgroundColor = .clear

        let imageView = AnimatedImageView()
        
        
        let descLabel = UILabel()
        descLabel.text = description
        
        descLabel.font = MYFont(size: 14)
        descLabel.textColor = .twoText
        descLabel.sizeToFit()
        
        customView.addSubview(imageView)
        imageView.tb_size = CGSize(width: 150, height: 140)
        imageView.center = customView.center
        
        
        customView.addSubview(descLabel)
        descLabel.sizeToFit()
//        descLabel.tb_y = imageView.tb_bottom + 10
//        descLabel.tb_centerX = imageView.tb_centerX

        
        let againButton = QMUIButton(type: .custom)
        againButton.titleLabel?.font = MYFont(size: 14)
        againButton.setTitleColor(.king, for: .normal)
        againButton.jk.addBorder(borderWidth: 1.0, borderColor: .king)
        againButton.setTitle(tapButtonTitle ?? "重试", for: .normal)
        
        againButton.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds
        customView.addSubview(againButton)
        againButton.addTarget(self, action: #selector(emptyDataSetDidTapView), for: .touchUpInside)
        
        
        if self.emptyState == .noDataState {
            descLabel.text = description
            imageView.image = UIImage(named: "nodata")
            imageView.repeatCount = .once
            imageView.autoPlayAnimatedImage = false
            imageView.tb_size = CGSize(width: 150, height: 140)
            
            descLabel.tb_y = imageView.tb_bottom + 10
            descLabel.tb_centerX = imageView.tb_centerX

            againButton.isHidden = true
            
        } else if (self.emptyState == .networkingErrorState) {
            descLabel.text = description
            imageView.image = UIImage(named: "Check_network")
            imageView.repeatCount = .once
            imageView.tb_size = CGSize(width: 150, height: 140)
            imageView.autoPlayAnimatedImage = false
            
            descLabel.tb_y = imageView.tb_bottom + 0
            descLabel.tb_centerX = imageView.tb_centerX
            
            againButton.tb_height = 32
            againButton.tb_width = 90
            againButton.tb_y = descLabel.tb_bottom + 12
            againButton.tb_centerX = imageView.tb_centerX
            againButton.isHidden = false
            
        } else {
            againButton.isHidden = true
            descLabel.text = "加载中"
            
            let path = Bundle.main.path(forResource: "loading", ofType: "gif")
            let url  = URL(fileURLWithPath: path!)
            let provider = LocalFileImageDataProvider(fileURL: url)
            imageView.kf.setImage(with: provider)
            imageView.repeatCount = .infinite
            imageView.tb_size = CGSize(width: 80, height: 80)
            
            descLabel.tb_y = imageView.tb_bottom + 10
            descLabel.tb_centerX = imageView.tb_centerX
        }
        return customView
    }
    
    @objc func emptyDataSetDidTapView() {
        guard let tapClosure = tapClosure else { return }
        tapClosure()
    }
    
    
    internal func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return allowShow
    }
    
    internal func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        guard let tapClosure = tapClosure else { return }
        tapClosure()
    }
}




