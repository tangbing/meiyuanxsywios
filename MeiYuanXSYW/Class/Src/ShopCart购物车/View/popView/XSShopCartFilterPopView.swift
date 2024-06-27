//
//  XSShopCartFilterPopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/26.
//

import UIKit
import QMUIKit

class XSShopCartFilterPopView: TBBaseView {
    
    
    var filterSelectHandler: ((_ buttonTag: Int) -> Void)?
    
    var selectedButton: QMUIButton?
    
    let filterSelects = ["全部","外卖","到店","私厨"]
    lazy var filterTopButton: QMUIButton  = {
        let arrowBtn = QMUIButton()
        arrowBtn.imagePosition = QMUIButtonImagePosition.right
        arrowBtn.setTitle("筛选条件", for: UIControl.State.normal)
        arrowBtn.setImage(UIImage(named: "shopcart_filter_drop-down"), for: UIControl.State.normal)
        arrowBtn.setTitleColor(.text, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYFont(size: 14)
        arrowBtn.spacingBetweenImageAndTitle = 5
        return arrowBtn
    }()
    
    lazy var overlayView: UIControl = {
        let control = UIControl(frame: UIScreen.main.bounds)
        control.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.6)
        control.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        control.isHidden = true
        return control
    }()
    
    override func configUI() {
        super.configUI()
        setupShopCartView()
    }
    
    func setupShopCartView(){
        self.backgroundColor = UIColor.white
        
        let line = lineView(bgColor: UIColor.hex(hexString: "#EBEBEB"))
        addSubview(line)
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.left.right.equalToSuperview()
        }

        self.addSubview(filterTopButton)
        filterTopButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 120, height: 25))
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        tagLayout(tags: filterSelects)
    }
    
    public func tagLayout(tags: [String]) {
        let textPadding: CGFloat = 10.0
        let tuples = tags.enumerated().map { (idx,title) -> (QMUIButton, CGFloat) in
            let tag = QMUIButton()
            tag.titleLabel?.font = MYFont(size: 14)
            tag.setTitleColor(.text, for: .normal)
            tag.setTitleColor(.white, for: .selected)
            tag.setTitle(title, for: .normal)
            tag.tag = idx
            tag.setBackgroundImage(UIColor.hex(hexString: "#F8F8F8").image(), for: .normal)
            tag.setBackgroundImage(UIColor.king.image(), for: .selected)
            if idx == 0 {
                tagFilterBtnClick(btn: tag)
            }
            tag.hg_setAllCornerWithCornerRadius(radius: 16)
            tag.addTarget(self, action: #selector(tagFilterBtnClick(btn:)), for: .touchUpInside)
            let width: CGFloat = 60
            return (tag, width)
        }
        
        let labs = tuples.map { $0.0 }
        let textWidths = tuples.map { $0.1 }
        
        let _ = tuples.map {
            self.addSubview($0.0)
        }
        
        // verticalSpacing   每个view之间的垂直距离
        // horizontalSpacing 每个view之间的水平距离
        // maxWidth 是整个布局的最大宽度，需要事前传入，比如 self.view.bounds.size.width - 40
        // textWidth 是每个view的宽度，也需事前计算好
        // itemHeight 每个view的高度
        // edgeInset 整个布局的 上下左右边距，默认为 .zero
        // topConstrainView 整个布局之上的view, 从topConstrainView.snp.bottom开始计算，
        // 比如,传入上面的label,则从 label.snp.bottom + edgeInset.top 开始排列， 默认为nil, 此时布局从 superview.snp.top + edgeInset.top 开始计算
        labs.snp.distributeDetermineWidthViews(verticalSpacing: textPadding,
                                               horizontalSpacing: textPadding,
                                               maxWidth: screenWidth - 10 - 10,
                                               determineWidths: textWidths,
                                               itemHeight: 32,
                                               edgeInset: UIEdgeInsets(top: 5,
                                                                       left: 10,
                                                                       bottom: 0,
                                                                       right: 10),
                                               topConstrainView: filterTopButton)
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: screenWidth, height: 90)
    }
    
    @objc func tagFilterBtnClick(btn button: QMUIButton){
        
        // 1.让当前选中的按钮取消选中
        self.selectedButton?.isSelected = false
        // 2.让新点击的按钮选中
        button.isSelected = true
        // 3.新点击的按钮就成为了"当前选中的按钮"
        self.selectedButton = button
        
        
        self.filterSelectHandler?(button.tag)
        
    }
}

extension XSShopCartFilterPopView {
    // MARK: - public event
    func show(showSuperView: UIView? = nil){
        let container = showSuperView == nil ? UIApplication.shared.keyWindow : showSuperView
        container!.addSubview(overlayView)
        container!.addSubview(self)
        self.frame = CGRect(x: 0, y: -self.intrinsicContentSize.height, width: screenWidth, height: intrinsicContentSize.height)
        self.hg_setCornerOnBottomWithRadius(radius: 10)
        fadeIn()
    }
    
    func fadeIn() {
     
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = false
            self.frame = CGRect(x: 0, y:0, width: screenWidth, height: self.intrinsicContentSize.height)
        }
    }
    
    @objc func fadeOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = true
            self.frame = CGRect(x: 0, y: -self.intrinsicContentSize.height, width: screenWidth, height: self.intrinsicContentSize.height)
        } completion: { (finish) in
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
}
