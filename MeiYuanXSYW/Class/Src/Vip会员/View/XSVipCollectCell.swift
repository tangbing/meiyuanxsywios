//
//  XSVipCollectCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
import JKSwiftExtension
/// 添加cell点击代理方法
protocol XSVipCollectCellDelegate:NSObjectProtocol {
    func clickAddBuy()
}

class XSVipCollectCell: XSBaseTableViewCell {
    
    var block:((_ id:String)->())?
    weak var delegate : XSVipCollectCellDelegate?
    
    var model :[CLAddPackageModel] = [] {
        didSet {
            self.collectView.reloadData()
        }
    }

    
    var collectView : UICollectionView={
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 14
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = 120
        let itemH:CGFloat = 175
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coll.backgroundColor = .white
        coll.register(cellType: XSVipCollectItem.self)

        return coll
    }()

    var dataSource = [Any]()

    override func configUI() {
        contentView.backgroundColor = .background
        collectView.delegate = self
        collectView.dataSource = self
        contentView.addSubview(collectView)
        collectView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.bottom.equalTo(0)
        }
    }
    
}

extension XSVipCollectCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:XSVipCollectItem = collectionView.dequeueReusableCell(for: indexPath, cellType: XSVipCollectItem.self)
        cell.model = self.model[indexPath.item]
        cell.clickBlock = {[unowned self] in
            guard let action = self.block else { return }
            action(self.model[indexPath.item].addPackageId)
        }
//        cell.delegate = self
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict: [String: String] = dataSource[indexPath.row] as! [String : String]
//        delegate?.clickHeaderCate(dict: dict)
    }

    
}

extension XSVipCollectCell:XSVipCollectItemDelegate{
    func clickBuy() {
        delegate?.clickAddBuy()
    }
}
