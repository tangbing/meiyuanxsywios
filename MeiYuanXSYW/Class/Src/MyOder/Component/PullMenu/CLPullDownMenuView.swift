//
//  CLPullDownMenuView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/2.
//

import UIKit

class CLPullDownMenuView: TBBaseView {
    
    var clickBlock:((_ para:Int)->())?
    
    var index:Int = 0

    var model = ["全部","外卖","到店","私厨","会员"]
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let title = UILabel().then{
        $0.text = "筛选条件"
        $0.textColor = .text
        $0.font = MYFont(size: 14)
    }
    
    let image = UIImageView().then{
        $0.image = UIImage(named: "mine_arrow_right")
    }
    
    var collectionView:UICollectionView!

    override func configUI() {
        self.backgroundColor = .white
        self.addSubviews(views: [line,title,image])
        
        let layout =  UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: 60, height: 32)
        layout.minimumInteritemSpacing = 25
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CLPullDownMenuCell.self, forCellWithReuseIdentifier: "CLPullDownMenuCell")
        self.addSubview(collectionView)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        line.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(3)
            make.height.equalTo(0.5)
        }
    
        title.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(line.snp.bottom).offset(28)
        }
        
        image.snp.makeConstraints { make in
            make.left.equalTo(title.snp.right)
            make.centerY.equalTo(title.snp.centerY)
        }
        
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-44)
            make.top.equalTo(title.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
        }
        
    }
}
extension CLPullDownMenuView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  model.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CLPullDownMenuCell", for: indexPath) as! CLPullDownMenuCell
        cell.name.setTitle(model[indexPath.item], for: .normal)
//        cell.itemSelected = false
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CLPullDownMenuCell
        cell.name.setTitleColor(.white, for: .normal)
        cell.name.backgroundColor = UIColor.qmui_color(withHexString: "#EFCB9C")
        
        
        
        if indexPath.item != self.index{
            let lastItem = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! CLPullDownMenuCell
            lastItem.name.setTitleColor(.text, for: .normal)
            lastItem.name.backgroundColor = UIColor.qmui_color(withHexString: "#F8F8F8")

            
            self.index = indexPath.item
        }
    
        
        guard let action = self.clickBlock else {
            return
        }
        action(self.index)
    }
}
