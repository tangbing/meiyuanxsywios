//
//  XSCollectMerchViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/15.
//

import UIKit
import JXSegmentedView
import GKPageScrollView
import SwiftyJSON
import Moya

class XSCollectGoodsViewController: XSBaseViewController {
    
    var model:[CLMyCollectGoodsListModel] = []
    
    weak var superVc: XSmineCollectViewController!

    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.rowHeight = 110
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(cellType: XSCollectMerchTableCell.self)
        return tableV;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func initSubviews() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.view.usnp.bottom).offset(0)
            make.top.equalTo(self.view.usnp.top)
        }
    }
    
    override func requestData() {
        super.requestData()
        tableView.uempty = UEmptyView(description: "暂无数据")
        tableView.uempty?.emptyState = .noDataState
        tableView.uempty?.allowShow = true
        
        let dic :[String:Any] = ["lng": lon,
                                 "lat": lat,
                                 "userId": userId]
        
        myOrderProvider.request(MyOrderService.getCollectGoodsList(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    
                    self.model =  jsonData["data"].arrayValue.compactMap{
                        return  CLMyCollectGoodsListModel.init(jsonData: $0)
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

extension XSCollectGoodsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSCollectMerchTableCell.self)
        cell.model = self.model[indexPath.section]
        cell.addCartClickHandler = { idx in
            print("click 加入购物车 \(idx) cell")
        }
        cell.index = indexPath.section
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.model[indexPath.section]
        // 商品类型（0外卖1私厨2团购）
        switch model.goodsType {
        case 0:
            let goodsInfo = TBDelievePrivateKitGoodsInfoVc(style: .deliver, merchantId: model.merchantId, goodsId: model.goodsId)
            superVc.navigationController?.pushViewController(goodsInfo, animated: true)
        case 2:
            let goodsInfo = TBDelievePrivateKitGoodsInfoVc(style: .privateKitchen, merchantId: model.merchantId, goodsId: model.goodsId)
            superVc.navigationController?.pushViewController(goodsInfo, animated: true)
        case 1:
            let goodsInfo = XSGoodsInfoGroupBuyTicketViewController(style: .groupBuy, merchantId: model.merchantId, goodId: model.goodsId)
            superVc.navigationController?.pushViewController(goodsInfo, animated: true)
        default:
            break
        }
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

extension XSCollectGoodsViewController: JXSegmentedListContainerViewListDelegate {
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

extension XSCollectGoodsViewController: GKPageListViewDelegate {
    func listScrollView() -> UIScrollView {
        return self.tableView
    }
    
    func listViewDidScroll(callBack: @escaping (UIScrollView) -> ()) {
        
    }
    
    
}

