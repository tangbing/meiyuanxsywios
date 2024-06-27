//
//  XSShopCartSectionViewModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import Foundation
import UIKit


protocol XSShopCartSectionViewModelDelegate: NSObject {
    func onFetchComplete(datas sections: [XSShopCartSectionViewModel], isNomoreData: Bool)
    func onFetchFailed(with reason: String)
}

class XSShopCartSectionViewModel: NSObject {
    public var sectionHeaderTitle: String?
    var sections = [XSShopCartSectionViewModel]()
    weak var delegate: XSShopCartSectionViewModelDelegate?

    public var cellViewModels: [XSShopCartModelProtocol] = [XSShopCartModelProtocol]()

    init(cellViewModels: [XSShopCartModelProtocol]) {
        self.cellViewModels = cellViewModels
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    /*
    func fetchData(){
        sections.removeAll()
        
        let delieve0 = XSShopCartInfoTopModel(isLoseTime: false, signalTitle: "外卖", hasTopRadius: true)
        let delieve1 = XSShopCartDelieveModel(isLoseTime: false)
        let delieve11 = XSShopCartDelieveModel(isLoseTime: false, hasBottomRadius: false)
        let balance = XSShopCartBalanceOrderModel(hasTopRadius: false, hasBottomRadius: true)

        
        let vm1 = XSShopCartSectionViewModel(cellViewModels: [delieve0,delieve1,delieve11,balance])

        sections.append(vm1)
        
        
        let top1 = XSShopCartInfoTopModel(isLoseTime: false , signalTitle: "到店", hasTopRadius: true)
        let groupBuy1 = XSShopCartGroupBuyModel(isLoseTime: false)
        let groupBuy2 = XSShopCartGroupBuyModel(isLoseTime: false, hasBottomRadius: false)
        let outBounds = XSShopCartOutBoundsModel(hasTopRadius: false, hasBottomRadius: true)
        let vm2 = XSShopCartSectionViewModel(cellViewModels: [top1,groupBuy1,groupBuy2, outBounds])
        sections.append(vm2)
        
        
        let top10 = XSShopCartInfoTopModel(isLoseTime: false , signalTitle: "私厨", hasTopRadius: true)
        let groupBuy10 = XSShopCartPrivateKitchenModel(isLoseTime: false)
        
        let groupBuy101 = XSShopCartPrivateKitchenModel(isLoseTime: false, hasTicket: false)
        let groupBuy102 = XSShopCartPrivateKitchenModel(isLoseTime: false, hasSelectRule: true)
        
        let groupBuy20 = XSShopCartPrivateKitchenModel(isLoseTime: false, hasBottomRadius: true)
        let vm22 = XSShopCartSectionViewModel(cellViewModels: [top10,groupBuy10,groupBuy101,groupBuy102,groupBuy20])
        sections.append(vm22)
        
        
        let loseTop1 = XSShopCartInfoTopModel(isLoseTime: true , signalTitle: "外卖", hasTopRadius: true)
        let loseDev1 = XSShopCartDelieveModel(isLoseTime: true)
        let loseDev2 = XSShopCartDelieveModel(isLoseTime: true , hasBottomRadius: true)
        let vm3 = XSShopCartSectionViewModel(cellViewModels: [loseTop1,loseDev1,loseDev2])
        vm3.sectionHeaderTitle = "失效宝贝"
        sections.append(vm3)
        
        
        let loseTop2 = XSShopCartInfoTopModel(isLoseTime: true, signalTitle: "到店", hasTopRadius: true)
        let loseGroupBuy1 = XSShopCartGroupBuyModel(isLoseTime: true)
        let loseGroupBuy2 = XSShopCartGroupBuyModel(isLoseTime: true , hasBottomRadius: true)
        let vm4 = XSShopCartSectionViewModel(cellViewModels: [loseTop2,loseGroupBuy1,loseGroupBuy2])
        sections.append(vm4)
        
        let recommand = XSShopCartRecommendModel()
        let vm5 = XSShopCartSectionViewModel(cellViewModels: [recommand])
        vm5.sectionHeaderTitle = "大家都在买"
        sections.append(vm5)
        
        

    }
        sections.removeAll()
        self.cellViewModels.removeAll()
        super.init()
    }
    */
    func fetchShopCartData(_ bizType: Int?, isEfficacy: Bool, lat: Double, lng: Double,page: Int, pageSize: Int) {
        
        // 1.创建任务组
        let queueGroup = DispatchGroup()
       //2.获取购物车有效数据
       queueGroup.enter()
        
        let isMoreData = false
        self.sections.removeAll()
        self.cellViewModels.removeAll()
        
        MerchantInfoProvider.request(.getOrderShoppingVOByUserId(bizType, isEfficacy: true, lat: lat, lng: lon, page: page, pageSize: pageSize), model: XSShopCartModel.self) { returnData in
            
           
            guard let shopCartModel = returnData,
                  shopCartModel.code == 0 else {
                return
            }
            //self.sections.removeAll()
            
//            if page == 1 {
//                self.sections.removeAll()
//                self.cellViewModels.removeAll()
//                isMoreData = shopCartModel.data.count >= shopCartModel.count
//            } else {
//                isMoreData = shopCartModel.data.count >= shopCartModel.count
//            }

            self.spliteData(shopCartModel, isNomoreData: isMoreData)
            queueGroup.leave()
        } errorResult: { errorMsg in
            print(errorMsg)
            self.delegate?.onFetchFailed(with: errorMsg)
            XSTipsHUD.showText(errorMsg)
            queueGroup.leave()
        }
        
        //2.获取购物车无效数据
        queueGroup.enter()
         
         MerchantInfoProvider.request(.getOrderShoppingVOByUserId(bizType, isEfficacy: false, lat: lat, lng: lon, page: page, pageSize: pageSize), model: XSShopCartModel.self) { returnData in
             
             //let isMoreData = false
             guard let shopCartModel = returnData,
                   shopCartModel.code == 0 else {
                 return
             }
             //self.sections.removeAll()
             
 //            if page == 1 {
 //                self.sections.removeAll()
 //                self.cellViewModels.removeAll()
 //                isMoreData = shopCartModel.data.count >= shopCartModel.count
 //            } else {
 //                isMoreData = shopCartModel.data.count >= shopCartModel.count
 //            }

             self.spliteData(shopCartModel, isNomoreData: isMoreData)
             queueGroup.leave()
             
         } errorResult: { errorMsg in
             print(errorMsg)
             self.delegate?.onFetchFailed(with: errorMsg)
             XSTipsHUD.showText(errorMsg)
             queueGroup.leave()
         }
        
        queueGroup.notify(qos: .default, flags: [], queue: .main) {
            self.delegate?.onFetchComplete(datas: self.sections, isNomoreData: isMoreData)
        }

    }
    
    func spliteData(_ shopCartModel: XSShopCartModel, isNomoreData: Bool = false) {
          
        guard shopCartModel.data.count > 0 else {
            return
        }
        
        for (_,shopCartDataModel) in shopCartModel.data.enumerated() {
            
            let vm = XSShopCartSectionViewModel()
            
            var signalTitle = "到店"
            if shopCartDataModel.bizType == 1 {
                signalTitle = "私厨"
            } else if(shopCartDataModel.bizType == 0) {
                signalTitle = "外卖"
            }
            
            
            let infoTop = XSShopCartInfoTopModel(cellState:shopCartDataModel.cellState,signalTitle: signalTitle , dataModel: shopCartDataModel, hasTopRadius: true)
           
            vm.cellViewModels.append(infoTop)
            vm.sectionHeaderTitle =  shopCartDataModel.cellState == .loseTime ? "失效宝贝" : nil
            
            shopCartDataModel.orderShoppingTrolleyVOList?.forEach({ cartModel in
                // 业务类型，0外卖，1私厨，2团购
                if cartModel.bizType == 0 {
                    let hasSelectStandart = !cartModel.specId.isEmpty && cartModel.attributesIdDetails.count > 0

                    let delieve = XSShopCartDelieveModel(cellState:shopCartDataModel.cellState, orderShoppingTrolleyVOList: cartModel, hasSelectStandard: hasSelectStandart)
                    vm.cellViewModels.append(delieve)


                } else if(cartModel.bizType == 2) {
                    let group = XSShopCartGroupBuyModel(cellState: shopCartDataModel.cellState, orderShoppingTrolleyVOList: cartModel)
                    vm.cellViewModels.append(group)
                } else if(cartModel.bizType == 1) {
                    let hasSelectStandart = !cartModel.specId.isEmpty && cartModel.attributesIdDetails.count > 0
                    
                    let privateKitch = XSShopCartPrivateKitchenModel(cellState: shopCartDataModel.cellState, orderShoppingTrolleyVOList: cartModel, hasSelectRule: hasSelectStandart)
                    vm.cellViewModels.append(privateKitch)

                }
            })
            
            sections.append(vm)
           
        }
        
    }
    
    
//    func fetchData(){
//        sections.removeAll()
//
//        let delieve0 = XSShopCartInfoTopModel(isLoseTime: false, signalTitle: "外卖", hasTopRadius: true)
//        let delieve1 = XSShopCartDelieveModel(isLoseTime: false)
//        let delieve11 = XSShopCartDelieveModel(isLoseTime: false, hasBottomRadius: false)
//        let balance = XSShopCartBalanceOrderModel(hasTopRadius: false, hasBottomRadius: true)
//
//
//        let vm1 = XSShopCartSectionViewModel(cellViewModels: [delieve0,delieve1,delieve11,balance])
//
//        sections.append(vm1)
//
//
//        let top1 = XSShopCartInfoTopModel(isLoseTime: false , signalTitle: "到店", hasTopRadius: true)
//        let groupBuy1 = XSShopCartGroupBuyModel(isLoseTime: false)
//        let groupBuy2 = XSShopCartGroupBuyModel(isLoseTime: false, hasBottomRadius: false)
//        let outBounds = XSShopCartOutBoundsModel(hasTopRadius: false, hasBottomRadius: true)
//        let vm2 = XSShopCartSectionViewModel(cellViewModels: [top1,groupBuy1,groupBuy2, outBounds])
//        sections.append(vm2)
//
//
//        let top10 = XSShopCartInfoTopModel(isLoseTime: false , signalTitle: "私厨", hasTopRadius: true)
//        let groupBuy10 = XSShopCartPrivateKitchenModel(isLoseTime: false)
//
//        let groupBuy101 = XSShopCartPrivateKitchenModel(isLoseTime: false, hasTicket: false)
//        let groupBuy102 = XSShopCartPrivateKitchenModel(isLoseTime: false, hasSelectRule: true)
//
//        let groupBuy20 = XSShopCartPrivateKitchenModel(isLoseTime: false, hasBottomRadius: true)
//        let vm22 = XSShopCartSectionViewModel(cellViewModels: [top10,groupBuy10,groupBuy101,groupBuy102,groupBuy20])
//        sections.append(vm22)
//
//
//        let loseTop1 = XSShopCartInfoTopModel(isLoseTime: true , signalTitle: "外卖", hasTopRadius: true)
//        let loseDev1 = XSShopCartDelieveModel(isLoseTime: true)
//        let loseDev2 = XSShopCartDelieveModel(isLoseTime: true , hasBottomRadius: true)
//        let vm3 = XSShopCartSectionViewModel(cellViewModels: [loseTop1,loseDev1,loseDev2])
//        vm3.sectionHeaderTitle = "失效宝贝"
//        sections.append(vm3)
//
//
//        let loseTop2 = XSShopCartInfoTopModel(isLoseTime: true, signalTitle: "到店", hasTopRadius: true)
//        let loseGroupBuy1 = XSShopCartGroupBuyModel(isLoseTime: true)
//        let loseGroupBuy2 = XSShopCartGroupBuyModel(isLoseTime: true , hasBottomRadius: true)
//        let vm4 = XSShopCartSectionViewModel(cellViewModels: [loseTop2,loseGroupBuy1,loseGroupBuy2])
//        sections.append(vm4)
//
//        let recommand = XSShopCartRecommendModel()
//        let vm5 = XSShopCartSectionViewModel(cellViewModels: [recommand])
//        vm5.sectionHeaderTitle = "大家都在买"
//        sections.append(vm5)
//
//
//
//    }
    
}
