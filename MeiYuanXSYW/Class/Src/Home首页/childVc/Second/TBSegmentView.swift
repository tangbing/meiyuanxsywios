//
//  TBSegmentView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/18.
//

import UIKit

//class TBSegmentViewModel {
//    var titles:String = ""
//    var subtitles:String = ""
//    var isSelect: Bool = false
//
//    init(titles: String, subTitles: String, isSelect: Bool) {
//        self.titles = titles
//        self.subtitles = subTitles
//        self.isSelect = isSelect
//    }
//}

protocol TBSegmentViewDelegate: NSObjectProtocol {
    func didSelectItem(at index: Int)
    
}

class TBSegmentView: UIView {
    /// 'weak' must not be applied to non-class-bound 'TBSegmentViewDelegate'; consider adding a protocol conformance that has a class bound
    weak var delegate: TBSegmentViewDelegate?
    
    var selectTextColor: UIColor = UIColor.white
    
    var selectIndex: Int = 0
    
    var defaultSelect: Int = 0 {
        didSet {
            containerView.selectItem(at: IndexPath(item: defaultSelect, section: 0), animated: false, scrollPosition: UICollectionView.ScrollPosition.centeredVertically)
            if ((containerView.delegate?.responds(to: #selector(collectionView(_:didSelectItemAt:)))) != nil) {
                containerView.delegate?.collectionView?(containerView, didSelectItemAt: IndexPath(item: defaultSelect, section: 0))
            }
          
        }
    }
        
    var datas:[HomeSecondActivityListModel] = [HomeSecondActivityListModel](){
        didSet {
            containerView.reloadData()
        }
    }
        
    
    lazy var containerView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 44
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = 68
        let itemH:CGFloat = 50
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: TBSecondCollectionViewCell.self)


        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(containerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.frame = self.bounds
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension TBSegmentView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TBSecondCollectionViewCell.self)
        
        let model = datas[indexPath.item]
        cell.secondTimeLabel.text = model.dateSegment
        cell.secondStatusLabel.text = model.activityStatusStr
        if model.isSelect {
            cell.secondStatusLabel.backgroundColor = .white
            cell.secondStatusLabel.hg_setAllCornerWithCornerRadius(radius: 12)
            cell.secondStatusLabel.textColor = selectTextColor
            cell.secondStatusLabel.alpha = 1
            cell.secondStatusLabel.font = MYFont(size: 13)
            
            cell.secondTimeLabel.font = MYBlodFont(size: 19)
            cell.secondTimeLabel.alpha = 1
        } else {
            cell.secondStatusLabel.backgroundColor = .clear
            cell.secondStatusLabel.textColor = .white
            cell.secondStatusLabel.alpha = 0.7
            cell.secondStatusLabel.font = MYFont(size: 13)
            
            cell.secondTimeLabel.font = MYFont(size: 17)
            cell.secondTimeLabel.alpha = 0.7
        }
        return cell
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? TBSecondCollectionViewCell  else {
            print("cell nil!")
            return
        }
       
        
        let pointInCollection = collectionView.convert(cell.frame.origin, to: collectionView)
        
        var scrollX = pointInCollection.x - self.containerView.tb_width * 0.5
        if scrollX < 0 {
            scrollX = 0
        }
        
        if scrollX > self.containerView.contentSize.width -  self.containerView.tb_width {
            scrollX = self.containerView.contentSize.width -  self.containerView.tb_width
        }
        collectionView.setContentOffsetX(scrollX, animated: true)
        
        
        self.delegate?.didSelectItem(at: indexPath.item)
        
        self.selectIndex = indexPath.item

        
        datas.forEach { modle in
            modle.isSelect = false
        }
        
        let model = datas[indexPath.item]
        model.isSelect = true
        
        containerView.reloadData()
 
    }
    
    
}
