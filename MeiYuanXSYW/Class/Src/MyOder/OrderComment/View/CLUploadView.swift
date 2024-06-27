//
//  CLUploadView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/28.
//

import UIKit

class CLUploadView :TBBaseView {
    var collectionView:UICollectionView!
    var cellModel :[String] = [""]


    override func configUI() {
        let layout =  UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 75, height: 75)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CLMyOrderCommentCollectionCell.self, forCellWithReuseIdentifier: "CLMyOrderCommentCollectionCell")

        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .lightBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        self.addSubview(collectionView)

        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
extension CLUploadView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  cellModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CLMyOrderCommentCollectionCell", for: indexPath) as! CLMyOrderCommentCollectionCell
    
        
        cell.isAddImage = false

        if indexPath.item + 1  == cellModel.count {
            cell.isAddImage = true
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == cellModel.count - 1 {
            cellModel.insert("1", at: cellModel.count - 1)
            self.collectionView.insertItems(at: [IndexPath(item: cellModel.count - 2, section: 0)])
            self.collectionView.setNeedsLayout()
        }

    }
}
