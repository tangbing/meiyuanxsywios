//
//  CLMyOrderCommentController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/25.
//

import UIKit
import Moya
import SwiftyJSON


enum MyOrderComment{
    case groupTop(merchantLog:String,merchantName:String)
    case deleverTop(merchantLog:String,merchantName:String)
    case like(item:CLGoodsDetailList)
    case button
}

class CLMyOrderCommentController: XSBaseViewController {
    
    var cellModel:[MyOrderComment] = []
    var model:CLOrderCommentModel?
    var finishModel:[CLOtherGetCommentVOList] = []
    var selectedPhotos = [UIImage]()
    let MaxUploadPicNum = 9
    var viewHeight:CGFloat = 0.0
    var deleverCell:CLMyOrderCommentCell = CLMyOrderCommentCell()
    var groupCell:CLMyOrderCommentGroupCell = CLMyOrderCommentGroupCell()
    

    ///参数
    var merchantOrderSn:String = "" //订单号
    var packComment:CGFloat = 0.0  //包装评分
    var serviceComment:CGFloat = 0.0 //服务评分
    var tasteComment :CGFloat = 0.0  // 口味评分
    var totalComment:CGFloat = 0.0   //总体评分
    var environmentComment:CGFloat = 0.0 //环境评分
    var userComment:String = ""
    var saveOrderCommentGoodsParamList:[[String:Any]] = []

    var bizType:String = "0"
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderCommentCell.self)
        $0.register(cellType: CLMyOrderCommentGroupCell.self)
        $0.register(cellType: CLMyOrderLikeCell.self)
        $0.register(cellType: CLMyOrderCommentFinishButtonCell.self)
        
        $0.separatorStyle = .none
    }
    
    
    func uploadImage(){
        if selectedPhotos.count < 0 {
            self.showAlert(title: "提示", message: "请选择图片", alertType: .alert, sureBlock: nil, cancelBlock: nil)
            return
        }
        
        XSTipsHUD.showLoading("正在上传", inView: self.view)
        MerchantInfoProvider.request(.batchUpload(selectedPhotos), model: [TBUploadResultModel].self) { returnData in
            if let model = returnData {
                let urls = model.map { uploadMoes -> String in
                    return uploadMoes.url
                }
                self.upload(urls: urls)
            }
            
        } errorResult: { error in
            uLog(error)
            XSTipsHUD.showText(error)
        }
        
    }
    
    func loadData(){
        let dic = ["merchantOrderSn":"SJ685577236970995713"]
        myOrderProvider.request(MyOrderService.getCommentData(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    let jsonObj = jsonData["data"]

                    self.model = CLOrderCommentModel(jsonData: jsonObj)
                    
                    DispatchQueue.main.async {
                        if self.bizType == "1" {
                            self.cellModel.append(.groupTop(merchantLog: self.model!.merchantLog, merchantName: self.model!.merchantName))
                        }else{
                            self.cellModel.append(.deleverTop(merchantLog: self.model!.merchantLog, merchantName: self.model!.merchantName))
                        }
                        
                        for item in self.model!.goodsDetailList {
                            self.cellModel.append(.like(item: item))
                            self.saveOrderCommentGoodsParamList.append(["goodsId":item.goodsId,"goodsName":item.goodsName,"status":2])
                        }
                    
                        self.cellModel.append(.button)
                        
                        self.tableView.reloadData()
                    }

                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

    
             case let .failure(error):
                //网络连接失败，提示用户
                print("网络连接失败\(error)")
            }
        }
    }
    
    
    func upload(urls:[String]){
        
        if bizType == "0" {
            self.userComment = deleverCell.textField.text

            if self.totalComment == 0.0 {
                XSTipsHUD.showText("请为商家星级打分!")
                return
            }
            
            if self.tasteComment == 0.0 {
                XSTipsHUD.showText("您还未对口味打分!")
                return
            }
            
            if self.packComment == 0.0 {
                XSTipsHUD.showText("您还未对包装打分!")
                return
            }

        }else if bizType == "1" {
            self.userComment = groupCell.textField.text
            
            if self.totalComment == 0.0 {
                XSTipsHUD.showText("请为商家星级打分!")
                return
            }
            
            if self.tasteComment == 0.0 {
                XSTipsHUD.showText("您还未对口味打分!")
                return
            }
            
            if self.environmentComment == 0.0 {
                XSTipsHUD.showText("您还未对环境打分!")
                return
            }
            
            if self.serviceComment == 0.0 {
                XSTipsHUD.showText("您还未对服务打分!")
                return
            }
        }else{
            self.userComment = deleverCell.textField.text

            if self.totalComment == 0.0 {
                XSTipsHUD.showText("请为商家星级打分!")
                return
            }
            
            if self.tasteComment == 0.0 {
                XSTipsHUD.showText("您还未对口味打分!")
                return
            }
            
            if self.serviceComment == 0.0 {
                XSTipsHUD.showText("您还未对服务打分!")
                return
            }
        }
        
        
        let dic:[String:Any] = ["commentPicStr":urls,
                                "environmentComment":self.environmentComment,
                                "merchantOrderSn":"SJ685577236970995713",
                                "packComment":packComment,
                                "serviceComment":serviceComment,
                                "tasteComment":tasteComment,
                                "totalComment":totalComment,
                                "userComment":self.userComment,
                                "saveOrderCommentGoodsParamList":self.saveOrderCommentGoodsParamList]
        uLog(dic)
        myOrderProvider.request(MyOrderService.saveComment(dic)) { result in
            switch result {
            case let .success(response):
                XSTipsHUD.hideAllTips(inView: self.view)

                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }

                if  jsonData["resp_code"].intValue == 0{
                    
                    self.finishModel = jsonData["data"]["otherGetCommentVOList"].arrayValue.compactMap{
                        CLOtherGetCommentVOList(jsonData: $0)
                    }
                    let vc = CLMyOrderCommetFinishController()
                    vc.model = self.finishModel
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

    
             case let .failure(error):
                //网络连接失败，提示用户
                XSTipsHUD.hideAllTips(inView: self.view)
                XSTipsHUD.showText("网络连接失败")
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        self.loadData()

        
        self.title = "订单评价"
        self.view.backgroundColor = .lightBackground
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.usnp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.usnp.bottom).offset(-20)
        }
    }

}

