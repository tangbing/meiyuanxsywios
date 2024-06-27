//
//  TBMerchInfoDetailMerchServiceCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/4.
//

import UIKit

class TBMerchInfoDetailMerchServiceCell: XSBaseTableViewCell {

    lazy var serviceTitleLab: UILabel = {
        let lab = UILabel()
        lab.textColor = .text
        lab.font = MYFont(size: 14)
        return lab
    }()
    
    override func configUI() {
        self.contentView.addSubview(serviceTitleLab)
        serviceTitleLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(17)
            make.height.equalTo(16)
        }
    }
    
    public func tagLayout(tags: [String]) {
        let textPadding: CGFloat = 10.0
        let tuples = tags.map { title -> (UILabel, CGFloat) in
            let tagLab = UILabel()
            tagLab.font = MYFont(size: 10)
            tagLab.textColor = UIColor.hex(hexString: "#979797")
            tagLab.text = title
            tagLab.textAlignment = .center
            //tagLab.backgroundColor = UIColor.hex(hexString: "#979797")
            tagLab.hg_setAllCornerWithCornerRadius(radius: 10)
            tagLab.jk.addBorder(borderWidth: 1.0, borderColor: UIColor.hex(hexString: "E5E5E5"))
            
            let width = title.size(withFont: tagLab.font).width + textPadding * 2
            return (tagLab, width)
        }
        
        let labs = tuples.map { $0.0 }
        let textWidths = tuples.map { $0.1 }
        
        let _ = tuples.map {
            self.contentView.addSubview($0.0)
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
                                               maxWidth: screenWidth - 15 - 15,
                                               determineWidths: textWidths,
                                               itemHeight: 2 * textPadding,
                                               edgeInset: UIEdgeInsets(top: 20 + 0,
                                                                       left: 15,
                                                                       bottom: 15,
                                                                       right: 15),
                                               topConstrainView: serviceTitleLab)
        
    }
}
