//
//  XSTestViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/11.
//

import UIKit
import GKPageScrollView
import QMUIKit

class XSTestViewController: XSBaseTableViewController {
        
    var itemsCount = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "测试"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: XSBaseTableViewCell.self)
        
        //XSTipsHUD.showLoading("登录中", inView: self.tableView, hideAfterDelay: 3)
        //QMUITips.showLoading("登录中", in: self.tableView, hideAfterDelay: 6)
        //[QMUITips showLoading:@"加载中..." inView:parentView hideAfterDelay:2];


        
//        tableView.uHead = URefreshAutoHeader(refreshingBlock: { [weak self] in
//            guard let self = self else { return }
//
//
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {[weak self] in
//                guard let self = self else { return }
//
//                XSTipsHUD.hideAllTips(inView: self.view)
//
//
//                self.itemsCount += Int.random(in: 1...5)
//                self.tableView.reloadData()
//
//                self.tableView.mj_header?.endRefreshing()
//            }
//
//
//
//        })
//
//        tableView.uFoot = URefreshAutoFooter(refreshingBlock: { [weak self] in
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {[weak self] in
//                guard let self = self else { return }
//
//                self.itemsCount += Int.random(in: 1...5)
//
//                if self.itemsCount >= 15 {
//                    self.tableView.reloadData()
//                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
//                } else {
//                    self.tableView.reloadData()
//
//                    self.tableView.mj_footer?.endRefreshing()
//                }
//            }
//
//
//        })
        
        
        tableView.uempty = UEmptyView(description: "加载中", tapClosure: {[weak self] in
            guard let self = self else {
                return
            }
            self.tableView.uempty?.allowShow = true
            self.tableView.uempty?.description = "网络错误啦！！！！"
            self.tableView.uempty?.emptyState = .networkingErrorState
            self.tableView.reloadData()
        })

        self.tableView.uempty?.emptyState = .loading
        self.tableView.uempty?.allowShow = true
        tableView.reloadData()

    }
    
    
}

extension XSTestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
        
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}
