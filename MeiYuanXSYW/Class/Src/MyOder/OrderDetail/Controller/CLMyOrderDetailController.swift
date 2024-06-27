//
//  MyOrderDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/23.
//

import UIKit
import Kingfisher

enum MyOrderDetail{
    case contact   // 功能
    case indoor    //上门信息
    case goodInfo  //商品信息
    case addressInfo //地址信息
    case orderInfo // 订单信息
    
    case groupBuyVoucherHead
    case groupBuyVoucherInfo
    case topCorner
    case bottomCorner
}

class CLMyOrderDetailController: XSBaseViewController {
    
    var cellModel:[MyOrderDetail] = []

    let topView  = CLMyOrderDetailTopView()
    
    let payView = CLMyOrderDetailPayView().then{
        $0.backgroundColor = .white
    }
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = UIColor.lightBackground
        $0.register(cellType: CLMyOrderDetailContactCell.self)
        $0.register(cellType: CLMyOrderDetailDropInInfoCell.self)
        $0.register(cellType: CLMyOrderDetailGoodInfoCell.self)
        $0.register(cellType: CLDeliverTypeDeliverCell.self)
        $0.register(cellType: CLMyOrderDetailOrderInfoCell.self)
        
        $0.register(cellType: CLMyOrderDetailShopName2Cell.self)
        $0.register(cellType: CLMyOrderGroupBuyVoucherInfoCell.self)
        $0.register(cellType: CLTopCornerRadioCell.self)
        $0.register(cellType: CLBottomCornerRadioCell.self)

        $0.separatorStyle = .none
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        topView.hg_addGradientColor([UIColor.hex(hexString: "#F6094C"),
                                            UIColor.hex(hexString: "#FF724E")],
                                           size: CGSize(width: screenWidth, height: 145 + LL_StatusBarExtraHeight),
                                    startPoint: CGPoint(x:0.5, y: 0.5),
                                           endPoint: CGPoint(x:1 , y: 1))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cellModel.append(.contact)
        
        cellModel.append(.topCorner)
        cellModel.append(.groupBuyVoucherHead)
        cellModel.append(.groupBuyVoucherInfo)
        cellModel.append(.groupBuyVoucherInfo)
        cellModel.append(.bottomCorner)

        
        cellModel.append(.indoor)
        cellModel.append(.goodInfo)
        cellModel.append(.addressInfo)
        cellModel.append(.orderInfo)
        
        self.view.addSubview(topView)
        self.view.addSubview(tableView)
        self.view.addSubview(payView)
        tableView.delegate = self
        tableView.dataSource = self

        topView.clickBlock = {[unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        
        topView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(145 + LL_StatusBarExtraHeight)
        }

        
        payView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(65)
        }
        
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(payView.snp.top).offset(-10)
        }

    }
    
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


extension CLMyOrderDetailController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .contact:
            let cell:CLMyOrderDetailContactCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailContactCell.self)
            cell.clickBlock = {[unowned self] para in

            }
       
            return cell
        case .goodInfo:
            let cell:CLMyOrderDetailGoodInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailGoodInfoCell.self)
       
            return cell
        case .addressInfo:
            let cell:CLDeliverTypeDeliverCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLDeliverTypeDeliverCell.self)
       
            return cell
        case .orderInfo:
            let cell:CLMyOrderDetailOrderInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailOrderInfoCell.self)
       
            return cell

        case .indoor:
            let cell:CLMyOrderDetailDropInInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailDropInInfoCell.self)
       
            return cell
        case .groupBuyVoucherHead:
            let cell:CLMyOrderDetailShopName2Cell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailShopName2Cell.self)
       
            return cell
        case .groupBuyVoucherInfo:
            let cell:CLMyOrderGroupBuyVoucherInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderGroupBuyVoucherInfoCell.self)
       
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
        case .contact:
            return 100
        case .addressInfo:
            return 245 + 10
        case .orderInfo:
            return 181 + 10
        case .goodInfo:
            return 641
        case .indoor:
            return 176 + 10
        case .groupBuyVoucherHead:
            return 27
        case .groupBuyVoucherInfo:
            return 110
        case .topCorner:
            return 10
        case .bottomCorner:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
