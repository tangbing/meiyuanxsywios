//
//  PPCollectionViewFlowLayout.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/13.
//

import UIKit

@objc protocol PPCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout{
     
    /// CollectionView 的组设置背景颜色
    /// - Parameters:
    /// - collectionView:  collectionView description
    /// - layout:  layout  description
    /// - section: section description
    /// - Returns: return  组的颜色
    @objc optional func backgroundColorForSection(
                        collectionView:UICollectionView,
                        layout:UICollectionViewLayout,
                        section:NSInteger) -> UIColor
     
    /// CollectionView 的组设置圆角
    /// - Parameters:
    /// - collectionView:  collectionView description
    /// - layout:  layout  description
    /// - section: section description
    /// - Returns: UIRectCorner eg:[.topLeft,.topRight]
    @objc optional func cornerForSection(
                        collectionView:UICollectionView,
                        layout:UICollectionViewLayout,
                        section:NSInteger) -> UIRectCorner
     
    /// CollectionView 的组设置圆角的大小 要是默认的12可不实现此方法返回
    /// - Parameters:
    /// - collectionView:  collectionView description
    /// - layout:  layout  description
    /// - section: section description
    /// - Returns: CGSize  圆角大小
    @objc optional func cornerRadiiForSection(
                        collectionView:UICollectionView,
                        layout:UICollectionViewLayout,
                        section:NSInteger) -> CGSize
}


// MARK: - 添加自定义属性
class PPCollectionLayoutAttributes: UICollectionViewLayoutAttributes {
     
    /// 添加组背景
    var backgroundColor:UIColor?
    /// 添加组圆角
    var corners:UIRectCorner?
    /// 添加组圆角的大小
    var sectionCornerRadii:CGSize?
}

// MARK: - 可重复使用视图
class PPReusableView: UICollectionReusableView {
     
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
         
        if layoutAttributes.isKind(of: PPCollectionLayoutAttributes.self) {
             
            let layoutAttribute  = layoutAttributes as? PPCollectionLayoutAttributes
            if layoutAttribute!.backgroundColor != nil {
                self.backgroundColor = layoutAttribute!.backgroundColor
            }
            /// 默认设置为 12 以后有需要可以自定义
            if layoutAttribute!.corners != nil {
                self.setRoundingCorners(layoutAttribute!.corners!, cornerRadii: kDefaultCornerRadii)
            }
        }
    }
    func setRoundingCorners(_ corners: UIRectCorner, cornerRadii: CGFloat) {
        self.jk.addCorner(conrners: corners, radius: cornerRadii)
    }
}

class PPCollectionViewFlowLayout: UICollectionViewFlowLayout {
     
    /// 存储添加的属性
    private var layoutAttributes:Array<UICollectionViewLayoutAttributes>?
    /// CollectionView的边距  这个值可以自定义 默认是10
    public var marginValue:CGFloat = 0
     
    override init() {
        super.init()
         
        self.layoutAttributes = []
        /// 注册一个修饰View
        self.registDecorationView()
    }
 
    func registDecorationView() {
         
        self.register(PPReusableView.self, forDecorationViewOfKind: "PPCollectionViewDecorationView")
    }
     
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - override
extension PPCollectionViewFlowLayout{
     
    // NOTE: 该方法会在你每次刷新collection data的时候都会调用
    override func prepare() {
        super.prepare()
         
        /// 避免属性重复添加数据过大
        self.layoutAttributes?.removeAll()
        /// 设置背景和圆角
        self.setSectionBackgaoundColorAndCorner()
    }
     
    /// 返回rect中的所有的元素的布局属性
    /// - Parameter rect: rect description
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
         
        var attributes = super.layoutAttributesForElements(in: rect)
        for attribute in self.layoutAttributes! {
             
            ///判断两个区域是否有交集
            if rect.intersects(attribute.frame){
                attributes?.append(attribute)
            }
        }
        return attributes
    }
     
    /// 给Decorationview返回属性数组
    /// - Parameters:
    ///   - elementKind: elementKind description
    ///   - indexPath:   indexPath description
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
         
        if elementKind == "PPCollectionViewDecorationView" {
             
            return self.layoutAttributes![indexPath.section]
        }
        return super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
    }
}

// MARK: - set property
extension PPCollectionViewFlowLayout{
     
