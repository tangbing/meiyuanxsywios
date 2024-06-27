//
//  TBMerchInfoConpainUploadPicCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/10.
//

import UIKit
import QMUIKit


class TBMerchInfoCompainUploadPicCell: XSBaseTableViewCell {

    var selectPicCompleteBlock: ((_ selectedPhotos: [UIImage]) -> Void)?
    private let uploadPicNumInRow: CGFloat = 4
    let maxUploadPicNum = 6
    weak var superVc: XSBaseViewController?
    
    var selectedPhotos = [UIImage]()
    
    private lazy var uploadPicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth: CGFloat = 85.0
//        let itemLineSpaceing: CGFloat = ((screenWidth - 20) - uploadPicNumInRow * itemWidth) / (CGFloat)(uploadPicNumInRow - 1)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: XSUploadPicCollectionViewCell.self)

        return collectionView
    }() 
    
    override func configUI() {
        super.configUI()
        self.contentView.hg_setAllCornerWithCornerRadius(radius: 10)
        
        
        self.contentView.addSubview(uploadPicCollectionView)
        uploadPicCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension TBMerchInfoCompainUploadPicCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (selectedPhotos.count >=  maxUploadPicNum ) {
            return selectedPhotos.count;
        }
        return selectedPhotos.count + 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSUploadPicCollectionViewCell.self)
        if indexPath.item == selectedPhotos.count {
            cell.picImagView.image = #imageLiteral(resourceName: "mine_upload_add")
            cell.deleteButton.isHidden = true
            cell.msgLabel.isHidden = false
        } else {
            cell.picImagView.image = selectedPhotos[indexPath.item]
            cell.deleteButton.isHidden = false
            cell.msgLabel.isHidden = true
        }
        cell.msgLabel.text = "上传图片最多\(maxUploadPicNum)张"
        cell.tagIdx = indexPath.item
        cell.delegate = self
        return cell
    }

}

extension TBMerchInfoCompainUploadPicCell: UICollectionViewDelegate,XSSelectImgManageDelegate,XSUploadPicCollectionViewCellDeleDelegate {
    func deleteIndexOfPic(idx: NSInteger) {
        selectedPhotos.remove(at: idx)
        uploadPicCollectionView.reloadData()
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let superViewController = self.superVc else {
            return
        }
        let imgManage = XSSelectImgManage()
        imgManage.delegate = self
        imgManage.showImagePicker(controller: superViewController, soureType: .XSSelectImgTypeDefault,maxItemCount: maxUploadPicNum - selectedPhotos.count)
    }
    
    func XSSelectImgManageFinsh(images: [UIImage]) {
        selectedPhotos.appends(images)
        uploadPicCollectionView.reloadData()
        selectPicCompleteBlock?(selectedPhotos)
    }
    
}

