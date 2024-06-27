//
//  XSCollectShopViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/15.
//

import UIKit
import JXSegmentedView
import GKPageScrollView
import SwiftyJSON
import Moya

class XSCollectMerchantViewController: XSBaseTableViewController {
    
    var model:[CLCollectMerchantListModel] = []
    weak var superVc: XSmineCollectViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func initSubviews() {
        tableView.register(cellType: XSCollectShopTableCell.self)
    }
    
    override func requestData() {
        super.requestData()
        tableView.uempty = UEmptyView(description: "暂无数据")
        tableView.uempty?.emptyState = .noDataState
        tableView.uempty?.allowShow = true
        
        let dic :[String:Any] = ["lng": lon,
                                 "lat": lat,
                                 "userId": userId]
        
        myOrderProvider.request(MyOrderService.getCollectMerchantList(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                uLog(jsonData)
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.model =  jsonData["data"].arrayValue.compactMap{
                        return  CLCollectMerchantListModel.init(jsonData: $0)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

             case let .failure(error):
                //网络连接失败，提示用户
                XSTipsHUD.showText("网络连接失败")
            }
        }
    }

}

extension XSCollectMerchantViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSCollectShopTableCell.self)
        cell.model = self.model[indexPath.row]
        cell.confiGgroupBuy()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.model[indexPath.section]
        
        if model.takeout == 1 || model.groupp == 1 {
            let merchantInfo = TBGroupBuyMerchInfoViewController(style: .multiple, merchantId: model.merchantId)
            superVc.navigationController?.pushViewController(merchantInfo, animated: true)
        } else if(model.takeout == 1) {
            let deliver = TBDeliverMerchanInfoViewController(style: .deliver, merchantId: model.merchantId)
            superVc.navigationController?.pushViewController(deliver, animated: true)
        } else if(model.groupp == 1) {
            let groupBuy = TBGroupBuyMerchInfoViewController(style: .groupBuy, merchantId: model.merchantId)
            superVc.navigationController?.pushViewController(groupBuy, animated: true)
        } else if(model.privateChef == 1) {
            let privateKitchen = TBDeliverMerchanInfoViewController(style: .privateKitchen, merchantId: model.merchantId)
            superVc.navigationController?.pushViewController(privateKitchen, animated: true)
        }

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 272
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

extension XSCollectMerchantViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return self.view
    }

    func listDidAppear() {
        //因为`JXSegmentedListContainerView`内部通过`UICollectionView`的cell加载列表。当切换tab的时候，之前的列表所在的cell就被回收到缓存池，就会从视图层级树里面被剔除掉，即没有显示出来且不在视图层级里面。这个时候MJRefreshHeader所持有的UIActivityIndicatorView就会被设置hidden。所以需要在列表显示的时候，且isRefreshing==YES的时候，再让UIActivityIndicatorView重新开启动画。
//        if (self.tableView.mj_header.isRefreshing) {
//            UIActivityIndicatorView *activity = [self.tableView.mj_header valueForKey:@"loadingView"];
//            [activity startAnimating];
//        }
//        if refreshControl?.isRefreshing == true {
//            refreshControl?.beginRefreshing()
//        }
//        print("listDidAppear")
    }

    func listDidDisappear() {
//        print("listDidDisappear")
    }
}

extension XSCollectMerchantViewController: GKPageListViewDelegate {
    func listScrollView() -> UIScrollView {
        return self.tableView
    }
    
    func listViewDidScroll(callBack: @escaping (UIScrollView) -> ()) {
        
    }
    
    
}
