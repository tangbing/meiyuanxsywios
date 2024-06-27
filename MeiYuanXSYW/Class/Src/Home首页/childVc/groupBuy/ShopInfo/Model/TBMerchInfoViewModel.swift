//
//  TBMerchInfoViewModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/3.
//

import UIKit


enum pinLocationStyle {
    /// 优惠
    case discount
    case package
    /// 评价top
    case evalutateTop
    /// 评价
    case evalutate
    /// 评价更多
    case merchMore
    /// 外卖
    case deliver
    /// 详情
    case detainInfo
    /// 推荐
    case recommand
    /// 套餐详情分类
    case packageDetailInfoTitle
    /// 套餐详情具体名称
    case packageDetailInfoContent
    /// 套餐详情更多
    case packageDetailMore
    /// 购买须知
    case buyMustKnow
    /// 适用商户
    case applyMerch
    // 团购详情代金卷
    case goldTicket
    // 团购详情代金卷info
    case goldTicketInfo
    // 领卷专区
    case applyTicketSpace
    
    // 商品详情图片展示
    case goodsInfoPicArray
    // 商品详情图信息
    case goodsInfoItem
    // 商品详情促销，优惠卷
    case goodsInfoTicket
}

// 视图更新回调
protocol TBMerchInfoViewModelDelegate: NSObject {
    func onFetchComplete(_ isCollection:Bool, goodsItem: TBGoodsItemModel, _ sections: [TBMerchInfoViewModel])
    func onFetchFailed(with reason: String)
}

 class TBMerchInfoViewModel: NSObject {
     weak var delegate: TBMerchInfoViewModelDelegate?
     var sections = [TBMerchInfoViewModel]()

     private let sectionShopInfoGroupBuyTitles = [nil, "购买须知","套餐评价","大家都在买"]
     
    public var sectionHeaderTitle: String?
    public var sectionHeaderSubTitle: String?
    
    public var cellViewModels: [TBMerchInfoModelProtocol] = [TBMerchInfoModelProtocol]()
    public var style: HomeShowStyle = .multiple
     
     private var sectionTitles: [String?] {
         return style.pinSectionTitles()
     }

    var completeConfigDataHandler: ((_ dataModels: [TBMerchInfoViewModel]) -> Void)?
     
    init(cellViewModels: [TBMerchInfoModelProtocol]) {
        self.cellViewModels = cellViewModels
        super.init()
    }
     
     override init() {
         super.init()
     }
     
     init(style: HomeShowStyle) {
         self.style = style
         super.init()
     }
     
     
     func fetchGoodsInfoData(bizType: Int, goodsId: String) {
         /// 0:外卖;1:团购;2:私厨;5:优惠券
         
         if goodsId.isEmpty {
             XSTipsHUD.showText("goodsId 为空")
             return
         }
         
         MerchantInfoProvider.request(.getSingleGoodsItem(bizType, goodsId: goodsId), model: TBGoodsItemModel.self) { returnData in
             uLog(returnData)
             
             if let dataModel = returnData {
                 
                 if let takeoutGoodsItemModel = dataModel.takeoutGoodsItem  {
                     self.splitTakeOutData(takeoutGoodsItemModel)
                 }
                 
                 if let privateKitchenGoodsItem = dataModel.privateKitchenGoodsItem {
                     
                     self.splitTakeOutData(privateKitchenGoodsItem)
                 }
                 
                 if let groupBuyGoodsItem = dataModel.groupBuyGoodsItem {
                     
                     self.splitGroupBuyGoodsItemData(groupBuyGoodsItem)
                 }
                 
                 if let voucherGoodsItem = dataModel.voucherGoodsItem {

                     self.splitGroupBuyTicketData(voucherGoodsItem)

                 }
                 
                 
                 
                 
             }
             

         } errorResult: { errorMsg in
             print(errorMsg)
             
             self.delegate?.onFetchFailed(with: errorMsg)
             
         }

     }
     
     func splitGroupBuyTicketData(_ voucherGoodsItem: TBVoucherGoodsItem) {
         
         sections.removeAll()
         let headerSectionTitles = style.pinGoodsInfoSectionTitles()
         
         let goldTicket = XSGoodsInfoGroupBuyGoldTicketModel(voucherGoodsItem: voucherGoodsItem)
         let picVm = TBMerchInfoViewModel(cellViewModels: [goldTicket])
         sections.append(picVm)

         
         let goods = TBGoodsInfoHeaderGoodsModel(voucherGoodsItem: voucherGoodsItem)
         let goodItemVm = TBMerchInfoViewModel(cellViewModels: [goods])
         sections.append(goodItemVm)

         
         if voucherGoodsItem.commonCouponVos.count > 0 {
             let ticketVm = TBMerchInfoViewModel()
             let ticket = TBGoodsInfoHeaderTicketModel(commonCouponVos: voucherGoodsItem.commonCouponVos, prefixTitleText: "领劵专区", hasTopRadius: true, hasBottomRadius: true)
             ticketVm.cellViewModels.append(ticket)
             sections.append(ticketVm)

         }
                  
         
         let know = TBShopInfoBuyMustKnowModel(titleText: "有效期",contentIcon: "shopInfo_validRule_icon", contentText: voucherGoodsItem.termOfValidity,hasTopRadius: true,hasBottomRadius: false)
         let know2 = TBShopInfoBuyMustKnowModel(titleText: "使用时间",contentIcon: "shopInfo_userTime_icon", contentText: voucherGoodsItem.useTime)
         let know3 = TBShopInfoBuyMustKnowModel(titleText: "使用规则",contentIcon: "shopInfo_validTime_icon", contentText: nil)
         let know33 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: voucherGoodsItem.useRule, nameTitleFont: MYFont(size: 12))
         let knowVm = TBMerchInfoViewModel(cellViewModels: [know,know2,know3,know33])
         knowVm.sectionHeaderTitle = headerSectionTitles[1]
         sections.append(knowVm)
         
         
         let apply = TBShopInfoApplyMerchModel(voucherGoodsItem: voucherGoodsItem)
         let applyMoreVm = TBMerchInfoViewModel(cellViewModels: [apply])
         sections.append(applyMoreVm)
         
         
         if let detail = voucherGoodsItem.evaluationDetails,
            let commentModels = detail.evaluationDetails {
             
             let topModel = TBRepeatTotalModel(evaluationDetails:voucherGoodsItem.evaluationDetails, hasTopRadius: true)
             //topModel.evaluationDetails = voucherGoodsItem.evaluationDetails
             
             let evaluationVm = TBMerchInfoViewModel()
             evaluationVm.sectionHeaderTitle = headerSectionTitles[2]
             evaluationVm.sectionHeaderSubTitle = (detail.evaluationSumNum == 0 ? nil : "更多评价\(detail.evaluationSumNum)条")
             evaluationVm.cellViewModels.append(topModel)
             
             for (index, commentModel) in commentModels.enumerated() {
                 let bottomRadius: CGFloat = (index == commentModels.count - 1) ? 10.0 : 0.0
                 
                 let mod = TBRepeatModel(evaluationModel: commentModel, botttomRadius: bottomRadius)

//                 let mod = TBRepeatModel(shopIcon: commentModel.headImg, shopName: commentModel.userName, shopTime: commentModel.userCommentDate, shopScore: Double(truncating: commentModel.totalComment), evaluate: "口味 \(commentModel.tasteComment)  包装 \(commentModel.packComment)", commentContent: commentModel.userComment, repeatPics: commentModel.commentPicStr, shopInfo_curPrice: "\(commentModel.evaluationGoods?.finalPrice ?? 0.0)", shopInfo_oldPrice: "\(commentModel.evaluationGoods?.originalPrice ?? 0.0)", shopRepeat: commentModel.merchantReplyComment, shopRepeatDate: commentModel.merchantReplyDate, botttomRadius: bottomRadius)
                 
                 evaluationVm.cellViewModels.append(mod)
             }
             sections.append(evaluationVm)
                 
         } else {
             let topModel = TBRepeatTotalModel()
             let detail = TBEvaluationDetails()
             detail.totalComment = 0
             detail.totalScoreItems = [TBtotalScoreItem(scoreName: "口味", scoreNum: 0.0),
                                       TBtotalScoreItem(scoreName: "包装", scoreNum: 0.0)
                                      ]
             
             topModel.evaluationDetails = detail
             
             
             let evaluationVm = TBMerchInfoViewModel(cellViewModels: [topModel])
             evaluationVm.sectionHeaderTitle = headerSectionTitles[1]
             sections.append(evaluationVm)
             
         }
         
         let goodsItem = TBGoodsItemModel()
         goodsItem.voucherGoodsItem = voucherGoodsItem
         self.delegate?.onFetchComplete((voucherGoodsItem.isCollect == 0),goodsItem: goodsItem, sections)
     }
     
     func splitGroupBuyGoodsItemData(_ groupBuyGoodsItem: TBGroupBuyGoodsItem){
         sections.removeAll()
         let headerSectionTitles = style.pinGoodsInfoSectionTitles()
         
         let pic = TBGoodsInfoHeaderPiclModel(picAddress: groupBuyGoodsItem.picAddress)
         let picVm = TBMerchInfoViewModel(cellViewModels: [pic])
         sections.append(picVm)

         
         let goods = TBGoodsInfoHeaderGoodsModel(groupBuyGoodsItem: groupBuyGoodsItem)
         let goodItemVm = TBMerchInfoViewModel(cellViewModels: [goods])
         sections.append(goodItemVm)

         
         if (groupBuyGoodsItem.commonCouponVos.count <= 0 && groupBuyGoodsItem.couponDtail.isEmpty && groupBuyGoodsItem.promotion.isEmpty) {
             return
         }

         let ticketVm = TBMerchInfoViewModel()
         if groupBuyGoodsItem.commonCouponVos.count > 0 {
             let ticket = TBGoodsInfoHeaderTicketModel(commonCouponVos: groupBuyGoodsItem.commonCouponVos, prefixTitleText: "领劵专区", hasTopRadius: true, hasBottomRadius: false)
             ticketVm.cellViewModels.append(ticket)
         }
         
         if !groupBuyGoodsItem.couponDtail.isEmpty {
             let couponDtail = TBGoodsInfoHeaderTicketModel(commonCouponVos: nil, prefixTitleText: "优惠券", suffixValueText: groupBuyGoodsItem.couponDtail)
             ticketVm.cellViewModels.append(couponDtail)

         }
         
         if !groupBuyGoodsItem.promotion.isEmpty {
             let promotion = TBGoodsInfoHeaderTicketModel(commonCouponVos: nil, prefixTitleText: "促销", suffixValueText: groupBuyGoodsItem.promotion, hasTopRadius: false, hasBottomRadius: true)
             ticketVm.cellViewModels.append(promotion)
         }
         
         sections.append(ticketVm)
         

         
         let packetVm = TBMerchInfoViewModel()
         packetVm.sectionHeaderTitle = headerSectionTitles[1]
         for (index,goodsPacket) in groupBuyGoodsItem.goodsPackageVos.enumerated() {
             let hasTopRadius = index == 0 ? true : false
             let isLastPacket = (index == groupBuyGoodsItem.goodsPackageVos.count - 1)
             let info = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: goodsPacket.packageName,hasTopRadius: hasTopRadius,hasBottomRadius: false)
             packetVm.cellViewModels.append(info)
             
             for (idx,goodsPackageItemVo) in goodsPacket.goodsPackageItemVos.enumerated() {
                 let hasBottomRadius = (idx == groupBuyGoodsItem.goodsPackageVos.count - 1) && isLastPacket
                 
                 let content = TBShopInfoPacketDetailInfoContentModel(nameTitleText: goodsPackageItemVo.itemName, numShop:goodsPackageItemVo.itemNum, priceTitleText: "¥\(goodsPackageItemVo.showPrice)",
                     hasTopRadius: false,hasBottomRadius: hasBottomRadius)
                 packetVm.cellViewModels.append(content)
             }
         }
         sections.append(packetVm)

                 
         let know = TBShopInfoBuyMustKnowModel(titleText: "有效期",contentIcon: "shopInfo_validRule_icon", contentText: groupBuyGoodsItem.termOfValidity,hasTopRadius: true,hasBottomRadius: false)
         let know2 = TBShopInfoBuyMustKnowModel(titleText: "使用时间",contentIcon: "shopInfo_userTime_icon", contentText: groupBuyGoodsItem.useTime)
         let know3 = TBShopInfoBuyMustKnowModel(titleText: "使用规则",contentIcon: "shopInfo_validTime_icon", contentText: nil)
         let know33 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: groupBuyGoodsItem.useRule, nameTitleFont: MYFont(size: 12))

         
         let knowVm = TBMerchInfoViewModel(cellViewModels: [know,know2,know3,know33])
         knowVm.sectionHeaderTitle = headerSectionTitles[2]
         sections.append(knowVm)
         
         
         let apply = TBShopInfoApplyMerchModel(groupBuyGoodsItem: groupBuyGoodsItem)
         let applyMoreVm = TBMerchInfoViewModel(cellViewModels: [apply])
         sections.append(applyMoreVm)
         
         
         if let detail = groupBuyGoodsItem.evaluationDetails,
            let commentModels = detail.evaluationDetails {
             
             let topModel = TBRepeatTotalModel()
             topModel.evaluationDetails = groupBuyGoodsItem.evaluationDetails
             
             let evaluationVm = TBMerchInfoViewModel()
             evaluationVm.sectionHeaderTitle = headerSectionTitles[3]
             evaluationVm.sectionHeaderSubTitle = (detail.evaluationSumNum == 0 ? nil : "更多评价\(detail.evaluationSumNum)条")
             evaluationVm.cellViewModels.append(topModel)
             
             for (index, commentModel) in commentModels.enumerated() {
                 let bottomRadius: CGFloat = (index == commentModels.count - 1) ? 10.0 : 0.0

                 let mod = TBRepeatModel(evaluationModel: commentModel, botttomRadius: bottomRadius)
//                 let mod = TBRepeatModel(shopIcon: commentModel.headImg, shopName: commentModel.userName, shopTime: commentModel.userCommentDate, shopScore: Double(truncating: commentModel.totalComment), evaluate: "口味 \(commentModel.tasteComment)  包装 \(commentModel.packComment)", commentContent: commentModel.userComment, repeatPics: commentModel.commentPicStr, shopInfo_curPrice: "\(commentModel.evaluationGoods?.finalPrice ?? 0.0)", shopInfo_oldPrice: "\(commentModel.evaluationGoods?.originalPrice ?? 0.0)", shopRepeat: commentModel.merchantReplyComment, shopRepeatDate: commentModel.merchantReplyDate, botttomRadius: bottomRadius)
                 
                 evaluationVm.cellViewModels.append(mod)
             }
             sections.append(evaluationVm)
                 
         } else {
             let topModel = TBRepeatTotalModel()
             let detail = TBEvaluationDetails()
             detail.totalComment = 0
             detail.totalScoreItems = [TBtotalScoreItem(scoreName: "口味", scoreNum: 0.0),
                                       TBtotalScoreItem(scoreName: "包装", scoreNum: 0.0)
                                      ]
             
             topModel.evaluationDetails = detail
             
             
             let evaluationVm = TBMerchInfoViewModel(cellViewModels: [topModel])
             evaluationVm.sectionHeaderTitle = headerSectionTitles[1]
             sections.append(evaluationVm)
             
         }
         
         let goodsItem = TBGoodsItemModel()
         goodsItem.groupBuyGoodsItem = groupBuyGoodsItem
         self.delegate?.onFetchComplete(groupBuyGoodsItem.isCollect == 0,goodsItem: goodsItem, sections)
         
     }
     
     // 外码与私厨数据整理
     func splitTakeOutData(_ takeoutGoodsItem: TBTakeoutGoodsItem){
         
         sections.removeAll()
         let headerSectionTitles = style.pinGoodsInfoSectionTitles()
         
         
         let pic = TBGoodsInfoHeaderPiclModel(picAddress: takeoutGoodsItem.picAddress)
         let vm1 = TBMerchInfoViewModel(cellViewModels: [pic])
         sections.append(vm1)

         
         let goods = TBGoodsInfoHeaderGoodsModel(goodsItem: takeoutGoodsItem)
         let vm2 = TBMerchInfoViewModel(cellViewModels: [goods])
         sections.append(vm2)

         
         if (takeoutGoodsItem.commonCouponVos.count <= 0 && takeoutGoodsItem.couponDtail.isEmpty && takeoutGoodsItem.promotion.isEmpty) {
             return
         }

         let vm3 = TBMerchInfoViewModel()
         if takeoutGoodsItem.commonCouponVos.count > 0 {
             let ticket = TBGoodsInfoHeaderTicketModel(commonCouponVos: takeoutGoodsItem.commonCouponVos, prefixTitleText: "领劵专区", hasTopRadius: true, hasBottomRadius: false)
             vm3.cellViewModels.append(ticket)
         }
         
         if !takeoutGoodsItem.couponDtail.isEmpty {
             let couponDtail = TBGoodsInfoHeaderTicketModel(commonCouponVos: nil, prefixTitleText: "优惠券", suffixValueText: takeoutGoodsItem.couponDtail)
             vm3.cellViewModels.append(couponDtail)

         }
         
         if !takeoutGoodsItem.promotion.isEmpty {
             let promotion = TBGoodsInfoHeaderTicketModel(commonCouponVos: nil, prefixTitleText: "促销", suffixValueText: takeoutGoodsItem.promotion, hasTopRadius: false, hasBottomRadius: true)
             vm3.cellViewModels.append(promotion)
         }
         
         sections.append(vm3)
         
         
         
         let detail = TBShopInfoDetailModel(titleText: "掌柜描述", titleContent: takeoutGoodsItem.merchantDesc,hasTopRadius: true, hasBottomRadius: false)
 //         let detail1 = TBShopInfoDetailModel(titleText: "主料", titleContent: "面粉、牛肉")
 //         let detail2 = TBShopInfoDetailModel(titleText: "辅料", titleContent: "干辣椒、辣椒")
         let detail3 = TBShopInfoDetailModel(titleText: "原材料", titleContent: takeoutGoodsItem.material, hasTopRadius: false, hasBottomRadius: true)
         
         let vm4 = TBMerchInfoViewModel(cellViewModels: [detail,detail3])
         vm4.sectionHeaderTitle = headerSectionTitles[0]
         sections.append(vm4)
         
         
         if let detail = takeoutGoodsItem.evaluationDetails,
            let commentModels = detail.evaluationDetails {
             
             let topModel = TBRepeatTotalModel()
             topModel.evaluationDetails = takeoutGoodsItem.evaluationDetails
             
             let vm5 = TBMerchInfoViewModel()
             vm5.sectionHeaderTitle = headerSectionTitles[1]
             vm5.sectionHeaderSubTitle = (detail.evaluationSumNum == 0 ? nil : "更多评价\(detail.evaluationSumNum)条")
             vm5.cellViewModels.append(topModel)
             
             for (index, commentModel) in commentModels.enumerated() {
                 let bottomRadius: CGFloat = (index == commentModels.count - 1) ? 10.0 : 0.0

                 let mode = TBRepeatModel(evaluationModel: commentModel, botttomRadius: bottomRadius)
//                 let mod = TBRepeatModel(shopIcon: commentModel.headImg, shopName: commentModel.userName, shopTime: commentModel.userCommentDate, shopScore: Double(truncating: commentModel.totalComment), evaluate: "口味 \(commentModel.tasteComment)  包装 \(commentModel.packComment)", commentContent: commentModel.userComment, repeatPics: commentModel.commentPicStr, shopInfo_curPrice: "\(commentModel.evaluationGoods?.finalPrice ?? 0.0)", shopInfo_oldPrice: "\(commentModel.evaluationGoods?.originalPrice ?? 0.0)", shopRepeat: commentModel.merchantReplyComment, shopRepeatDate: commentModel.merchantReplyDate, botttomRadius: bottomRadius)
                 
                 vm5.cellViewModels.append(mode)
             }
             sections.append(vm5)
                 
         } else {
             let topModel = TBRepeatTotalModel()
             let detail = TBEvaluationDetails()
             detail.totalComment = 0
             detail.totalScoreItems = [TBtotalScoreItem(scoreName: "口味", scoreNum: 0.0),
                                       TBtotalScoreItem(scoreName: "包装", scoreNum: 0.0)
                                      ]
             
             topModel.evaluationDetails = detail
             
             
             let vm5 = TBMerchInfoViewModel(cellViewModels: [topModel])
             vm5.sectionHeaderTitle = headerSectionTitles[1]
             sections.append(vm5)
             
         }
         
         let goodsItem = TBGoodsItemModel()
         goodsItem.takeoutGoodsItem = takeoutGoodsItem
         goodsItem.privateKitchenGoodsItem = takeoutGoodsItem
         self.delegate?.onFetchComplete(takeoutGoodsItem.isCollect == 0,goodsItem: goodsItem, sections)

     }
     
     
     func fetchGroupBuyTicketGoodsInfoData(){
         sections.removeAll()
         
//         let goldTicket = XSGoodsInfoGroupBuyGoldTicketModel()
//         let vm_0 = TBMerchInfoViewModel(cellViewModels: [goldTicket])
//         sections.append(vm_0)
         
         let goldTicketInfo = XSGoodsInfoGroupBuyGoldTicketInfoModel()
         let vm_011 = TBMerchInfoViewModel(cellViewModels: [goldTicketInfo])
         sections.append(vm_011)
         
         
         
         let goldTicket11 = XSGoodsInfoGroupBuyApplyTicketModel()
         let vm_1 = TBMerchInfoViewModel(cellViewModels: [goldTicket11])
         sections.append(vm_1)
         
         
         
         let info = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "招牌推荐",hasTopRadius: true,hasBottomRadius: false)
         let content = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         
         let info1 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "招牌推荐")
         let content1 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content12 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         
         let info2 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "招牌推荐")
         let content2 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content22 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content23 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         
         let info3 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "招牌推荐")
         let content3 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content33 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content34 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content35 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         
         let more11 = TBShopInfoPacketDetailMoreModel(priceText: "¥366", hasTopRadius: false, hasBottomRadius: true)
         
         
         let vm1 = TBMerchInfoViewModel(cellViewModels: [info, content,info1,content1,content12,info2,content2,content22,content23,info3,content3,content33,content34,content35,more11])
         sections.append(vm1)
         
         
         let know = TBShopInfoBuyMustKnowModel(titleText: "有效期",contentIcon: "shopInfo_validRule_icon", contentText: "2019.8.17至2021.6.9 23:59（周末法定节假日通用）",hasTopRadius: true,hasBottomRadius: false)
         let know2 = TBShopInfoBuyMustKnowModel(titleText: "使用时间",contentIcon: "shopInfo_userTime_icon", contentText: "10:00-22:00")
         let know3 = TBShopInfoBuyMustKnowModel(titleText: "使用规则",contentIcon: "shopInfo_validTime_icon", contentText: nil)
         let know33 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "使用规则口味鱼使用规则口味鱼使用规则口味鱼使用规则使用规则口味鱼", nameTitleFont: MYFont(size: 12))
         let know333 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "招牌推荐使用规则口味鱼使用规则口味鱼使用规则口味鱼使用规则使用规则口味鱼",nameTitleFont: MYFont(size: 12), hasTopRadius: false,hasBottomRadius: true)
         
         let vm2 = TBMerchInfoViewModel(cellViewModels: [know,know2,know3,know33, know333])
         vm2.sectionHeaderTitle = sectionShopInfoGroupBuyTitles[1]
         sections.append(vm2)
         
         
