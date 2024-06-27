//
//  CLDeliverRequestRefundController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/3.
//

import UIKit
import QMUIKit
import SwiftyJSON
import Moya

enum deliverRequestRefund{

    case notice
    case head(_ title:String)
    case goodInfo(_ model:CLOrderGoodsDetailVOList)
    case total
    case refoundCause
    case foodCause
    case deliverCause
    case otherCause
    case uploadImage
    case submitButton
    case topCorner
    case bottomCorner
}
class CLDeliverRequestRefundController: XSBaseViewController{
    
    var cellModel:[deliverRequestRefund] = []
    var arr:[Int] = [] //选中数量
    
    var selectedPhotos = [UIImage]()
    var MaxUploadPicNum = 4
    var model:CLMyOrderListModel?

    var goodModel:[CLOrderGoodsDetailVOList] = []
        
    var uploadCell:CLMyOrderRefundUploadImageCell =  CLMyOrderRefundUploadImageCell()
    var otherCauseCell:CLMyOrderRefundOtherCauseCell = CLMyOrderRefundOtherCauseCell()
    var buttonCell:CLMyOrderRefundButtonCell! = CLMyOrderRefundButtonCell()
    var totalCell:CLOrderRefundMoneyCell = CLOrderRefundMoneyCell()
    var seletedPrice:Double = 0.0
    
    var refundCauseArray:[String] = []
    var foodCauseArray:[String] = []
    var deliverCauseArray:[String] = []
    
    var returnReasonInt:[Int] = []
    var distributionReasonInt:[Int] = []
    var goodsProblemInt:[Int] = []
    var saveOrderReturnGoodsDetailParamList:[[String:Any]] = []
    
    var foodCauseExpand:Bool = false
    var deliverCauseExpand:Bool = false
    
    var foodCauseIndex:Int = 0  //记录食物原因的index
    var deliverCasuseIndex:Int = 0 //记录物流原因的index
    
