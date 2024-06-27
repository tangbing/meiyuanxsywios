//
//  TBHomeSecondContainerVC.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/18.
//

import UIKit

class TBHomeSecondContainerVc: XSBaseTableViewController {

    var activityGoodsModel: HomeSecondActivityGoodsModel = HomeSecondActivityGoodsModel() {
        didSet {
            tableView.reloadData()
        }
    }

    
    var secondStyle: TBHomeStyle?
    
    override func initSubviews() {
        tableView.register(cellType: TBHomeSecondTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.uempty = UEmptyView(description: "暂无数据")
        tableView.uempty?.emptyState = .noDataState
        tableView.uempty?.allowShow = true
    }
    
    
    override func requestData() {
        super.requestData()
    }
    
}
extension TBHomeSecondContainerVc: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return activityGoodsModel.goodsListVoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeSecondTableViewCell.self)
        cell.secondColor = secondStyle?.secondColor
        cell.goodsListModel = activityGoodsModel.goodsListVoList[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.background
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .red
        return iv
    }
}