//         let apply = TBShopInfoApplyMerchModel()
//         let vm3 = TBMerchInfoViewModel(cellViewModels: [apply])
//         sections.append(vm3)
         
        
         let topModel = TBRepeatTotalModel()
//         let mod = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示", repeatPics: ["picture12","picture12"], shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”")
//
//         let mod1 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合", repeatPics: ["picture12","picture12","picture12","picture12","picture12","picture12","picture12","picture12","picture12"], shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，。")
//
//         let mod2 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的", repeatPics: nil, shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴。")
//
//
//        let mod3 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”", repeatPics: nil, shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: nil, botttomRadius: 10.0)
//
//         let vm4 = TBMerchInfoViewModel(cellViewModels: [topModel,mod, mod1, mod2, mod3])
//         vm4.sectionHeaderTitle = sectionShopInfoTitles[1]
//         sections.append(vm4)
         
         let recommand = TBShopInfoRecommandModel()
         let vm5 = TBMerchInfoViewModel(cellViewModels: [recommand])
         vm5.sectionHeaderTitle = sectionShopInfoGroupBuyTitles[3]
         sections.append(vm5)
         
     }
     
     
     func fetchGroupBuyShopInfoData(){
         sections.removeAll()
         
         
         let info = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "招牌推荐",hasTopRadius: true,hasBottomRadius: false)
         let content = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         
         let info1 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "招牌推荐")
         let content1 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content12 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         
         let info2 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "招牌推荐")
         let content2 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content22 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content23 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         
         let info3 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "招牌推荐")
         let content3 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content33 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content34 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         let content35 = TBShopInfoPacketDetailInfoContentModel(nameTitleText: "口味鱼", numShop: 1, priceTitleText: "¥68")
         
         let more11 = TBShopInfoPacketDetailMoreModel(priceText: "¥366", hasTopRadius: false, hasBottomRadius: true)
         
         
         let vm1 = TBMerchInfoViewModel(cellViewModels: [info, content,info1,content1,content12,info2,content2,content22,content23,info3,content3,content33,content34,content35,more11])
         sections.append(vm1)
         
         
         let know = TBShopInfoBuyMustKnowModel(titleText: "有效期",contentIcon: "shopInfo_validRule_icon", contentText: "2019.8.17至2021.6.9 23:59（周末法定节假日通用）",hasTopRadius: true,hasBottomRadius: false)
         let know2 = TBShopInfoBuyMustKnowModel(titleText: "使用时间",contentIcon: "shopInfo_userTime_icon", contentText: "10:00-22:00")
         let know3 = TBShopInfoBuyMustKnowModel(titleText: "使用规则",contentIcon: "shopInfo_validTime_icon", contentText: nil)
         let know33 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "使用规则口味鱼使用规则口味鱼使用规则口味鱼使用规则使用规则口味鱼", nameTitleFont: MYFont(size: 12))
         let know333 = TBShopInfoPacketDetailInfoTitleModel(nameTitleText: "招牌推荐使用规则口味鱼使用规则口味鱼使用规则口味鱼使用规则使用规则口味鱼",nameTitleFont: MYFont(size: 12), hasTopRadius: false,hasBottomRadius: true)
         
         let vm2 = TBMerchInfoViewModel(cellViewModels: [know,know2,know3,know33, know333])
         vm2.sectionHeaderTitle = sectionShopInfoGroupBuyTitles[1]
         sections.append(vm2)
         
         
