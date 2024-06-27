//
//  XSHomHeaderJGTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/24.
//

import UIKit


protocol XSHomHeaderJGTableViewCellDelegate: NSObjectProtocol {
    func homeHeaderJGClick(_ tableViewCell: XSHomHeaderJGTableViewCell, click itemModel: KingkongDetal)
}


class XSHomHeaderJGTableViewCell: XSBaseXIBTableViewCell {
    
    var listData: [KingkongDetal] = [KingkongDetal(name: "美界美食", loacalIcon: "home_food world"),
                                     KingkongDetal(name: "摊上小市", loacalIcon: "home_ stand on the market"),
                                     KingkongDetal(name: "上门私厨", loacalIcon: "home_private kitchen"),
                                     KingkongDetal(name: "养生餐", loacalIcon: "home_health food"),
                                     KingkongDetal(name: "营养餐", loacalIcon: "home_nutritious meal"),
                                     KingkongDetal(name: "美食外卖", loacalIcon: "home_food takeout"),
                                     KingkongDetal(name: "美食团购", loacalIcon: "切片备份 2"),
                                     KingkongDetal(name: "健康美食", loacalIcon: "home_healthy food"),
                                     KingkongDetal(name: "大厨教学", loacalIcon: "home_Chef teaching"),
                                     KingkongDetal(name: "本地生活", loacalIcon: "home_local life")] {
        didSet {
            jinganCollectionView.reloadData()
        }
    }
    
    var delegate: XSHomHeaderJGTableViewCellDelegate?
    
    @IBOutlet weak var jinganCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let layout = UICollectionViewFlowLayout()
        let itemW:CGFloat = (screenWidth - 46) / 5
        let itemH:CGFloat = 70
        let spacing: CGFloat = 0
            //((screenWidth - 46) - (45 * 5)) / 4
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = spacing
       
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.scrollDirection = .vertical
        jinganCollectionView.backgroundColor = .clear
        jinganCollectionView.collectionViewLayout = layout
        jinganCollectionView.register(cellType: XSHeaderJGCollectionViewCell.self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.hg_setAllCornerWithCornerRadius(radius: 10)
    }
}

extension XSHomHeaderJGTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSHeaderJGCollectionViewCell.self)
        let data = listData[indexPath.item]
        cell.headerJGLabel.text = data.name
        if data.icon.isEmpty {
            cell.headerJGImageView.image = UIImage(named: data.loacalIcon)
        } else {
            cell.headerJGImageView.xs_setImage(urlString: data.icon, placeholder: UIImage.placeholder)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = listData[indexPath.item]
        delegate?.homeHeaderJGClick(self, click: data)
    }
    
}
