//
//  CLMyOrderDetailGoodInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/24.
//

import UIKit
import Kingfisher

enum CLMyOrderDetailGoodInfo {
    case shopNmeType
    case shopGoodType(image:String,goodName:String,goodPrice:String,goodNum:String)
    case noDeliverFeeType
    case deliverFeeType
    case discountTitle
    case couponType(title:String,full:String,amt:String)
    case totalInfoType
}

class CLMyOrderDetailGoodInfoCell: XSBaseTableViewCell {
    
    var model:CLMyOrderListModel?{
        didSet{
            guard let newModel = model else { return }
            
            cellModel.append(.shopNmeType)

            for item in newModel.orderGoodsDetailVOList {
                cellModel.append(.shopGoodType(image: item.topPic, goodName: item.goodsName, goodPrice: String(item.salePrice), goodNum: item.account))
            }
            if newModel.bizType == "0"{
                cellModel.append(.noDeliverFeeType)
            }else{
                cellModel.append(.discountTitle)
            }

            for item in newModel.orderCheapInfoVOList {
                cellModel.append(.couponType(title: item.activityName,full: item.activityInfo,amt: item.activityCheapAmt))
            }
            
            cellModel.append(.totalInfoType)

            
            self.goodTableView.reloadData()
        }
    }
    
    
        
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let goodTableView = UITableView().then{
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(cellType: CLMyOrderDetailShopNameCell.self)
        $0.register(cellType: CLMyOrderDetailGoodViewCell.self)
        $0.register(cellType: CLMyOrderDetailNoDeliverCell.self)
        $0.register(cellType: CLMyOrderDetailDiscountTitleCell.self)
        $0.register(cellType: CLMyOrderDetailCouponCell.self)
        $0.register(cellType: CLMyOrderDetailPayTotalCell.self)
        $0.isScrollEnabled = false
    }

    var cellModel:[CLMyOrderDetailGoodInfo] = []
    


    override func configUI() {
//        cellModel.append(.shopNmeType)
//        cellModel.append(.shopGoodType)
//        cellModel.append(.shopGoodType)
//        cellModel.append(.noDeliverFeeType)
//        cellModel.append(.couponType)
//        cellModel.append(.couponType)
//        cellModel.append(.couponType)
//        cellModel.append(.couponType)
//        cellModel.append(.couponType)
//        cellModel.append(.totalInfoType)

        self.contentView.backgroundColor = .lightBackground
        self.contentView.addSubview(baseView)
        baseView.addSubview(goodTableView)
        
        goodTableView.delegate = self
        goodTableView.dataSource = self
        
        baseView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
        }
        
        goodTableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }

    }
}

extension CLMyOrderDetailGoodInfoCell :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .shopNmeType:
            let cell:CLMyOrderDetailShopNameCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailShopNameCell.self)
            cell.shopName.text = self.model?.merchantName
            return cell
        case .shopGoodType(let image,let goodName,let goodPrice,let goodNum):
            let cell:CLMyOrderDetailGoodViewCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailGoodViewCell.self)
            cell.goodName.text = goodName
            cell.goodPrice.text = "￥\(goodPrice)"
            cell.goodNum.text = "x\(goodNum)"
            return cell
        case .noDeliverFeeType:
            let cell:CLMyOrderDetailNoDeliverCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailNoDeliverCell.self)
            return cell
        case .discountTitle:
            let cell:CLMyOrderDetailDiscountTitleCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailDiscountTitleCell.self)
            return cell
        case .couponType(let title,let full,let amt):
            let cell:CLMyOrderDetailCouponCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailCouponCell.self)
            cell.title.text = title
            cell.info.text = full
            cell.price.text = "-￥\(amt)"
            
            if title == "新客满减" {
                cell.image.image = UIImage(named: "new")
            }else if title == "会员权益红包" {
                cell.image.image = UIImage(named: "wallet(1)")

            }
            return cell
        case .totalInfoType:
            let cell:CLMyOrderDetailPayTotalCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailPayTotalCell.self)
            cell.payTotal.text = self.model?.orderPayInfoVO.totalAmt
            cell.totalDiscount.text = self.model?.cheapAmt
            return cell
        default:
            let cell:CLMyOrderDetailNoDeliverCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailNoDeliverCell.self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row] {
        case .shopNmeType:
            return 40
        case .shopGoodType:
            return 110
        case .noDeliverFeeType:
            return 120
        case .discountTitle:
            return 90
        case .discountTitle:
            return 90
        case .couponType:
            return 36
        case .totalInfoType:
            return 77
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