//         let apply = TBShopInfoApplyMerchModel()
//         let vm3 = TBMerchInfoViewModel(cellViewModels: [apply])
//         sections.append(vm3)
         
        
         let topModel = TBRepeatTotalModel()
//         let mod = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示", repeatPics: ["picture12","picture12"], shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”")
//
//         let mod1 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合", repeatPics: ["picture12","picture12","picture12","picture12","picture12","picture12","picture12","picture12","picture12"], shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，。")
//
//         let mod2 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的", repeatPics: nil, shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴。")
//
//
//        let mod3 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”", repeatPics: nil, shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: nil, botttomRadius: 10.0)
//
//         let vm4 = TBMerchInfoViewModel(cellViewModels: [topModel,mod, mod1, mod2, mod3])
//         vm4.sectionHeaderTitle = sectionShopInfoTitles[1]
//         sections.append(vm4)
         
         let recommand = TBShopInfoRecommandModel()
         let vm5 = TBMerchInfoViewModel(cellViewModels: [recommand])
         vm5.sectionHeaderTitle = sectionShopInfoGroupBuyTitles[3]
         sections.append(vm5)
         
     }
     
     
     
     
     
     func getMerchantInfo(flage: Int, merchantId: String) {
         /// 标记 0：需要外卖数据 1：不需要外卖数据
         MerchantInfoProvider.request(.getMerchantDetailPolymerization(_merchantId: merchantId, flag: flage), model: TBShopInfoGroupBuyResultModel.self) { returnData in
             //uLog(returnData)
             
             if let dataModel = returnData {
                 self.sections = self.fetchPinLocationOtherData(model: dataModel) ?? [TBMerchInfoViewModel]()
                 
//                 self.completeConfigDataHandler?(self.sections)

                 self.fetchMoreMerchantInfo(page: 1)
                 
             }
             
             
         } errorResult: { errorMsg in
             print(errorMsg)
             XSTipsHUD.showText(errorMsg)
         }

     }
     
     typealias completeBlock = ((_ viewModels: [TBMerchInfoViewModel], _ isNoMoreData: Bool) -> Void)?
     typealias failureBlock = ((String) -> Void)?
     
     // MARK: - 商家详情
     func fetchMoreMerchantInfo(page: Int, completeBlock: completeBlock = nil, failureBlock: failureBlock = nil) {
         MerchantInfoProvider.request(.getNearByStoreAndGoods(_businessType: "\(self.style.rawValue)", lat1: lat, lng1: lon, page: page, pageSize: pageSize), model: TBCommendShopDataModel.self) { returnData in
             
             if let moreModel = returnData {
                 
                 let more = moreModel.data.compactMap({ coupon -> TBMerchInfoModelProtocol in
                     TBMerchMoreModel(data: coupon, count: moreModel.count,code: moreModel.code)
                 })
                 
                 if page == 1 {
                     let vm5 = TBMerchInfoViewModel(cellViewModels: more)
                     vm5.sectionHeaderTitle = self.sectionTitles.last ?? ""
                     self.sections.append(vm5)
                     self.completeConfigDataHandler?(self.sections)
                     
                 } else {
                     let lastModel = self.sections.last!
                     lastModel.cellViewModels.appends(more)
                     let isMoreFage = lastModel.cellViewModels.count >= moreModel.count
                     completeBlock?(self.sections,isMoreFage)
                 }

             }
             
         } errorResult: { errorMsg in
             print(errorMsg)
             failureBlock?(errorMsg)
             XSTipsHUD.showText(errorMsg)
         }

     }
     
     
     func fetchPinLocationOtherData(model dataModel: TBShopInfoGroupBuyResultModel) -> [TBMerchInfoViewModel]? {
         sections.removeAll()
        
         // 优惠
         guard let discount = dataModel.couponDetails?.compactMap({ coupon -> TBMerchInfoModelProtocol in
             TBDiscountModel(couponDetail: coupon)
         }) else {
             return nil
         }
         
         let discountVm = TBMerchInfoViewModel(cellViewModels: discount)
         discountVm.sectionHeaderTitle = sectionTitles[0]
         sections.append(discountVm)
        
         
         // 套餐
         guard let packet = dataModel.comboDetails?.compactMap({ combo -> TBMerchInfoModelProtocol in
             TBPacketModel(comboDetail: combo)
         }) else {
             return nil
         }
         let packetVm = TBMerchInfoViewModel(cellViewModels: packet)
         packetVm.sectionHeaderTitle = sectionTitles[1]
         sections.append(packetVm)
        
         // 外卖
         if let delieveModel = dataModel.takeoutDetails,
            delieveModel.details.count > 0{
             let deliver = delieveModel.details.map({ item -> TBMerchInfoModelProtocol in
                 TBDeliverModel(goodsItems: [item])
             })
             let delieveVm = TBMerchInfoViewModel(cellViewModels: deliver)
             delieveVm.sectionHeaderTitle = sectionTitles[2]
             delieveVm.sectionHeaderSubTitle = (delieveModel.sumNum == 0 ? nil : "全部菜品（\(delieveModel.sumNum)个）")
             sections.append(delieveVm)
         }
         
         
         if let detail = dataModel.evaluationDetails,
            let commentModels = detail.evaluationDetails {
             
             let topModel = TBRepeatTotalModel()
             topModel.evaluationDetails = dataModel.evaluationDetails
             
             let evaluatVm = TBMerchInfoViewModel()
             evaluatVm.sectionHeaderTitle = (style == .groupBuy ? sectionTitles[2] : sectionTitles[3])
             evaluatVm.sectionHeaderSubTitle = (detail.evaluationSumNum == 0 ? nil : "更多评价\(detail.evaluationSumNum)条")
             evaluatVm.cellViewModels.append(topModel)
             
             for (index, commentModel) in commentModels.enumerated() {
                 let bottomRadius: CGFloat = (index == commentModels.count - 1) ? 10.0 : 0.0

                 let mod = TBRepeatModel(evaluationModel: commentModel, botttomRadius: bottomRadius)
//                 let mod = TBRepeatModel(shopIcon: commentModel.headImg, shopName: commentModel.userName, shopTime: commentModel.userCommentDate, shopScore: Double(truncating: commentModel.totalComment), evaluate: "口味 \(commentModel.tasteComment)  包装 \(commentModel.packComment)", commentContent: commentModel.userComment, repeatPics: commentModel.commentPicStr, shopInfo_curPrice: "\(commentModel.evaluationGoods?.finalPrice)", shopInfo_oldPrice: "\(commentModel.evaluationGoods?.originalPrice)", shopRepeat: commentModel.merchantReplyComment, shopRepeatDate: commentModel.merchantReplyDate, botttomRadius: bottomRadius)
                 
                 evaluatVm.cellViewModels.append(mod)
             }
             sections.append(evaluatVm)
                 
         } else {
             let topModel = TBRepeatTotalModel()
             //topModel.evaluationDetails = dataModel.evaluationDetails
             
             let evaluatVm = TBMerchInfoViewModel(cellViewModels: [topModel])
             evaluatVm.sectionHeaderTitle = (style == .groupBuy ? sectionTitles[2] : sectionTitles[3])
             sections.append(evaluatVm)
             
         }
         
//         let mod = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示", repeatPics: ["picture12","picture12"], shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”")
//
//         let mod1 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合", repeatPics: ["picture12","picture12","picture12","picture12","picture12","picture12","picture12","picture12","picture12"], shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，。")
//
//         let mod2 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的", repeatPics: nil, shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: "遭到一名男子的掌掴。")
//
//
//        let mod3 = TBRepeatModel(shopIcon: "details_avatar", shopName: "老李家的亲戚", shopTime: "2021-6-9", shopScore: 5.0, evaluate: "非常有格调的小众英伦香氛的味道", commentContent: "非常有格调的小众英伦香氛的味道，威廉梨和小苍兰的结合遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”遭到一名男子的掌掴。现场视频曝光后，在社交媒体上遭疯传，各国媒体也争相报道了此事。不少法国网民愤怒地表示，马克龙遭掌掴一事是法国在国际舞台上的“一个耻辱”", repeatPics: nil, shopInfo_curPrice: "¥28.5", shopInfo_oldPrice: "110", shopRepeat: nil, botttomRadius: 10.0)
//
//         let vm4 = TBMerchInfoViewModel(cellViewModels: [topModel,mod, mod1, mod2, mod3])
//         vm4.sectionHeaderTitle = sectionTitles[3]
//         sections.append(vm4)
         
//         let more = TBMerchMoreModel()
//         let more1 = TBMerchMoreModel()
//         let more2 = TBMerchMoreModel()
//         let more3 = TBMerchMoreModel()
//
//         let vm5 = TBMerchInfoViewModel(cellViewModels: [more, more1, more2, more3])
//         vm5.sectionHeaderTitle = sectionTitles[3]
//         sections.append(vm5)
         
         return sections
         

     }
}


