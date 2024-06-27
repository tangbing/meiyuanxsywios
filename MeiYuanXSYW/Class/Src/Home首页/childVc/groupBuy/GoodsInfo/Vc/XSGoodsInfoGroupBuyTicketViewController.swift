//
//  XSGoodsInfoGroupBuyTicketViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/19.
//

import UIKit
import JKSwiftExtension

class XSGoodsInfoGroupBuyTicketViewController: XSBaseViewController {

    var datas = [TBMerchInfoViewModel]()
    var goodsId: String?
    var merchantId: String?
    var buyOfNum: Int = 0 {
        didSet {
            cartBtn.cartNum = buyOfNum
        }
    }
    
    var groupBuyGoodsItem: TBGroupBuyGoodsItem!
    var voucherGoodsItem: TBVoucherGoodsItem!
    
    var showHomeStyle: HomeShowStyle = .ticket
    
    lazy var collectItem: UIBarButtonItem = {
        return UIBarButtonItem.tb_item(title: nil, image: UIImage(named: "nav_collect_black_icon"), highLightImage: nil, selectEdImage: UIImage(named: "goodsInfo_love_select"), target: self, action: #selector(collectAction(collectionButton: )))
    }()
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableV.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(headerFooterViewType: TBHomeDeliverReusableView.self)
        tableV.register(cellType: XSFootMarkTableViewCell.self)
        tableV.register(cellType: TBMerchInfoEvalateTableCellTop.self)
        tableV.register(cellType: TBMerchInfoEvaluateTableCell.self)
        tableV.register(cellType: TBGoodsInfoDetailTableViewCell.self)
        
        tableV.register(cellType: XSGoodsInfoGoldTicketTableViewCell.self)
        tableV.register(cellType: TBGoodsInfoTableViewCell.self)
        tableV.register(cellType: TBGoodsInfoHeaderApplyTicketTableViewCell.self)

        
        tableV.register(cellType: TBPicLocationPacketTitleTableViewCell.self)
        tableV.register(cellType: TBPicLocationPacketContentTableViewCell.self)
        tableV.register(cellType: TBPicLocationBuyMustTableViewCell.self)
        tableV.register(cellType: XSPicLocationPacketMoreTableViewCell.self)
        tableV.register(cellType: TBPicLocationApplyMerchTableViewCell.self)
        
        tableV.register(cellType: TBGoodsInfoHeaderViewPicCell.self)
        tableV.register(cellType: TBGoodsInfoHeaderApplyTicketTableViewCell.self)

        return tableV;
    }()
    
    lazy var bottomView: XSGoodsInfoBottomView = {
        let bottom = XSGoodsInfoBottomView()
        bottom.delegate = self
        return bottom
    }()
    