    var isEnable:Bool = false

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLBottomCornerRadioCell.self)
        $0.register(cellType: CLTopCornerRadioCell.self)
        $0.register(cellType: CLOrderRefundNoticeCell.self)
        $0.register(cellType: CLOrderRefundHeaderCell.self)
        $0.register(cellType: CLOrderRefundGoodCell.self)
        $0.register(cellType: CLOrderRefundMoneyCell.self)
        $0.register(cellType: CLMyOrderRefundCauseCell.self)
        $0.register(cellType: CLMyOrderRefundFoodCauseCell.self)
        $0.register(cellType: CLMyOrderRefundDeliverCauseCell.self)
        $0.register(cellType: CLMyOrderRefundOtherCauseCell.self)
        $0.register(cellType: CLMyOrderRefundUploadImageCell.self)
        $0.register(cellType: CLMyOrderRefundButtonCell.self)
        $0.separatorStyle = .none
    }
    
    private func tableUpdate(_ para:String,_ index:Int){
        if para == "配送不太满意" {
            self.deliverCauseExpand = !self.deliverCauseExpand
            self.tableView.beginUpdates()
            if self.deliverCauseExpand == true {
                self.cellModel.insert(.deliverCause, at: index + (self.foodCauseExpand == true ? 2:1))
                let indexPath = IndexPath(row: index + (self.foodCauseExpand == true ? 2:1), section: 0)
                self.deliverCasuseIndex = index + (self.foodCauseExpand == true ? 2:1) //记录物流原因Index
                self.tableView.insertRows(at: [indexPath], with: .none)
            }else{
//                self.cellModel.removeAll(where:{ $0 == .deliverCause})
                self.cellModel.remove(at: self.deliverCasuseIndex)
                let indexPath = IndexPath(row: self.deliverCasuseIndex, section: 0)
                self.tableView.deleteRows(at: [indexPath], with: .none)
                if foodCauseExpand == true {
                    if self.foodCauseIndex > self.deliverCasuseIndex {
                        foodCauseIndex = foodCauseIndex - 1
                    }
                }
            }
            self.tableView.endUpdates()

        }else if para == "食品问题" {
            self.foodCauseExpand = !self.foodCauseExpand
            self.tableView.beginUpdates()
            if self.foodCauseExpand == true {
                self.cellModel.insert(.foodCause, at: index + (self.deliverCauseExpand == true ? 2:1))
                let indexPath = IndexPath(row: index + (self.deliverCauseExpand  == true ? 2:1), section: 0)
                self.foodCauseIndex = index + (self.deliverCauseExpand == true ? 2:1)
                self.tableView.insertRows(at: [indexPath], with: .none)
            }else{
//                self.cellModel.removeAll(where:{ $0 == .foodCause})
                self.cellModel.remove(at: self.foodCauseIndex)
                let indexPath = IndexPath(row: self.foodCauseIndex, section: 0)
                self.tableView.deleteRows(at: [indexPath], with: .none)
                if self.deliverCauseExpand == true {
                    if self.deliverCasuseIndex > self.foodCauseIndex {
                        self.deliverCasuseIndex = self.deliverCasuseIndex - 1
                    }
                }
            }
            self.tableView.endUpdates()
        }
    }
    
    
    func updateButtonStyle(){
   
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cellModel.append(.notice)
        cellModel.append(.topCorner)
        cellModel.append(.head(self.goodModel[0].merchantName))
        for item in self.goodModel {
            cellModel.append(.goodInfo(item))
            let dic:[String : Any] = ["account":item.goodNum,"goodsId":item.goodsId]
            saveOrderReturnGoodsDetailParamList.append(dic)
        }
//        cellModel.append(.goodInfo)
//        cellModel.append(.goodInfo)
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
    
    
    func uploadImage(){
        if selectedPhotos.count < 0 {
            self.showAlert(title: "提示", message: "请选择图片", alertType: .alert, sureBlock: nil, cancelBlock: nil)
            return
        }
        
        XSTipsHUD.showLoading("正在上传", inView: self.view)
        MerchantInfoProvider.request(.batchUpload(selectedPhotos), model: [TBUploadResultModel].self) { returnData in
            XSTipsHUD.hideAllTips(inView: self.view)

            if let model = returnData {
                let urls = model.map { uploadMoes -> String in
                    return uploadMoes.url
                }
                self.uploadData(urls: urls)
            }
            
        } errorResult: { error in
            uLog(error)
            XSTipsHUD.hideAllTips(inView: self.view)
            XSTipsHUD.showText(error)
        }
        
    }
    
    func uploadData(urls:[String]){
        
        if returnReasonInt.count == 0 {
            self.showAlert(title: "提示", message: "请选择售后原因", alertType: .alert, sureBlock: nil, cancelBlock: nil)
            return  
        }
        
        if returnReasonInt.contains(6) && distributionReasonInt.count == 0 {
            self.showAlert(title: "提示", message: "请选择配送原因", alertType: .alert, sureBlock: nil, cancelBlock: nil)
            return
        }
        
        if returnReasonInt.contains(7) && goodsProblemInt.count == 0 {
            self.showAlert(title: "提示", message: "请选择商品原因", alertType: .alert, sureBlock: nil, cancelBlock: nil)
            return
        }
        
        
        let dic:[String : Any] = [ "returnReasonInt":self.returnReasonInt,
                                   "distributionReasonInt":self.distributionReasonInt,
                                   "goodsProblemInt":self.goodsProblemInt,
                                   "otherAdd":"",
                                   "certificateStr":urls,
                                   "merchantOrderSn":"SJ685577236970995713",
                                   "saveOrderReturnGoodsDetailParamList":self.saveOrderReturnGoodsDetailParamList,
                                   "isSureReturn":true]
        uLog(dic)
        myOrderProvider.request(MyOrderService.saveOrderReturn(dic), completion: { result in
            switch result {
            case let .success(response):
                XSTipsHUD.hideAllTips(inView: self.view)

                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    let jsonObj = jsonData["data"]
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }


             case let .failure(error):
                //网络连接失败，提示用户
                XSTipsHUD.hideAllTips(inView: self.view)
                XSTipsHUD.showText("网络连接失败")
            }
        })
    }
}


