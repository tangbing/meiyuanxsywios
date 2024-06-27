//
//  CLMyOrderContactCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/24.
//

import UIKit
import Kingfisher

class CLMyOrderDetailContactCell: XSBaseTableViewCell {

    var clickBlock:((_ para:String)->())?

    var model  =   [
               ["title":"修改地址","image":"edit"],
               ["title":"取消订单","image":"close"],
               ["title":"联系商家","image":"right"],
               ["title":"客服","image":"customer_service"]
    ]{
        didSet{
            self.collectionView.reloadData()
        }
    }



    let baseView = UIView().then{
        $0.backgroundColor  = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    var collectionView:UICollectionView!

    override func configUI() {
        self.contentView.backgroundColor = UIColor.lightBackground
        
        let layout =  UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: (screenWidth - 20)/5, height: 80)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CLMyOrderDetailContactCollectView.self, forCellWithReuseIdentifier: "CLMyOrderDetailContactCollectView")

        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.contentView.addSubview(baseView)
        baseView.addSubview(collectionView)
        
        baseView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
    
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
extension CLMyOrderDetailContactCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  model.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CLMyOrderDetailContactCollectView", for: indexPath) as! CLMyOrderDetailContactCollectView
        cell.image.image = UIImage(named: model[indexPath.item]["image"]!)
        cell.name.text = model[indexPath.item]["title"]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let action = self.clickBlock else {
            return
        }
        action(self.model[indexPath.item]["title"]!)
    }
}
