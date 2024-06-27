//
//  XSMineHeaderCollectCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
import JKSwiftExtension
/// 添加cell点击代理方法
protocol XSMineHeaderCollectCellDelegate:NSObjectProtocol {
    func clickHeaderCate(dict:[String: String])
}

class XSMineHeaderCollectCell: XSBaseTableViewCell {
    weak var delegate : XSMineHeaderCollectCellDelegate?

    
    var collectView : UICollectionView={
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let itemW:CGFloat = UIScreen.jk.width/4
        let itemH:CGFloat = 70
        layout.itemSize = CGSize(width: itemW, height: itemH)
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coll.backgroundColor = .background
        coll.register(UINib(nibName: "XSMineOrderItem", bundle: nil), forCellWithReuseIdentifier: "XSMineOrderItem")
        return coll
    }()

    var dataSource = [Any](){
        didSet{
            self.collectView.reloadData()
        }
    }

    override func configUI() {
        contentView.backgroundColor = .background

        collectView.delegate = self
        collectView.dataSource = self
        contentView.addSubview(collectView)
        collectView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
}

extension XSMineHeaderCollectCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:XSMineOrderItem = collectionView.dequeueReusableCell(withReuseIdentifier: "XSMineOrderItem", for: indexPath) as! XSMineOrderItem
        let dict: [String: String] = dataSource[indexPath.row] as! [String : String]
        cell.tipLab.text = dict["title"]
        cell.icon.isHidden = true
        cell.numLab.isHidden = false;
        cell.iconNum.isHidden = true
        cell.numLab.text = dict["icon"]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dict: [String: String] = dataSource[indexPath.row] as! [String : String]
        delegate?.clickHeaderCate(dict: dict)
    }
    
}
