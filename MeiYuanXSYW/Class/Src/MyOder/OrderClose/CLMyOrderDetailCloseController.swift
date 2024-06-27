//
//  CLMyOrderDetailCloseController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/1.
//

import UIKit

enum MyOrderDetailClose{
    case goodInfo  //商品信息
    case shopInfo  //商家信息
    case headCell  // head
    case topCorner
    case bottomCorner
    case titleCell
    case goodPriceAndNumCell
    case buyKnownOne
    case buyKnownTwo
    case buyKnownThree(text:String)
}

class CLMyOrderDetailCloseController: XSBaseViewController {
    
    var cellModel:[MyOrderDetailClose] = []

    let topView  = CLMyOrderDetailTopView()
    
    let payView = CLMyOrderDetailPayView().then{
        $0.backgroundColor = .white
    }
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLMyOrderDetailGoodInfoCell.self)
        $0.register(cellType: CLMyOrderDetailShopInfoCell.self)
        $0.register(cellType: CLMyOrderDetailHeadCell.self)
        $0.register(cellType: CLMyOrderDetailTitleCell.self)
        $0.register(cellType: CLMyOrderDetailGoodPriceAndNumCell.self)
        $0.register(cellType: CLMyOrderDetailBuyknownOneCell.self)
        $0.register(cellType: CLMyOrderDetailBuyKnownTwoCell.self)
        $0.register(cellType: CLMyOrderDetailBuyKnownThreeCell.self)
        $0.register(cellType: CLBottomCornerRadioCell.self)
        $0.register(cellType: CLTopCornerRadioCell.self)

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
                
        cellModel.append(.goodInfo)
        cellModel.append(.shopInfo)
        cellModel.append(.headCell)
        cellModel.append(.topCorner)
        cellModel.append(.titleCell)
        cellModel.append(.goodPriceAndNumCell)
        cellModel.append(.titleCell)
        cellModel.append(.goodPriceAndNumCell)
        cellModel.append(.goodPriceAndNumCell)
        cellModel.append(.goodPriceAndNumCell)
        cellModel.append(.titleCell)
        cellModel.append(.goodPriceAndNumCell)
        cellModel.append(.goodPriceAndNumCell)
        cellModel.append(.goodPriceAndNumCell)
        cellModel.append(.goodPriceAndNumCell)
        cellModel.append(.titleCell)
        cellModel.append(.goodPriceAndNumCell)
        cellModel.append(.goodPriceAndNumCell)
        cellModel.append(.bottomCorner)
        
        cellModel.append(.headCell)
        cellModel.append(.topCorner)
        cellModel.append(.buyKnownOne)
        cellModel.append(.buyKnownTwo)
        cellModel.append(.buyKnownOne)
        cellModel.append(.buyKnownTwo)
        cellModel.append(.buyKnownOne)
        cellModel.append(.buyKnownThree(text: "2020.8.17至2022.9.10(周末法定节假日通用)2020.8.17至2022.9.10(周末法定节假日通用)"))
        cellModel.append(.buyKnownThree(text: "2020.8.17至2022.9.10(周末法定节假日通用)2020.8.17至2022.9.10(周末法定节假日通用)"))
        cellModel.append(.buyKnownThree(text: "2020.8.17至2022.9.10(周末法定节假日通用)2020.8.17至2022.9.10(周末法定节假日通用)"))
        cellModel.append(.buyKnownThree(text: "2020.8.17至2022.9.10(周末法定节假日通用)2020.8.17至2022.9.10(周末法定节假日通用)"))
        cellModel.append(.bottomCorner)

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


extension CLMyOrderDetailCloseController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {

        case .goodInfo:
            let cell:CLMyOrderDetailGoodInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailGoodInfoCell.self)
       
            return cell

        case .shopInfo:
            let cell:CLMyOrderDetailShopInfoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailShopInfoCell.self)
            return cell
        case .headCell:
            let cell:CLMyOrderDetailHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailHeadCell.self)
            return cell
        case .topCorner:
            let cell:CLTopCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLTopCornerRadioCell.self)
       
            return cell
        case .bottomCorner:
            let cell:CLBottomCornerRadioCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLBottomCornerRadioCell.self)
       
            return cell
        case .titleCell:
            let cell:CLMyOrderDetailTitleCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailTitleCell.self)
       
            return cell
        case .goodPriceAndNumCell:
            let cell:CLMyOrderDetailGoodPriceAndNumCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailGoodPriceAndNumCell.self)
       
            return cell
        case .buyKnownOne:
            let cell:CLMyOrderDetailBuyknownOneCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailBuyknownOneCell.self)
       
            return cell
        case .buyKnownTwo:
            let cell:CLMyOrderDetailBuyKnownTwoCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailBuyKnownTwoCell.self)
       
            return cell
        case .buyKnownThree:
            let cell:CLMyOrderDetailBuyKnownThreeCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailBuyKnownThreeCell.self)
       
            return cell
        }
        

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row]{
        case .goodInfo:
            return 641
        case .shopInfo:
            return 86

        case .headCell:
            return 40
        case .topCorner:
            return 10
        case .bottomCorner:
            return 10
        case .titleCell:
            return 25
        case .goodPriceAndNumCell:
            return 21.5
        case .buyKnownOne:
            return 27
        case .buyKnownTwo:
            return 26.5
        case .buyKnownThree(let text):
            let height = text.boundingRect(with:CGSize(width: screenWidth - 75, height:CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: MYFont(size: 12)], context:nil).size.height
            return height + 5
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
