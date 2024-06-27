//
//  CLGroupBuyRequestRefundController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/7.
//

import UIKit
import QMUIKit

enum GroupBuyRequestRefund{
    case notice
    case voucherHead  //(团购)
    case voucherInfo
    case topCorner
    case bottomCorner
    case total
    case refoundCause
    case foodCause
    case otherCause
    case uploadImage
    case submitButton
}

class CLGroupBuyRequestRefundController: XSBaseViewController{
    
    var cellModel:[GroupBuyRequestRefund] = []
    var arr:[Int] = [] //选中数量
    var selectedPhotos = [UIImage]()
    let MaxUploadPicNum = 4
    var foodCauseExpand:Bool = false
    var refundCauseArray:[String] = []
    var foodCauseArray:[String] = []


    var uploadCell:CLMyOrderRefundUploadImageCell =  CLMyOrderRefundUploadImageCell()
    var otherCauseCell:CLMyOrderRefundOtherCauseCell = CLMyOrderRefundOtherCauseCell()
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLBottomCornerRadioCell.self)
        $0.register(cellType: CLTopCornerRadioCell.self)
        $0.register(cellType: CLMyOrderRefundGroupBuyHeadCell.self)
        $0.register(cellType: CLMyOrderRefundGroupBuyVoucherCell.self)
        $0.register(cellType: CLGroupBuyRefundReasonCell.self)
        $0.register(cellType: CLMyOrderRefundFoodCauseCell.self)
        $0.register(cellType: CLMyOrderRefundOtherCauseCell.self)
        $0.register(cellType: CLMyOrderRefundUploadImageCell.self)
        $0.register(cellType: CLMyOrderRefundButtonCell.self)
        $0.register(cellType: CLOrderRefundNoticeCell.self)
        $0.register(cellType: CLOrderRefundMoneyCell.self)

        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellModel.append(.notice)
        cellModel.append(.topCorner)
        cellModel.append(.voucherHead)
        cellModel.append(.voucherInfo)
        cellModel.append(.voucherInfo)
        cellModel.append(.bottomCorner)
        cellModel.append(.total)
        cellModel.append(.refoundCause)
        cellModel.append(.otherCause)
        cellModel.append(.uploadImage)
        cellModel.append(.submitButton)

        self.navigationTitle = "申请退款"
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.usnp.top)
            make.bottom.equalTo(self.view.usnp.bottom).offset(-10)
        }

    }
    
    private func tableUpdate(_ para:String,_ index:Int){
        if para == "食品问题"{
            self.foodCauseExpand = !self.foodCauseExpand
            self.tableView.beginUpdates()
            if self.foodCauseExpand == true {
                self.cellModel.insert(.foodCause, at: index + 1)
                let indexPath = IndexPath(row: index + 1, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .none)
            }else{
                self.cellModel.removeAll(where:{ $0 == .foodCause})
                self.cellModel.remove(at: 1)
                let indexPath = IndexPath(row: index + 1, section: 0)
                self.tableView.deleteRows(at: [indexPath], with: .none)
            }
            self.tableView.endUpdates()
        }
    }
}


