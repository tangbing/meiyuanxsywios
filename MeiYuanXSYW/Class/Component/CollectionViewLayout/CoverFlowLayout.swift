//
//  File.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/27.
//

import UIKit


class CoverFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        // 1.获取该范围内的布局数组
        let attributes = super.layoutAttributesForElements(in: rect)
        // 2.计算出整体中心点的x坐标
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        
        //3.根据当前的滚动，对每个cell进行相应的缩放
        attributes?.forEach({ attr in
            // 获取每个cell中心点，并计算这两个中心点的偏移值
            let pad = abs(centerX - attr.center.x)
            
            // 如何计算缩放比?我的思路是，距离越小，缩放比越小，缩放比最大是1，当俩个中心点的 x 坐标
               // 重合的时候，缩放比就为 1.
            let factor = 0.0009
            // 计算缩放比
            let scale = 1 / (1 + pad * CGFloat(factor))
            
            attr.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
        
        // 4.返回修改后的 attributes 数组
        return attributes
    }
    
    
    /// 滚动时停下的偏移量
    /// - Parameter proposedContentOffset: 将要停止的点
    /// - Returns: 滚动速度
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        var targetPoint = proposedContentOffset
        // 1. 计算中心点的x值
        let centerX = proposedContentOffset.x + collectionView!.bounds.width / 2
        // 2.获取这个点可视范围内的布局属性
        let attrs = self.layoutAttributesForElements(in: CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: collectionView!.bounds.size.width, height: collectionView!.bounds.size.height))
        // 3. 需要移动的最小距离
        var moveDistance: CGFloat = CGFloat(MAXFLOAT)
        // 4. 遍历数组找出最新距离
        attrs?.forEach({ attr in
            if abs(attr.center.x - centerX) < abs(moveDistance) {
                moveDistance = attr.center.x - centerX
            }
        })
        
        // 5.返回一个新的偏移点
        if targetPoint.x > 0 && targetPoint.x < collectionViewContentSize.width - collectionView!.bounds.width {
            targetPoint.x += moveDistance
        }
        return targetPoint
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
        let rowWidth = CGFloat(collectionView!.numberOfItems(inSection: 0)) * (itemSize.width + minimumLineSpacing) - minimumLineSpacing
        return CGSize(width: sectionInset.left + sectionInset.right + rowWidth, height: 0)
    }
    
}