    /// 给collectionView设置背景和圆角
    func setSectionBackgaoundColorAndCorner(){
         
        /// 获取collectionView的代理
        guard let delegate = self.collectionView?.delegate else {
            return
        }
        /// 没遵守这个协议就不再往下设置
        if delegate.conforms(to: PPCollectionViewDelegateFlowLayout.self) == false {
            return
        }
        /// collectionView有多少组
        let numberOfSections = self.collectionView?.numberOfSections ?? 0
        if  numberOfSections == 0 {
            return
        }
        /// 循环遍历各组 设置添加的属性
        for section in 0..<numberOfSections {
            
            /// 一组cell的Item
            let numberOfItems = self.collectionView?.numberOfItems(inSection: section) ?? 0
            if (numberOfItems <= 0) {
                continue;
            }
                    
            /// 每一组第一个item的Attributes
            let firstItem = self.layoutAttributesForItem(at: IndexPath.init(item: 0, section: section))
            /// 每一组最后一个item的Attributes
            let lastItem  = self.layoutAttributesForItem(at: IndexPath.init(item: numberOfItems - 1, section: section))
            /// 满足条件 结束本次循环执行下一次
            if ((firstItem == nil) || (lastItem == nil)) {
                continue
            }
                    
            /// 实现了insetForSectionAt
            if delegate.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:insetForSectionAt:))) {
                        
                let inset = (delegate as? UICollectionViewDelegateFlowLayout)? .collectionView?(self.collectionView!, layout: self, insetForSectionAt: section)
                self.sectionInset = inset!
            }
                    
            /// 获取第一个和最后一个item的联合frame ，得到的就是这一组的frame
            var sectionFrame:CGRect = firstItem!.frame.union(lastItem!.frame)
            /// 设置它的x.y  注意理解这里的x点和y点的坐标，不要硬搬，下面这样写的时候是把inset的left的
            /// 距离包含在sectionFrame 开始x的位置 下面的y同逻辑
            sectionFrame.origin.x -= self.sectionInset.left - self.marginValue
            sectionFrame.origin.y -= self.sectionInset.top
            ///横向滚动
            if self.scrollDirection == .horizontal{
                        
                /// 计算组的宽的时候要把缩进进去的距离加回来 因为缩进是内容缩进
                sectionFrame.size.width += self.sectionInset.left + self.sectionInset.right
                /// 横向滚动的时候 组的高就是collectionView的高
                sectionFrame.size.height = self.collectionView!.frame.size.height
            /// 纵向滚动
            }else{
                /// 纵向滚动的时候组的宽度  这里的道理和上面的x,y的一样，需要你按照自己项目的实际需求去处理
                sectionFrame.size.width = self.collectionView!.frame.size.width - (2 * self.marginValue)
                sectionFrame.size.height += self.sectionInset.top + self.sectionInset.bottom
            }
            /// 根据自定义的PPCollectionViewSectionBackground 装饰View初始化一个自定义的PPCollectionLayoutAttributes
            let attribute = PPCollectionLayoutAttributes.init(forDecorationViewOfKind:"PPCollectionViewDecorationView",with: IndexPath.init(item: 0, section: section))
            attribute.frame  = sectionFrame
            attribute.zIndex = -1
                    
            /// 实现了backgroundColorForSection
            if delegate.responds(to: #selector(PPCollectionViewDelegateFlowLayout.backgroundColorForSection(collectionView:layout:section:))){
                        
                /// 背景色
                attribute.backgroundColor = (delegate as? PPCollectionViewDelegateFlowLayout)?.backgroundColorForSection!(collectionView: self.collectionView!, layout: self, section: section)
            }
                    
            /// 实现了cornerForSection
            if delegate.responds(to: #selector(PPCollectionViewDelegateFlowLayout.cornerForSection(collectionView:layout:section:))) {
                        
                /// 圆角
                attribute.corners = (delegate as? PPCollectionViewDelegateFlowLayout)?.cornerForSection!(collectionView: self.collectionView!, layout: self, section: section)
                /// 要是是默认的大小就不在实现cornerRadiiForSection
                attribute.sectionCornerRadii = CGSize(width: kDefaultCornerRadii, height: kDefaultCornerRadii);
            }
             
            /// 要是自定义了圆角大小
            if delegate.responds(to: #selector(PPCollectionViewDelegateFlowLayout.cornerRadiiForSection(collectionView:layout:section:))) {
                 
                attribute.sectionCornerRadii = (delegate as? PPCollectionViewDelegateFlowLayout)?.cornerRadiiForSection!(collectionView: self.collectionView!, layout: self, section: section)
            }
            self.layoutAttributes?.append(attribute)
        }
    }
}
