//
//  TBShopInfoHeaderView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/15.
//

import UIKit
import AVFoundation

protocol TBGoodsInfoHeaderViewDelegate : NSObjectProtocol {
    func addCartBtnClick(_ goodsItem: TBTakeoutGoodsItem)
}

class TBGoodsInfoHeaderView: TBBaseTableView {
    weak var headerDelegate: TBGoodsInfoHeaderViewDelegate?
    
    var headers: [TBGoodsInfoHeaderViewModel] = [TBGoodsInfoHeaderViewModel]()
    
    func bingData(data: [TBGoodsInfoHeaderViewModel]) {
        headers = data
        self.reloadData()
    }

    override func configTableViewUI() {
        super.configTableViewUI()
        self.register(cellType: TBGoodsInfoHeaderViewPicCell.self)
        self.register(cellType: TBGoodsInfoTableViewCell.self)
        self.register(cellType: XSGoodsInfoKillSecondTableViewCell.self)
        self.register(cellType: TBGoodsInfoHeaderApplyTicketTableViewCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = headers[section]
        return sectionModel.cellViewModels.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionModel = headers[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        
        switch rowModel.style {
        case .picArray:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoHeaderViewPicCell.self)
            let pics = rowModel as! TBGoodsInfoHeaderPiclModel
            cell.picAddress = pics.picAddress
            return cell
        case .killSecond:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSGoodsInfoKillSecondTableViewCell.self)
            return cell
        case .goodsInfoItem:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoTableViewCell.self)
            cell.serviceView.isHidden = true
            let goods = rowModel as! TBGoodsInfoHeaderGoodsModel
            cell.goodsItem = goods.goodsItem
            cell.addCartBtnClickHandler = { [weak self] goodsModel in
                guard let self = self else {
                    return
                }
                self.headerDelegate?.addCartBtnClick(goodsModel)

            }
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBGoodsInfoHeaderApplyTicketTableViewCell.self)
            let ticket = rowModel as! TBGoodsInfoHeaderTicketModel
            cell.ticketDataModel = ticket

            return cell
        }
        
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = headers[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        return rowModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.background
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.0001
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
  
    
  
   
}


