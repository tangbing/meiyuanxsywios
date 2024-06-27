//
//  CLMyNoticeCenterController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/16.
//

import UIKit

enum MyNoticeCenter {
    case top              //顶部功能
    case serviceNotice    //服务消息
    case platformNotice   //平台通知
    case platformActivity //平台活动
    case InteractiveNotice//互动消息
    case onLineService    //在线客服
}

class CLMyNoticeCenterController: XSBaseViewController {
    
    var cellModel:[MyNoticeCenter]  = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(cellType: CLMyNoticeCell.self)
        $0.register(cellType: CLMyNoticeTopCell.self)

        $0.separatorStyle = .none
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        cellModel.append(.top)
        cellModel.append(.serviceNotice)
        cellModel.append(.platformNotice)
        cellModel.append(.platformActivity)
        cellModel.append(.InteractiveNotice)
        cellModel.append(.onLineService)

        self.navigationTitle = "消息中心"
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.usnp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.usnp.bottom)
        }
    }
}
extension CLMyNoticeCenterController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row]{
        case .top:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyNoticeTopCell.self)
            cell.clickBlock = {[unowned self] idx in
                self.navigationController?.pushViewController(CLMyNoticeDetailController(), animated: true)
                uLog("index:\(idx)")
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyNoticeCell.self)
            return cell
        }
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        case .top:
            return 120
        default:
            return 85
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}
