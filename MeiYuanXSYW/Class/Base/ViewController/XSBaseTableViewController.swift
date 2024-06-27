//
//  XSBaseTableViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit

class XSBaseTableViewController: XSBaseViewController {
    
    lazy var tableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableV.backgroundColor = .background
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        return tableV;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(tableView)
        tableView.snp_makeConstraints { make in
            make.edges.equalTo(0)
        }
    }


}
