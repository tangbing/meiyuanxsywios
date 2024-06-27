//
//  CLMyOrderRefundController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit

enum MyOrderRefoundCellType{
    case goodInfo
    case refoundCause
    case foodCause
    case deliverCause
    case otherCause
    case uploadImage
    case submitButton
    
    case voucherHead  //(团购)
    case voucherInfo
    case topCorner
    case bottomCorner
}

class CLMyOrderRefundController: XSBaseViewController {
    
    var cellModel:[MyOrderRefoundCellType] = []
    var arr:[Int] = [] //选中数量
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderRefundGroupBuyHeadCell.self)
        $0.register(cellType: CLMyOrderRefundGroupBuyVoucherCell.self)
        $0.register(cellType: CLBottomCornerRadioCell.self)
        $0.register(cellType: CLTopCornerRadioCell.self)
        $0.register(cellType: CLMyOrderRefoundGoodInfoCell.self)
        $0.register(cellType: CLMyOrderRefundCauseCell.self)
        $0.register(cellType: CLMyOrderRefundFoodCauseCell.self)
        $0.register(cellType: CLMyOrderRefundDeliverCauseCell.self)
        $0.register(cellType: CLMyOrderRefundOtherCauseCell.self)
        $0.register(cellType: CLMyOrderRefundUploadImageCell.self)
        $0.register(cellType: CLMyOrderRefundButtonCell.self)
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        cellModel.append(.topCorner)
        cellModel.append(.voucherHead)
        cellModel.append(.voucherInfo)
        cellModel.append(.voucherInfo)
        cellModel.append(.bottomCorner)

        cellModel.append(.goodInfo)
        cellModel.append(.refoundCause)
        cellModel.append(.foodCause)
        cellModel.append(.deliverCause)
        cellModel.append(.otherCause)
        cellModel.append(.uploadImage)
        cellModel.append(.submitButton)

        self.navigationTitle = "申请退款"
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


extension CLMyOrderRefundController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .goodInfo:
            let cell:CLMyOrderRefoundGoodInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefoundGoodInfoCell.self)
            return cell
        case .refoundCause:
            let cell:CLMyOrderRefundCauseCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundCauseCell.self)
            return cell
        case .foodCause:
            let cell:CLMyOrderRefundFoodCauseCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundFoodCauseCell.self)
            return cell
        case .deliverCause:
            let cell:CLMyOrderRefundDeliverCauseCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundDeliverCauseCell.self)
            return cell
        case .otherCause:
            let cell:CLMyOrderRefundOtherCauseCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundOtherCauseCell.self)
            return cell
        case .uploadImage:
            let cell:CLMyOrderRefundUploadImageCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundUploadImageCell.self)
            return cell
        case .submitButton:
            let cell:CLMyOrderRefundButtonCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundButtonCell.self)
            return cell
        case .voucherHead:
            let cell:CLMyOrderRefundGroupBuyHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundGroupBuyHeadCell.self)
            return cell
        case .voucherInfo:
            let cell:CLMyOrderRefundGroupBuyVoucherCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderRefundGroupBuyVoucherCell.self)
            return cell
        case .topCorner:
            let cell:CLTopCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLTopCornerRadioCell.self)
            return cell
        case .bottomCorner:
            let cell:CLBottomCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLBottomCornerRadioCell.self)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        //外卖
        case .goodInfo:
            return 265
        case .refoundCause:
            return 400 + 10
        case .foodCause:
            return 270 + 10
        case .deliverCause:
            return 315 + 10
        case .otherCause:
            return 215
        case .uploadImage:
            return 75 + 30
        case .submitButton:
            return 44 + 30
        //团购
        case .voucherHead:
            return 27
        case .voucherInfo:
            return 75
        case .topCorner:
            return 10
        case .bottomCorner:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch cellModel[indexPath.row] {
        case .voucherHead:
            let cell = tableView.cellForRow(at: indexPath) as! CLMyOrderRefundGroupBuyHeadCell
            cell.select = !cell.select
        
            if cell.select == true {
                self.arr.removeAll() //先清空
                for i in 1...2 {
                    self.arr.append(1) //再增加
                    let index = IndexPath(row: indexPath.row + i, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLMyOrderRefundGroupBuyVoucherCell
                    cell.select = true
                }
                
            }else{
                self.arr.removeAll()
                for i in 1...2 {
                    let index = IndexPath(row: indexPath.row + i, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLMyOrderRefundGroupBuyVoucherCell
                    cell.select = false
                }
            }
            
        case .voucherInfo:
            let cell = tableView.cellForRow(at: indexPath) as! CLMyOrderRefundGroupBuyVoucherCell
            cell.select = !cell.select
            if cell.select == true {
                self.arr.append(1)
                if self.arr.count == 2 {
                    let index = IndexPath(row:1, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLMyOrderRefundGroupBuyHeadCell
                    cell.select = true
                }
            }else{
                self.arr.remove(at: 0)
                if self.arr.count < 2 {
                    let index = IndexPath(row:1, section: 0)
                    let cell = tableView.cellForRow(at: index) as! CLMyOrderRefundGroupBuyHeadCell
                    cell.select = false
                }
            }
        default:
            break
        }
    }
}
