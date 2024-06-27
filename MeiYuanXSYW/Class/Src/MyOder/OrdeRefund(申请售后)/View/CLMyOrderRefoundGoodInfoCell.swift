//
//  CLMyOrderRefoundGoodInfoCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit

enum  RefoundGoodInfoCellType {
    case shopNmeType
    case shopGoodType
}

class CLMyOrderRefoundGoodInfoCell: XSBaseTableViewCell {
    
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
        $0.isScrollEnabled = false
    }

    var cellModel:[RefoundGoodInfoCellType] = []

    override func configUI() {
        cellModel.append(.shopNmeType)
        cellModel.append(.shopGoodType)
        cellModel.append(.shopGoodType)

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

extension CLMyOrderRefoundGoodInfoCell :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch cellModel[indexPath.row] {
        case .shopNmeType:
            let cell:CLMyOrderDetailShopNameCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailShopNameCell.self)
            cell.selectionStyle = .none
            return cell
        case .shopGoodType:
            let cell:CLMyOrderDetailGoodViewCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyOrderDetailGoodViewCell.self)
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row] {
        case .shopNmeType:
            return 40
        case .shopGoodType:
            return 110
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
