//
//  TBMerchInfoPinLocationView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/29.
//

import UIKit
import GKPageSmoothView



protocol GKPinLoactionViewDelegate: NSObjectProtocol {
    func locationViewDidEndAnimation(scrollView: UIScrollView)
}

class TBMerchInfoPinLocationView: UIView {

    var pageNum: Int = 1
    
    weak var delegate: GKPinLoactionViewDelegate?

    var datas = [TBMerchInfoViewModel]()
    
    var viemModel :TBMerchInfoViewModel?
    
    var merchantId: String = ""
    
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(cellType: TBMerchInfoDiscountTableCell.self)
        tableV.register(cellType: TBMerchInfoPackageTableCell.self)
        tableV.register(cellType: XSCollectMerchTableCell.self)
        tableV.register(cellType: XSCollectShopTableCell.self)
        tableV.register(cellType: TBMerchInfoEvalateTableCellTop.self)
        tableV.register(cellType: TBMerchInfoEvaluateTableCell.self)
        tableV.register(headerFooterViewType: TBHomeDeliverReusableView.self)
        tableV.register(cellType: TBMerchInfoDeliveTableViewCell.self)
        return tableV;
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initRefresh()
        
        self.backgroundColor = .background
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    func initRefresh() {
        self.tableView.uFoot = URefreshAutoFooter(refreshingTarget: self, refreshingAction: #selector(loadMore))
    }
    
    @objc func loadMore(){
        pageNum = pageNum + 1
        
//        MerchantInfoProvider.request(.getNearByStoreAndGoods(_businessType: "\(self.style.rawValue)", lat1: lat, lng1: lon, page: pageNum, pageSize: pageSize), model: TBCommendShopDataModel.self) { returnData in
//
//            if let moreModel = returnData {
//
//                guard let more = moreModel.data?.compactMap({ coupon -> TBMerchInfoModelProtocol in
//                    TBMerchMoreModel(data: coupon, count: moreModel.count,code: moreModel.code)
//                }) else {
//                    return
//                }
//
//                if page == 1 {
//                    let vm5 = TBMerchInfoViewModel(cellViewModels: more)
//                    vm5.sectionHeaderTitle = self.sectionTitles.last ?? ""
//                    self.sections.append(vm5)
//                    self.completeConfigDataHandler?(self.sections)
//
//                } else {
//                    let lastModel = self.sections.last!
//                    lastModel.cellViewModels.append(more)
//                    let isMoreFage = lastModel.cellViewModels.count >= moreModel.count
//                    completeBlock?(self.sections,isMoreFage)
//                }
//
//            }
//
//        } errorResult: { errorMsg in
//            print(errorMsg)
//            failureBlock?(errorMsg)
//            XSTipsHUD.showText(errorMsg)
//        }
        
        
        viemModel?.fetchMoreMerchantInfo(page: pageNum) { [weak self] viewModels, isNoMoreData in
            
            guard let self = self else { return }
            
            if isNoMoreData {
                self.tableView.reloadData()
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            } else {
                self.tableView.reloadData()
                self.tableView.mj_footer?.endRefreshing()
            }
            
        } failureBlock: { errorMsg in
            self.tableView.mj_footer?.endRefreshing()
        }
        
    }
    
    func initData() {
//        let viemModel = TBMerchInfoViewModel()
//        viemModel.fetchData()
//
//        datas = viemModel.sections
//        tableView.reloadData()
        
    }
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TBMerchInfoPinLocationView: UITableViewDataSource, UITableViewDelegate {
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
        case .discount:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoDiscountTableCell.self)
            cell.discountModel = (rowModel as! TBDiscountModel).couponDetail
            return cell
        case .package:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoPackageTableCell.self)
            cell.packageModel = (rowModel as! TBPacketModel).comboDetail
            return cell
        case .deliver:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoDeliveTableViewCell.self)
            let item = rowModel as! TBDeliverModel
            cell.delieveModel = item
            return cell
        case .evalutateTop:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvalateTableCellTop.self)
            cell.detailModel = rowModel as? TBRepeatTotalModel
            return cell
        case .evalutate:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvaluateTableCell.self)
            cell.configureRepeatModel(repeatModel: rowModel as! TBRepeatModel)
            //let repeataa = rowModel as! TBRepeatModel
            return cell
        case .merchMore:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSCollectShopTableCell.self)
            cell.dataModel = (rowModel as! TBMerchMoreModel).data
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSCollectMerchTableCell.self)
            //cell.dataModel = (rowModel as! TBMerchMoreModel).data
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionModel = datas[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
    
        switch rowModel.style {
       
        case .discount:
            let discountModel = (rowModel as! TBDiscountModel).couponDetail
            let ticketVc = XSGoodsInfoGroupBuyTicketViewController(style: .ticket, merchantId:self.merchantId , goodId: discountModel.goodsId)
            topVC?.navigationController?.pushViewController(ticketVc, animated: true)
        case .package:
            let combo = (rowModel as! TBPacketModel).comboDetail
            let groupBuyVc = XSGoodsInfoGroupBuyTicketViewController(style:viemModel?.style ?? .groupBuy, merchantId:self.merchantId , goodId: combo.goodsId)
            topVC?.navigationController?.pushViewController(groupBuyVc, animated: true)
            
        case .merchMore:
            let dataModel = (rowModel as! TBMerchMoreModel).data
            let groupBuyVc = TBGroupBuyMerchInfoViewController(style:viemModel?.style ?? .groupBuy, merchantId:dataModel.merchantId)
            topVC?.navigationController?.pushViewController(groupBuyVc, animated: true)

        default:
            break
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
            return 0.001
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

        header.moreBtnClickHandler = { [weak self] header in
            guard let self = self else { return }
            
            let moreEvaluate = XSMerchInfoMoreEvaluateViewController(merchantId: self.merchantId)
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
        self.delegate?.locationViewDidEndAnimation(scrollView: scrollView)
    }

}

extension TBMerchInfoPinLocationView: GKPageSmoothListViewDelegate,GKPageSmoothViewDelegate {
    func listView() -> UIView {
        return self
    }
    
    func listScrollView() -> UIScrollView {
        return self.tableView
    }

}