extension CLGroupBuyRequestRefundController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .notice:
            let cell:CLOrderRefundNoticeCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderRefundNoticeCell.self)
            return cell
        case .total:
            let cell:CLOrderRefundMoneyCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderRefundMoneyCell.self)
            return cell
        case .refoundCause:
            let cell:CLGroupBuyRefundReasonCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLGroupBuyRefundReasonCell.self)
            cell.clickBlock = {[unowned self] para in
                if !refundCauseArray.contains(para) {
                    refundCauseArray.append(para)
                }else{
                    refundCauseArray.remove(para)
                }
                self.tableUpdate(para, indexPath.row)
            }
            return cell
        case .foodCause:
            let cell:CLMyOrderRefundFoodCauseCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundFoodCauseCell.self)
            cell.clickBlock = {[unowned self] (para,index) in
                if !foodCauseArray.contains(para) {
                    foodCauseArray.append(para)
                }else{
                    foodCauseArray.remove(para)
                }
            }
            return cell
        case .otherCause:
            let cell:CLMyOrderRefundOtherCauseCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundOtherCauseCell.self)
            self.otherCauseCell = cell
            cell.reasonTextView.delegate = self
            return cell
        case .uploadImage:
            let cell:CLMyOrderRefundUploadImageCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundUploadImageCell.self)
            self.uploadCell = cell
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            return cell
        case .submitButton:
            let cell:CLMyOrderRefundButtonCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundButtonCell.self)
            return cell
        case .voucherHead:
            let cell:CLMyOrderRefundGroupBuyHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundGroupBuyHeadCell.self)
            return cell
        case .voucherInfo:
            let cell:CLMyOrderRefundGroupBuyVoucherCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundGroupBuyVoucherCell.self)
            return cell
        case .topCorner:
            let cell:CLTopCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLTopCornerRadioCell.self)
            return cell
        case .bottomCorner:
            let cell:CLBottomCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLBottomCornerRadioCell.self)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        //外卖
        case .refoundCause:
            return 360 + 10
        case .otherCause:
            return 215
        case .foodCause:
            return 270 + 10
        case .uploadImage:
            return 75 + 30
        case .submitButton:
            return 44 + 30
        case .voucherHead:
            return 27
        case .voucherInfo:
            return 75
        case .topCorner:
            return 10
        case .bottomCorner:
            return 10
        case .notice:
            return 32
        case .total:
            return 54
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellModel[indexPath.row] {
        case .voucherHead:
            let cell = tableView.cellForRow(at: indexPath) as! CLMyOrderRefundGroupBuyHeadCell
            cell.select = !cell.select
        
            if cell.select == true {
                self.arr.removeAll() //先清空
                for i in 1...2 {
                    self.arr.append(1) //再增加
                    let index = IndexPath(row: indexPath.row + i, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLMyOrderRefundGroupBuyVoucherCell
                    cell.select = true
                }
                
            }else{
                self.arr.removeAll()
                for i in 1...2 {
                    let index = IndexPath(row: indexPath.row + i, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLMyOrderRefundGroupBuyVoucherCell
                    cell.select = false
                }
            }
            
        case .voucherInfo:
            let cell = tableView.cellForRow(at: indexPath) as! CLMyOrderRefundGroupBuyVoucherCell
            cell.select = !cell.select
            if cell.select == true {
                self.arr.append(1)
                if self.arr.count == 2 {
                    let index = IndexPath(row:2, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLMyOrderRefundGroupBuyHeadCell
                    cell.select = true
                }
            }else{
                self.arr.remove(at: 0)
                if self.arr.count < 2 {
                    let index = IndexPath(row:2, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLMyOrderRefundGroupBuyHeadCell
                    cell.select = false
                }
            }
        default:
            break
        }
    }
}
extension CLGroupBuyRequestRefundController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (selectedPhotos.count >=  MaxUploadPicNum ) {
            return selectedPhotos.count;
        }
        return selectedPhotos.count + 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CLMyOrderCommentCollectionCell", for: indexPath) as! CLMyOrderCommentCollectionCell
        cell.deleteBlock = { [unowned self] idx in
            selectedPhotos.remove(at: idx)
            self.uploadCell.collectionView.reloadData()
        }
        
        if indexPath.item == selectedPhotos.count {
            cell.isAddImage = true
        }else{
            cell.isAddImage = false
            cell.image.image = selectedPhotos[indexPath.item]

        }
        cell.tagIdx = indexPath.item
        return cell
    }

}
extension CLGroupBuyRequestRefundController: UICollectionViewDelegate,XSSelectImgManageDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imgManage = XSSelectImgManage()
        imgManage.delegate = self
        imgManage.showImagePicker(controller: self, soureType: .XSSelectImgTypeDefault,maxItemCount: self.MaxUploadPicNum - self.selectedPhotos.count)
    }
    
    func XSSelectImgManageFinsh(images: [UIImage]) {
        selectedPhotos.appends(images)
        self.uploadCell.collectionView.reloadData()
    }
    
}
extension CLGroupBuyRequestRefundController: QMUITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        uLog(textView.text)
        let textLength = textView.text.qmui_lengthWhenCountingNonASCIICharacterAsTwo
        otherCauseCell.desLabel.text = "\(textLength)/140"
    }
}
