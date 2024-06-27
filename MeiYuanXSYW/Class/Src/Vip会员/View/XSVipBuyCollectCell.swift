//
//  XSVipBuyCollectCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit
import QMUIKit
import JKSwiftExtension
/// 添加cell点击代理方法
protocol XSVipBuyCollectCellDelegate:NSObjectProtocol {
    func clickHeaderCate(dict:[String: String])
}

class XSVipBuyCollectCell: XSBaseTableViewCell {
    weak var delegate : XSVipBuyCollectCellDelegate?
    
    var selectBlock:((_ dic:[String:String])->())?

    var lastItem:Int = 0
    
    var collectView : UICollectionView={
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        let itemW = (screenWidth-60)/3
        let itemH:CGFloat = itemW*1.2
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .horizontal
        let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        coll.backgroundColor = .white
        coll.register(cellType: XSVipBuyCollectItem.self)

        return coll
    }()

    var dataSource = [
        ["title":"月卡","price":"15","sprice":"20","seal":"无门槛"],
        ["title":"季卡","price":"45","sprice":"60","seal":"每月仅12元"],
        ["title":"年卡","price":"120","sprice":"180","seal":"每月仅10元"]
    ] {
        didSet{
            self.collectView.reloadData()
        }
    }
    

    override func configUI() {
        contentView.backgroundColor = .white
        collectView.delegate = self
        collectView.dataSource = self
        contentView.addSubview(collectView)
        collectView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(15)
            make.bottom.equalTo(-10)
        }
    }
    
}

extension XSVipBuyCollectCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:XSVipBuyCollectItem = collectionView.dequeueReusableCell(for: indexPath, cellType: XSVipBuyCollectItem.self)
    
        let dict: [String: String] = dataSource[indexPath.row]
        cell.view.nameLab.text = dict["title"]
        cell.view.priceLab.text = "¥".appending(dict["price"] ?? "")
        cell.view.priceLab.jk.setsetSpecificTextFont("¥", font:MYBlodFont(size: 16))
        cell.view.priceSLab.text = "¥".appending(dict["sprice"] ?? "")
        cell.view.priceSLab.jk.setSpecificTextDeleteLine("¥".appending(dict["sprice"] ?? ""), color: .fourText)
        cell.view.tipLab.text = dict["seal"]
        
        if indexPath.item == 0 {
            cell.view.ticketBackImg.image = UIImage(named: "vip_buy_car_bg")

        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lastCell = collectionView.cellForItem(at: IndexPath(item: self.lastItem, section: indexPath.section)) as! XSVipBuyCollectItem
        lastCell.view.ticketBackImg.image = UIImage(named: "vip_buy_car_bg2")
        
        
        let cell = collectionView.cellForItem(at: IndexPath(item: indexPath.item, section: indexPath.section)) as! XSVipBuyCollectItem
        cell.view.ticketBackImg.image = UIImage(named: "vip_buy_car_bg")
        
        self.lastItem = indexPath.item
        
        guard let action = self.selectBlock else { return }
        action(dataSource[indexPath.item])
    
    }
}
