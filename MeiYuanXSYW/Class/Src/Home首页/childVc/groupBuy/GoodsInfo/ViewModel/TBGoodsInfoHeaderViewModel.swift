//
//  TBShopInfoViewModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/16.
//

import Foundation
import UIKit



class TBGoodsInfoHeaderViewModel: NSObject {
    public var sectionHeaderTitle: String?
    public var sectionHeaderSubTitle: String?

    var headerHeight: CGFloat = 10.0
    
    public var cellViewModels: [TBShopInfoModelProtocol]
    
    var sections = [TBGoodsInfoHeaderViewModel]()


    init(cellViewModels: [TBShopInfoModelProtocol]) {
        self.cellViewModels = cellViewModels
        super.init()
    }
     
     override init() {
         self.cellViewModels = [TBShopInfoModelProtocol]()
         super.init()
     }
 /*
    func splitPrivateKetchData(data: TBTakeoutGoodsItem) {
        
        let vm1 = TBGoodsInfoHeaderViewModel()
        let pic = TBGoodsInfoHeaderPiclModel(picAddress: data.picAddress)
        vm1.cellViewModels.append(pic)
        sections.append(vm1)
        headerHeight += pic.rowHeight
        
        
        let vm2 = TBGoodsInfoHeaderViewModel()
        let goods = TBGoodsInfoHeaderGoodsModel(goodsItem: data)
        vm2.cellViewModels.append(goods)
        sections.append(vm2)
        headerHeight += 130

        
        data.couponDtail = "1111"
        data.promotion = "222"

        if (data.commonCouponVos.count <= 0 && data.couponDtail.isEmpty && data.promotion.isEmpty) {
            return
        }
        
        headerHeight += 10
        
        let vm3 = TBGoodsInfoHeaderViewModel()
        if data.commonCouponVos.count > 0 {
            let ticket = TBGoodsInfoHeaderTicketModel(commonCouponVos: data.commonCouponVos, prefixTitleText: "领劵专区", hasTopRadius: true, hasBottomRadius: false)
            vm3.cellViewModels.append(ticket)
            headerHeight += ticket.rowHeight + 10
        }
        
        if !data.couponDtail.isEmpty {
            let couponDtail = TBGoodsInfoHeaderTicketModel(commonCouponVos: data.commonCouponVos, prefixTitleText: "优惠券", suffixValueText: data.couponDtail)
            vm3.cellViewModels.append(couponDtail)
            headerHeight += couponDtail.rowHeight

        }
        
        if !data.promotion.isEmpty {
            let promotion = TBGoodsInfoHeaderTicketModel(commonCouponVos: data.commonCouponVos, prefixTitleText: "促销", suffixValueText: data.promotion, hasTopRadius: false, hasBottomRadius: true)
            vm3.cellViewModels.append(promotion)
            headerHeight += promotion.rowHeight

        }
        
        sections.append(vm3)
        
    }
    
    func splitTakeOutData(data: TBTakeoutGoodsItem) {
        
        let vm1 = TBGoodsInfoHeaderViewModel()
        let pic = TBGoodsInfoHeaderPiclModel(picAddress: data.picAddress)
        vm1.cellViewModels.append(pic)
        sections.append(vm1)
        headerHeight += pic.rowHeight
        
        
        let vm2 = TBGoodsInfoHeaderViewModel()
        let goods = TBGoodsInfoHeaderGoodsModel(goodsItem: data)
        vm2.cellViewModels.append(goods)
        sections.append(vm2)
        headerHeight += goods.rowHeight

        
        data.couponDtail = "1111"
        data.promotion = "222"

        if (data.commonCouponVos.count <= 0 && data.couponDtail.isEmpty && data.promotion.isEmpty) {
            return
        }
        
        headerHeight += 10
        
        let vm3 = TBGoodsInfoHeaderViewModel()
        if data.commonCouponVos.count > 0 {
            let ticket = TBGoodsInfoHeaderTicketModel(commonCouponVos: data.commonCouponVos, prefixTitleText: "领劵专区", hasTopRadius: true, hasBottomRadius: false)
            vm3.cellViewModels.append(ticket)
            headerHeight += ticket.rowHeight + 10
        }
        
        if !data.couponDtail.isEmpty {
            let couponDtail = TBGoodsInfoHeaderTicketModel(commonCouponVos: data.commonCouponVos, prefixTitleText: "优惠券", suffixValueText: data.couponDtail)
            vm3.cellViewModels.append(couponDtail)
            headerHeight += couponDtail.rowHeight

        }
        
        if !data.promotion.isEmpty {
            let promotion = TBGoodsInfoHeaderTicketModel(commonCouponVos: data.commonCouponVos, prefixTitleText: "促销", suffixValueText: data.promotion, hasTopRadius: false, hasBottomRadius: true)
            vm3.cellViewModels.append(promotion)
            headerHeight += promotion.rowHeight

        }
        
        sections.append(vm3)
        
    }
    */
     
  
}