    lazy var cartBtn: XSMerchInfoCartButton = {
        return XSMerchInfoCartButton()
    }()
    
    
    init(style homeShowStyle: HomeShowStyle,merchantId: String?, goodId: String?) {
        self.showHomeStyle = homeShowStyle
        self.merchantId = merchantId
        self.goodsId = goodId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(FMScreenScaleFrom(65))
            make.bottom.equalTo(self.view.usnp.bottom)
        }
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(bottomView.snp_top)
        }
        
        view.addSubview(cartBtn)
        cartBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-60)
        }
        
        cartBtn.cartNum = 0
    
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        self.navigationTitle = "团购详情"
        
        if showHomeStyle == .groupBuy {
            let shareItem = UIBarButtonItem.gk_item(image:UIImage(named: "nav_share_black_icon"), target: self, action: #selector(shareAction))
            self.navigationItem.rightBarButtonItems = [collectItem, shareItem]
        }
        
    }
    
    override func initData() {
        let viemModel = TBMerchInfoViewModel(style: self.showHomeStyle)
        XSTipsHUD.showLoading("", inView: self.view)
        
        guard let goodsId = goodsId else {
            uLog("传递参数有误，请检查")
            return
        }
        
        viemModel.fetchGoodsInfoData(bizType: self.showHomeStyle.rawValue, goodsId: goodsId)
        viemModel.delegate = self
        
        getCartOrderInfo()
        
        
    }

    @objc func shareAction() {
        print(#function)
    }
    @objc func collectAction(collectionButton: UIButton) {
        let collectType = collectionButton.isSelected ? 1 : 0

        guard let goodsId = goodsId,let merchantId = merchantId  else {
            uLog("传递参数有误，请检查")
            return
        }

        MerchantInfoProvider.request(.saveCollectGoods(_merchantId: merchantId, goodsId: goodsId, goodsType: self.showHomeStyle.rawValue, type: collectType), model: XSMerchInfoHandlerModel.self) { returnData in

            if returnData?.trueOrFalse ?? 0 == 0 {
                XSTipsHUD.showSucceed("操作成功")
                collectionButton.isSelected = !collectionButton.isSelected

            } else {
                XSTipsHUD.showSucceed("操作失败")
            }

        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

    }

}
// MARK: - XSGoodsInfoBottomViewDelegate
extension XSGoodsInfoGroupBuyTicketViewController: XSGoodsInfoBottomViewDelegate {
    func nowBuyBtnAction() {
        
    }
    
    func addCartBtnAction() {
        
        var goodsId = ""
        if self.showHomeStyle == .groupBuy {
            goodsId = groupBuyGoodsItem.goodsId
        }
        
        if self.showHomeStyle == .ticket {
            goodsId = voucherGoodsItem.goodsId
        }
        
        guard let merchantId = merchantId  else {
            uLog("传递参数有误，请检查")
            return
        }
        
        MerchantInfoProvider.request(.updateOneSpecShoppingTrolleyCount(buyOfNum + 1 , goodsId: goodsId, merchantId: merchantId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
            if (returnData?.trueOrFalse ?? 0) == 0 {
                // 更新购物车底部的数量, 自己加一次，省的调用接口获取数据
                //self?.getCartOrderInfo()
                self?.buyOfNum += 1
            }
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
}

// MARK: - httpRequest
extension XSGoodsInfoGroupBuyTicketViewController {
  
    
    func getCartOrderInfo() {
        guard let merchantId = merchantId  else {
            uLog("传递参数有误，请检查")
            return
        }
        
        MerchantInfoProvider.request(.getOrderMerchantInCarVO(merchantId), model: TBMerchInfoCartGoodInfoModel.self) { returnData in
            if let cartGoodsInfoModel = returnData {
                
                //self.bottomCartView.cartGoodsInfoModel = cartGoodsInfoModel
                self.buyOfNum = cartGoodsInfoModel.totalAccount
                
            }

        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

    }
}

// MARK: - TBMerchInfoViewModelDelegate
extension XSGoodsInfoGroupBuyTicketViewController: TBMerchInfoViewModelDelegate {
    func onFetchComplete(_ isCollection: Bool, goodsItem: TBGoodsItemModel, _ sections: [TBMerchInfoViewModel]) {
        XSTipsHUD.hideAllTips(inView: self.view)

      
        self.datas = sections
        tableView.reloadData()
        
        if let voucherGoodsItem = goodsItem.voucherGoodsItem {
            self.voucherGoodsItem = voucherGoodsItem
            
            bottomView.finalPriceLabel.text = "¥\(voucherGoodsItem.finalPrice)"
            bottomView.finalPriceLabel.jk.setsetSpecificTextFont("\(voucherGoodsItem.finalPrice)", font:MYBlodFont(size: 30))
            
            bottomView.previousPriceLabel.text = "¥\(voucherGoodsItem.originalPrice)"
            bottomView.reducePrice.text = "\(voucherGoodsItem.discountRate)折"

            let collectBtn = collectItem.customView as! UIButton
            collectBtn.isSelected = (voucherGoodsItem.isCollect == 0)
        }
        
        if let goodBuyItem = goodsItem.groupBuyGoodsItem {
            
            self.groupBuyGoodsItem = goodBuyItem

            
            bottomView.finalPriceLabel.text = "¥\(goodBuyItem.finalPrice)"
            bottomView.finalPriceLabel.jk.setsetSpecificTextFont("\(goodBuyItem.finalPrice)", font:MYBlodFont(size: 30))
            
            bottomView.previousPriceLabel.text = "¥\(goodBuyItem.originalPrice)"
            bottomView.reducePrice.text = "\(goodBuyItem.discountRate)折"
            
            let collectBtn = collectItem.customView as! UIButton
            collectBtn.isSelected = (goodBuyItem.isCollect == 0)
            
        }
        
    }
    
    func onFetchFailed(with reason: String) {
        XSTipsHUD.hideAllTips(inView: self.view)
        XSTipsHUD.showText(reason)
    }
    
}

extension XSGoodsInfoGroupBuyTicketViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = datas[section]
        return sectionModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = datas[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        
        switch rowModel.style {
        case .goodsInfoPicArray:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoHeaderViewPicCell.self)
            let pics = rowModel as! TBGoodsInfoHeaderPiclModel
            cell.picAddress = pics.picAddress
            return cell
        case .goodsInfoItem:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoTableViewCell.self)
            let goods = rowModel as? TBGoodsInfoHeaderGoodsModel
            if let voucherGoodsItem = goods?.voucherGoodsItem {
                cell.voucherGoodsItem = voucherGoodsItem
            }
            
            if let groupBuyGoodsItem = goods?.groupBuyGoodsItem {
                cell.groupBuyItem = groupBuyGoodsItem
            }
            
            return cell
        case .goodsInfoTicket:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoHeaderApplyTicketTableViewCell.self)
            let ticket = rowModel as! TBGoodsInfoHeaderTicketModel
            cell.ticketDataModel = ticket
            return cell
        case .detainInfo:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoDetailTableViewCell.self)
            let detail = rowModel as! TBShopInfoDetailModel
            cell.detailModel = detail
           return cell
        case .evalutateTop:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvalateTableCellTop.self)
            cell.detailModel = rowModel as? TBRepeatTotalModel
            return cell
        case .applyTicketSpace:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoHeaderApplyTicketTableViewCell.self)
            cell.onlyShowTicket()
            cell.containView.hg_setAllCornerWithCornerRadius(radius: 10)
            return cell
        case .goldTicket:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSGoodsInfoGoldTicketTableViewCell.self)
            let gold = rowModel as? XSGoodsInfoGroupBuyGoldTicketModel
            cell.goldTicket = gold
            return cell
        case .goldTicketInfo:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoTableViewCell.self)
            cell.configGoodsInfoTicketUI()
            return cell
        case .applyMerch:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBPicLocationApplyMerchTableViewCell.self)
            cell.applyMerchModel = rowModel as? TBShopInfoApplyMerchModel
            cell.callPhoneClickHandler = { groupBuyModel in
                // 打电话
                guard let phones = groupBuyModel.groupBuyGoodsItem?.merchantTel else { return }
                
                if phones.count > 0 {
                    let sheet = UIAlertController(title: "点击拨打电话", message: "", preferredStyle: .actionSheet)
                    
                    phones.forEach { phone in
                        let phoneAlert = UIAlertAction(title: phone, style: .default) { alert in
                            JKGlobalTools.callPhone(phoneNumber: phone) { bool in
                                uLog(bool)
                            }
                        }
                        sheet.addAction(action: phoneAlert)
                    }
                    let cancel = UIAlertAction(title: "取消", style: .cancel) { alert in
                        
                    }
                    sheet.addAction(action: cancel)
                    
                    self.present(sheet, animated: true, completion: nil)
                    
                }
                
            }
            return cell
        case .evalutate:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvaluateTableCell.self)
            cell.configureRepeatModel(repeatModel: rowModel as! TBRepeatModel)
            return cell
        case .recommand:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSFootMarkTableViewCell.self)
            cell.configShopInfoUI()
            return cell
        case .packageDetailInfoTitle:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBPicLocationPacketTitleTableViewCell.self)
            let model = rowModel as! TBShopInfoPacketDetailInfoTitleModel
            cell.infoModel = model
            return cell
        case .packageDetailInfoContent:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBPicLocationPacketContentTableViewCell.self)
            let model = rowModel as! TBShopInfoPacketDetailInfoContentModel
            cell.infoModel = model
            return cell
        case .buyMustKnow:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBPicLocationBuyMustTableViewCell.self)
            let model = rowModel as! TBShopInfoBuyMustKnowModel
            cell.infoModel = model
            return cell
        case .packageDetailMore:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSPicLocationPacketMoreTableViewCell.self)
            let model = rowModel as! TBShopInfoPacketDetailMoreModel
            cell.moreModel = model
            return cell
        default:
            return UITableViewCell()
      }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = datas[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        return rowModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = datas[section]
        guard let _ = sectionModel.sectionHeaderTitle else {
            return 0.0001
        }
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionModel = datas[section]
        guard let sectionHeaderTitle = sectionModel.sectionHeaderTitle else {
            return nil
        }
        
        let header = tableView.dequeueReusableHeaderFooterView(TBHomeDeliverReusableView.self)!
        header.configMerchInfo(more: sectionModel.sectionHeaderSubTitle)
        header.indicatorTitle.text = sectionHeaderTitle

        header.moreBtnClickHandler = { header in
           // guard let self = self else { return }
            guard let merchantId = self.merchantId  else {
                uLog("传递参数有误，请检查")
                return
            }
            
            let moreEvaluate = XSMerchInfoMoreEvaluateViewController(merchantId: merchantId)
            topVC?.navigationController?.pushViewController(moreEvaluate, animated: true)
            
        }
        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //self.delegate?.locationViewDidEndAnimation(scrollView: scrollView)
    }

}
