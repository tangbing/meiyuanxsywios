//
//  TBGoodsInfoPinLocationView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/16.
//

import UIKit
import GKPageSmoothView


class TBGoodsInfoPinLocationView: UIView {
    
    
    var merchantId: String = ""
    var sections = [TBMerchInfoViewModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    public var style: HomeShowStyle = .multiple

    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(headerFooterViewType: TBHomeDeliverReusableView.self)
        tableV.register(cellType: XSFootMarkTableViewCell.self)
        tableV.register(cellType: TBMerchInfoEvalateTableCellTop.self)
        tableV.register(cellType: TBMerchInfoEvaluateTableCell.self)
        tableV.register(cellType: TBGoodsInfoDetailTableViewCell.self)
        
        tableV.register(cellType: TBPicLocationPacketTitleTableViewCell.self)
        tableV.register(cellType: TBPicLocationPacketContentTableViewCell.self)
        tableV.register(cellType: TBPicLocationBuyMustTableViewCell.self)
        tableV.register(cellType: XSPicLocationPacketMoreTableViewCell.self)
        tableV.register(cellType: TBPicLocationApplyMerchTableViewCell.self)
        return tableV;
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .background
        
        self.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self).inset(UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }

    }
    
 
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TBGoodsInfoPinLocationView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = sections[section]
        let count = sectionModel.cellViewModels.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = sections[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        
        switch rowModel.style {
        case .detainInfo:
             let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoDetailTableViewCell.self)
             let detail = rowModel as! TBShopInfoDetailModel
             cell.detailModel = detail
            return cell
        case .evalutateTop:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoEvalateTableCellTop.self)
            return cell
        case .applyMerch:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBPicLocationApplyMerchTableViewCell.self)
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
        let sectionModel = sections[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        return rowModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = sections[section]
        guard let _ = sectionModel.sectionHeaderTitle else {
            return 0.001
        }
        return 40
       
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionModel = sections[section]
        guard let sectionHeaderTitle = sectionModel.sectionHeaderTitle else {
            return nil
        }
        
        let header = tableView.dequeueReusableHeaderFooterView(TBHomeDeliverReusableView.self)!
        header.configMerchInfo(more: sectionModel.sectionHeaderSubTitle)
        header.indicatorTitle.text = sectionHeaderTitle

        header.moreBtnClickHandler = { header in
            //guard let self = self else { return }
            
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
        //self.delegate?.locationViewDidEndAnimation(scrollView: scrollView)
    }

}

extension TBGoodsInfoPinLocationView: GKPageSmoothListViewDelegate,GKPageSmoothViewDelegate {
    func listView() -> UIView {
        return self
    }
    
    func listScrollView() -> UIScrollView {
        return self.tableView
    }

}

