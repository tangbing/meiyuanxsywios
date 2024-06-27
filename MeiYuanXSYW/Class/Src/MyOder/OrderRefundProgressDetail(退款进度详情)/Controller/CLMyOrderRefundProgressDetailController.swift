//
//  CLMyOrderRefundProgressDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

enum CLMyOrderRefundProgressType{
    case topStatus
    case orderInfo
    case orderTitle
    case orderProgress(line1:Bool,line2:Bool)
    case bottomCell
    
    case goodInfo
    case rejectReason
    case refundInfo
    case addReasonInfo
}

class CLMyOrderRefundProgressDetailController: XSBaseViewController {
        
    var cellModel:[CLMyOrderRefundProgressType]  = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderRefundProgessTopCell.self)
        $0.register(cellType: CLMyOrderRefundProgressOrderInfoCell.self)
        $0.register(cellType: CLMyOrderRefundProgressTitleCell.self)
        $0.register(cellType: CLReturnStatusStepCell.self)
        $0.register(cellType: CLBottomCornerRadioCell.self)
        $0.register(cellType: CLDeliverRefundGoodInfoCell.self)
        $0.register(cellType: CLDeliverRefundReasonRejectCell.self)
        $0.register(cellType: CLDeliverRefundInfoCell.self)
        $0.register(cellType: CLDeliverRefundAddReasonCell.self)
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        cellModel.append(.topStatus)
        cellModel.append(.orderInfo)
        cellModel.append(.orderTitle)
        cellModel.append(.orderProgress(line1: false, line2: true))
        cellModel.append(.orderProgress(line1: true, line2: true))
        cellModel.append(.orderProgress(line1: true, line2: false))
        cellModel.append(.bottomCell)
        cellModel.append(.goodInfo)
        cellModel.append(.rejectReason)
        cellModel.append(.refundInfo)
        cellModel.append(.addReasonInfo)

        self.tableView.estimatedRowHeight = 120
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationTitle = "退款详情"
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


extension CLMyOrderRefundProgressDetailController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row] {
        case .topStatus:
            return 170
        case .orderInfo:
            return 228
        case .orderProgress:
            return 65
        case .orderTitle:
            return 55
        case .bottomCell:
            return 10
        case .goodInfo:
            return 164
        case .refundInfo:
            return 270 + 10
        case .addReasonInfo:
            return 320
        case .rejectReason:
            return 143
        }
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellModel[indexPath.row] {
        case .topStatus:
            let cell:CLMyOrderRefundProgessTopCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundProgessTopCell.self)
            return cell
        case .orderInfo:
            let cell:CLMyOrderRefundProgressOrderInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundProgressOrderInfoCell.self)
            return cell
        case .orderProgress(let line1 ,let line2):
            let cell:CLReturnStatusStepCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLReturnStatusStepCell.self)
            cell.line1Status = line1
            cell.line2Status = line2
            return cell
        case .orderTitle:
            let cell:CLMyOrderRefundProgressTitleCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundProgressTitleCell.self)
            return cell
            
        case .bottomCell:
            let cell:CLBottomCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLBottomCornerRadioCell.self)
            return cell
            
        case .goodInfo:
            let cell:CLDeliverRefundGoodInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverRefundGoodInfoCell.self)
            return cell
        case .rejectReason:
            let cell: CLDeliverRefundReasonRejectCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverRefundReasonRejectCell.self)
            return cell
        case .refundInfo:
            let cell: CLDeliverRefundInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverRefundInfoCell.self)
            return cell
        case .addReasonInfo:
            let cell:CLDeliverRefundAddReasonCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverRefundAddReasonCell.self)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
