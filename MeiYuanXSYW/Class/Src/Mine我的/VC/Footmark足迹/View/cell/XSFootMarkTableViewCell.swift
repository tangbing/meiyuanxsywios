//
//  XSFootMarkTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2021/9/20.
//

import UIKit

class XSFootMarkTableViewCell: XSBaseTableViewCell {
    
    var model:CLUserBrowseRecordModel?{
        didSet{
            
            guard let model = model else { return }
            
            self.goodModel = model.goodsList
            
            self.collectView.reloadData()
        }
    }
    
    var goodModel:[CLGoodListModel] = []

    let cellHeaderId = "sectionHeaderView"

    lazy var collectView : UICollectionView={
         let layout = UICollectionViewFlowLayout()
        /// <##>网格中项目行之间使用的最小间距，水平方向
         layout.minimumLineSpacing = 0
         /// 同一行之间最小间距，垂直间距
         layout.minimumInteritemSpacing = 0
         let itemW:CGFloat = (screenWidth - 20) * 0.5
         let itemH:CGFloat = 65
         layout.itemSize = CGSize(width: itemW, height: itemH)
         layout.scrollDirection = .vertical
         let coll = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
         coll.backgroundColor = .white
         coll.dataSource = self
         coll.delegate = self
         coll.register(cellType: XSFootMarkCollectionViewCell.self)

         return coll
     }()
    
    lazy var headerView: XSFootMarkHeaderView = {
        let iv = XSFootMarkHeaderView.loadFromNib()
        return iv
    }()
    
    
    let containerView : UIView = {
        let iv = UIView()
        iv.hg_setAllCornerWithCornerRadius(radius: 10)
        iv.backgroundColor = .white
        return iv
    }()
    
    func configShopInfoUI() {
        headerView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
    }
    
    func configShopCartUI(){
        configShopInfoUI()
        containerView.snp.remakeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        self.contentView.layoutIfNeeded()
    }
    
    
    override func configUI() {
        self.backgroundColor = UIColor.hex(hexString: "#F6F6F6")
        self.contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        containerView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(34)
        }
        
        containerView.addSubview(collectView)
        collectView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp_bottom).offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalTo(self.contentView.usnp.bottom).offset(-15)
        }
    }
}


extension XSFootMarkTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodModel.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        // 复用SectionHeaderView,SectionHeaderView是xib创建的
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellHeaderId, for: indexPath)
//        headerView.hg_setCornerOnTopWithRadius(radius: 10)
//        return headerView
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: screenWidth, height: 34)
//    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSFootMarkCollectionViewCell.self)
        cell.model = goodModel[indexPath.section]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
    
    
}