extension CLDeliverRequestRefundController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .notice:
            let cell:CLOrderRefundNoticeCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderRefundNoticeCell.self)
            return cell
        case .head(let title):
            let cell:CLOrderRefundHeaderCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderRefundHeaderCell.self)
            cell.shopName.text = title
            return cell
        case .goodInfo(let model):
            let cell:CLOrderRefundGoodCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderRefundGoodCell.self)
            cell.model = model
            cell.addView.clickBlock = {[unowned self] num in
                self.showAlert(title: "温馨提示", message: "最多只能退\(num)件产品", alertType: .alert, sureBlock: nil, cancelBlock: nil)
            }
            cell.addView.addBlock = {[unowned self] in
                model.goodNum += 1
            }
            return cell
        case .total:
            let cell:CLOrderRefundMoneyCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLOrderRefundMoneyCell.self)
            self.totalCell = cell
            return cell
        case .refoundCause:
            let cell:CLMyOrderRefundCauseCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundCauseCell.self)
            cell.clickBlock = {[unowned self] (para,index)in
                if !refundCauseArray.contains(para) {
                    refundCauseArray.append(para)
                    returnReasonInt.append(index)
                }else{
                    refundCauseArray.remove(para)
                    returnReasonInt.remove(index)
                }
                
                self.tableUpdate(para, indexPath.row)

            }
            return cell
        case .foodCause:
            let cell:CLMyOrderRefundFoodCauseCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundFoodCauseCell.self)
            cell.clickBlock = {[unowned self] (para,index) in
                if !foodCauseArray.contains(para) {
                    foodCauseArray.append(para)
                    goodsProblemInt.append(index)
                }else{
                    foodCauseArray.remove(para)
                    goodsProblemInt.remove(index)
                }
            }
            return cell
        case .deliverCause:
            let cell:CLMyOrderRefundDeliverCauseCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundDeliverCauseCell.self)
            cell.clickBlock = {[unowned self] (para,index) in
                if !deliverCauseArray.contains(para){
                    deliverCauseArray.append(para)
                    distributionReasonInt.append(index)
                }else{
                    deliverCauseArray.remove(para)
                    distributionReasonInt.remove(index)

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
            cell.click = {[unowned self] in
                if self.selectedPhotos.count > 0 {
                    self.uploadImage()
                }else{
                    self.uploadData(urls: [])
                }
            }
            self.buttonCell = cell
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
        case .notice:
            return 32
        case .head:
            return 27
        case .goodInfo:
            return 110
        case .total:
            return 54
        case .refoundCause:
            return 400 + 10
        case .foodCause:
            return 270 + 10
        case .deliverCause:
            return 315 + 10
        case .otherCause:
            return 215
        case .uploadImage:
            return 75 + 30
        case .submitButton:
            return 44 + 30
        case .topCorner:
            return 10
        case .bottomCorner:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch cellModel[indexPath.row] {
        case .head:
            let cell = tableView.cellForRow(at: indexPath) as! CLOrderRefundHeaderCell
            cell.select = !cell.select
        
            if cell.select == true {
                self.arr.removeAll() //先清空
                for i in 1...self.goodModel.count {
                    self.arr.append(1) //再增加
                    let index = IndexPath(row: indexPath.row + i, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLOrderRefundGoodCell
                    cell.select = true
                }
                var price = 0.0
                
                for item in self.goodModel {
                    price += item.salePrice
                }
                
                self.seletedPrice = price
                self.totalCell.moneylabel.text = "￥" + String(price)
                
            }else{
                self.arr.removeAll()
                for i in 1...self.goodModel.count {
                    let index = IndexPath(row: indexPath.row + i, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLOrderRefundGoodCell
                    cell.select = false
                }
                self.seletedPrice = 0.0
                self.totalCell.moneylabel.text = "￥0.0"
            }
            
        case .goodInfo(let model):
            let cell = tableView.cellForRow(at: indexPath) as! CLOrderRefundGoodCell
            cell.select = !cell.select
            if cell.select == true {
                self.arr.append(1)
                self.seletedPrice += model.salePrice
                self.totalCell.moneylabel.text = "￥\(self.seletedPrice)"

                if self.arr.count == self.goodModel.count {
                    let index = IndexPath(row:2, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLOrderRefundHeaderCell
                    cell.select = true
                }
  
            }else{
                self.arr.remove(at: 0)
                self.seletedPrice -= model.salePrice
                self.totalCell.moneylabel.text = "￥\(self.seletedPrice)"

                if self.arr.count < self.goodModel.count {
                    let index = IndexPath(row:2, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLOrderRefundHeaderCell
                    cell.select = false
                }
            }
        default:
            break
        }
    }
}
extension CLDeliverRequestRefundController: UICollectionViewDataSource {
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
extension CLDeliverRequestRefundController: UICollectionViewDelegate,XSSelectImgManageDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imgManage = XSSelectImgManage()
        imgManage.delegate = self
        if MaxUploadPicNum <=  0{
            self.showAlert(title: "温馨提示", message: "最多只能选择4张图片", alertType: .alert, sureBlock: nil, cancelBlock: nil)
        }
        
        imgManage.showImagePicker(controller: self, soureType: .XSSelectImgTypeDefault,maxItemCount: self.MaxUploadPicNum - self.selectedPhotos.count)
    }
    
    func XSSelectImgManageFinsh(images: [UIImage]) {
        selectedPhotos.appends(images)
        self.uploadCell.collectionView.reloadData()
    }
    
}
extension CLDeliverRequestRefundController: QMUITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        uLog(textView.text)
        let textLength = textView.text.qmui_lengthWhenCountingNonASCIICharacterAsTwo
        otherCauseCell.desLabel.text = "\(textLength)/140"
    }
}
