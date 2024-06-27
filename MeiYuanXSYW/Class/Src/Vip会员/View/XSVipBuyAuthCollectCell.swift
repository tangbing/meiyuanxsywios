//
//  XSVipBuyAuthCollectCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
import JKSwiftExtension
/// 添加cell点击代理方法
protocol XSVipBuyAuthCollectCellDelegate:NSObjectProtocol {
    func clickHeaderCate(dict:[String: String])
}

class XSVipBuyAuthCollectCell: XSBaseTableViewCell {
    weak var delegate : XSVipBuyAuthCollectCellDelegate?

    var model:[[String:String]] = [] {
        didSet{
            self.collectView.reloadData()
        }
    }
    
    
    var collectView : UICollectionView={
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 26
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = (screenWidth-78-25)/4
        let itemH:CGFloat = 120
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coll.backgroundColor = .white
        coll.register(cellType: XSVipBuyAuthCollectItem.self)

        return coll
    }()

    var dataSource = [Any]()

    override func configUI() {
        collectView.delegate = self
        collectView.dataSource = self
        contentView.addSubview(collectView)
        collectView.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.top.bottom.equalTo(0)
        }
    }
    
}

extension XSVipBuyAuthCollectCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:XSVipBuyAuthCollectItem = collectionView.dequeueReusableCell(for: indexPath, cellType: XSVipBuyAuthCollectItem.self)
        cell.model = self.model[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let dict: [String: String] = dataSource[indexPath.row] as! [String : String]
//        delegate?.clickHeaderCate(dict: dict)
    }

    
}