extension CLMyOrderCommentController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .deleverTop(let merchantLog,let merchantName):
            let cell:CLMyOrderCommentCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderCommentCell.self)
            self.userComment = cell.textField.text
            cell.rateBlock = {[unowned self] tag,para in
                if tag == 1001 {
                    self.totalComment = para
                }else if tag == 1002 {
                    self.tasteComment = para
                }else{
                    self.packComment = para
                }
            }
            cell.shopImage.xs_setImage(urlString: merchantLog)
            cell.shopName.text = merchantName
            self.deleverCell = cell
            deleverCell.collectionView.delegate = self
            deleverCell.collectionView.dataSource = self
            return cell
        case .groupTop(let merchantLog,let merchantName):
            let cell:CLMyOrderCommentGroupCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderCommentGroupCell.self)
            self.userComment = cell.textField.text

            cell.rateBlock = {[unowned self] tag,para in
                if tag == 1001 {
                    self.totalComment = para
                }else if tag == 1002 {
                    self.tasteComment = para
                }else if tag == 1004{
                    self.environmentComment = para
                }else if tag == 1005{
                    self.serviceComment = para
                }
            }
            cell.shopImage.xs_setImage(urlString: merchantLog)
            cell.shopName.text = merchantName
            self.groupCell = cell
            groupCell.collectionView.delegate = self
            groupCell.collectionView.dataSource = self
            return cell

        case .like(let item):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderLikeCell.self)
            cell.goodName.text = item.goodsName
            cell.goodImage.xs_setImage(urlString: item.topPic)
            cell.clickBlock = {[unowned self] (boo1,boo2) in
                if boo1 == false ,boo2 == false {
                    for (i,goodItem) in self.saveOrderCommentGoodsParamList.enumerated() {
                        if goodItem["goodsId"] as! String == item.goodsId {
                            self.saveOrderCommentGoodsParamList[i]["status"] = 2
                        }
                    }
                }else if boo1 == true {
                    for (i,goodItem) in self.saveOrderCommentGoodsParamList.enumerated() {
                        if goodItem["goodsId"] as! String == item.goodsId {
                            self.saveOrderCommentGoodsParamList[i]["status"] = 0
                        }
                    }
                }else if boo2 == true{
                    for (i,goodItem) in self.saveOrderCommentGoodsParamList.enumerated() {
                        if goodItem["goodsId"] as! String == item.goodsId {
                            self.saveOrderCommentGoodsParamList[i]["status"] = 1
                        }
                    }
                }
            }
            return cell
        case .button:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderCommentFinishButtonCell.self)
            cell.commitButton.setTitle("提交评价", for: .normal)
            cell.clickBlock = {[unowned self] in
                if self.selectedPhotos.count > 0 {
                    self.uploadImage()
                }else{
                    self.upload(urls: [])
                }
            }
            return cell
        }

    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row] {
        case .groupTop:
            return 415 + CGFloat((self.selectedPhotos.count/4) * 80) + 40
        case .deleverTop:
            return 415 + CGFloat((self.selectedPhotos.count/4) * 80)
        case .like:
            return 38
        case .button:
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}
extension CLMyOrderCommentController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (selectedPhotos.count >=  MaxUploadPicNum ) {
            return selectedPhotos.count;
        }
        return selectedPhotos.count + 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CLMyOrderCommentCollectionCell", for: indexPath) as! CLMyOrderCommentCollectionCell
        cell.deleteBlock = { [unowned self] idx in
            self.selectedPhotos.remove(at: idx)
            
            self.viewHeight = CGFloat((self.selectedPhotos.count/4)*85)
            self.tableView.reloadData()
            if bizType == "1" {
                self.groupCell.collectionView.reloadData()
            }else{
                self.deleverCell.collectionView.reloadData()
            }
            
        }
        if indexPath.item == selectedPhotos.count {
            cell.isAddImage = true
        }else{
            cell.isAddImage = false
            cell.image.image = selectedPhotos[indexPath.row]
        }
        cell.tagIdx = indexPath.item
        return cell
    }

}
extension CLMyOrderCommentController: UICollectionViewDelegate,XSSelectImgManageDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imgManage = XSSelectImgManage()
        imgManage.delegate = self
        imgManage.showImagePicker(controller: self, soureType: .XSSelectImgTypeDefault,maxItemCount: MaxUploadPicNum - selectedPhotos.count)
    }
    
    func XSSelectImgManageFinsh(images: [UIImage]) {
        selectedPhotos.appends(images)
        
        self.tableView.reloadData()
        if bizType == "1" {
            self.groupCell.collectionView.reloadData()
        }else {
            self.deleverCell.collectionView.reloadData()

        }
        
    }
    
}

