//
//  CLMyOrderCommetFinishController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/9.
//

import UIKit
import SwiftyJSON

enum MyOrderCommetFinish {
    case finishStatus
    case head
    case shopInfo(model:CLOtherGetCommentVOList)
    case button
}

class CLMyOrderCommetFinishController: XSBaseViewController {
    
    var cellModel:[MyOrderCommetFinish]  = []
    var model:[CLOtherGetCommentVOList] = []
    
    var bizType:Int = 0
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderCommonStatusCell.self)
        $0.register(cellType: CLMyOrderCommentFinishButtonCell.self)
        $0.register(cellType: CLMyOrderCommetFinishHeadCell.self)
        $0.register(cellType: CLMyOrderCommonOtherCell.self)
        $0.separatorStyle = .none
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellModel.append(.finishStatus)
        
        if self.model.count > 0 {
            cellModel.append(.head)
            for item in self.model {
                cellModel.append(.shopInfo(model: item))
            }
        }
                
        cellModel.append(.button)

    
        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.usnp.top)
            make.bottom.equalTo(self.view.usnp.bottom).offset(-10)
        }

    }
}


extension CLMyOrderCommetFinishController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row] {

        case .finishStatus:
            return 210
        case .head:
            return 55
        case .shopInfo:
            return 85
        case .button:
            return 80
        }
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellModel[indexPath.row] {
        case .finishStatus:
            let cell:CLMyOrderCommonStatusCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderCommonStatusCell.self)
            return cell
        case .head:
            let cell:CLMyOrderCommetFinishHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderCommetFinishHeadCell.self)
            return cell

        case .shopInfo(let model):
            let cell:CLMyOrderCommonOtherCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderCommonOtherCell.self)
            cell.shopName.text = model.merchantName
            cell.shopImage.xs_setImage(urlString: model.merchantLog)
            cell.time.text = "\(model.receiveGoodsTime)消费"
            return cell
            
        case .button:
            let cell:CLMyOrderCommentFinishButtonCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderCommentFinishButtonCell.self)
            cell.commitButton.setTitle("提交评价", for: .normal)
            cell.clickBlock = {[unowned self] in
//                self.submitComment()
            }
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
