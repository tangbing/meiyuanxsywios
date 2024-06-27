//
//  CLMyOrderRefundDeliverCauseCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/30.
//

import UIKit

class CLMyOrderRefundDeliverCauseCell:  XSBaseTableViewCell {
    
    var clickBlock:((_ para:String,_ index:Int)->())?
    

    var model:[String] = ["配送员服务恶劣","外卖乱放","残损严重","超时15分钟以上","超时30分钟以上","超时1个小时以上"]
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    let titleLabel = UILabel().then{
        $0.text = "配送不太满意(至少选一项)"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 14)
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let tableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(cellType: CLRefoundCommonSelectCell.self)
        $0.separatorStyle = .none
    }
    
    
    override func configUI() {
        self.selectionStyle = .none
        contentView.backgroundColor = .lightBackground
        contentView.addSubview(baseView)
        baseView.addSubviews(views: [titleLabel,line,tableView])
        
        tableView.delegate = self
        tableView.dataSource = self
        
        baseView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12.5)
            make.top.equalToSuperview().offset(13.5)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(line.snp.bottom)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
}

extension CLMyOrderRefundDeliverCauseCell : UITableViewDataSource ,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:CLRefoundCommonSelectCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLRefoundCommonSelectCell.self)
        cell.model = self.model[indexPath.row]
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! CLRefoundCommonSelectCell
        cell.select = !cell.select
        
        guard let block = self.clickBlock else {
            return
        }
        block(model[indexPath.row],indexPath.row)
      }
}
