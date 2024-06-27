//
//  CLPayStatusController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/13.
//

import UIKit
import SwiftUI

class CLPayStatusController: XSBaseViewController {
    var model:CLSubmitPayResultModel?
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLPayStatusCell.self)
        $0.separatorStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightBackground
        self.navigationTitle = "订单支付成功"
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.usnp.top)
            make.bottom.equalTo(self.view.usnp.bottom)
        }
    }
}
extension CLPayStatusController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CLPayStatusCell.self)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
}
