//
//  CLMyOrderMemberDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit

enum MyOrderMemberDetail{
    case payInfo      // 会员卡支付信息
    case memberInfo   //会员卡详情
    case orderInfo    // 订单信息
}

class CLMyOrderMemberDetailController:  XSBaseViewController {
    
    var cellModel:[MyOrderMemberDetail] = []

    let topView  = CLMyOrderDetailTopView()
    
    let payView = CLMyOrderDetailPayView().then{
        $0.backgroundColor = .white
    }
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderMemberCardPayDetailCell.self)
        $0.register(cellType: CLMyOrderMemberOrderInfoCell.self)
        $0.register(cellType: CLMyOrderMemberCardInfoCell.self)
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
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = .lightBackground
        
        cellModel.append(.payInfo)
        cellModel.append(.memberInfo)
        cellModel.append(.orderInfo)
        
        self.view.addSubview(topView)
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self

        topView.clickBlock = {[unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
        
        topView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(145 + LL_StatusBarExtraHeight)
        }

    
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(self.view.usnp.bottom).offset(-10)
        }

    }
    
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


extension CLMyOrderMemberDetailController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .payInfo:
            let cell:CLMyOrderMemberCardPayDetailCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderMemberCardPayDetailCell.self)
            return cell
        case .memberInfo:
            let cell:CLMyOrderMemberCardInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderMemberCardInfoCell.self)
            return cell
        case .orderInfo:
            let cell:CLMyOrderMemberOrderInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderMemberOrderInfoCell.self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{

        case .payInfo:
            return 240
        case .memberInfo:
            return 228
        case .orderInfo:
            return 230
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
