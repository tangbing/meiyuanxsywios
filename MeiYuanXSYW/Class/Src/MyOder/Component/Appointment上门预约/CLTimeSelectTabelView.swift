//
//  CLTimeSelectTabelView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/26.
//

import UIKit

class CLTimeSelectTabelView:UIView {
    
    var clickBlock:((_ para:String)->())?
    
    var leftSelectIndext:Int = 0
    
    var leftModel:[String] = []{
        didSet{
            self.leftTableView.reloadData()
            leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        }
    }

    var rightTotalModel:[[String]] = []{
            didSet{
                self.rightModel = self.rightTotalModel[0]
                self.rightTableView.reloadData()
            }
        }
    
    var rightModel:[String] = ["17:40(可预约)","18:40(可预约)","19:40(可预约)","20:40(可预约)","21:40(可预约)","22:40(可预约)"]
    
    let baseView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let leftTableView = UITableView().then{
        $0.backgroundColor = .lightBackground
        $0.register(cellType: CLTimeSelectLeftCell.self)
        $0.separatorStyle = .none
        
    }
    
    let rightTableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(cellType: CLTimeSelectRightCell.self)
        $0.separatorStyle = .none
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupView() {
        self.addSubview(baseView)
        baseView.addSubviews(views: [leftTableView,rightTableView])
 
        baseView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
        leftTableView.delegate = self
        leftTableView.dataSource = self
//        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        
        rightTableView.delegate = self
        rightTableView.dataSource = self
        
        
        
        leftTableView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(125)
        }
        
        rightTableView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(leftTableView.snp.right)
        }
    }
    
}

extension CLTimeSelectTabelView : UITableViewDataSource ,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return leftModel.count
        }else{
            return  rightModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTableView {
            let cell:CLTimeSelectLeftCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLTimeSelectLeftCell.self)
            cell.model = self.leftModel[indexPath.row]
            
            return cell
        }else{
            let cell:CLTimeSelectRightCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLTimeSelectRightCell.self)
            cell.model = self.rightModel[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == leftTableView {
            return 50
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            self.rightModel = self.rightTotalModel[indexPath.row]
            self.rightTableView.reloadData()
            
        }else{
            
            guard let block = self.clickBlock else {
                return
            }
            block(rightModel[indexPath.row])
        }
        
    }
    
}
