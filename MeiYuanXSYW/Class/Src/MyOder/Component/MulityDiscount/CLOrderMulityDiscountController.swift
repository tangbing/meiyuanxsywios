//
//  CLOrderMulityDiscountController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/31.
//

import UIKit

class CLOrderMulityDiscountController: XSBaseViewController {
    var model:[[String:String]] = [["name":"光感舒颜霜","discount":"9折"],
                                   ["name":"光感舒颜霜","discount":"7折"],
                                   ["name":"光感舒颜霜","discount":"9折"],
                                   ["name":"光感舒颜霜","discount":"9折"]]
    
    let titleLabel = UILabel().then{
        $0.text = "多件折扣"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    let tableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(cellType: CLMulityDiscountCell.self)
        $0.separatorStyle  = .none
    }
    
    let line = UIView().then{
        $0.backgroundColor = .borad
    }
    
    let button = UIButton().then{
        $0.setTitle("我知道了", for: .normal)
        $0.setTitleColor(.king, for: .normal)
        $0.titleLabel?.font = MYFont(size: 16)
        $0.addTarget(self, action: #selector(getIt), for: .touchUpInside)
    }
    
    @objc func getIt(){
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubviews(views: [titleLabel,tableView,line,button])
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(self.model.count * 22)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
                
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(48)
        }
        
        line.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(button.snp.top)
            make.height.equalTo(1)
        }
    }
    
}
extension CLOrderMulityDiscountController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CLMulityDiscountCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMulityDiscountCell.self)
        cell.title.text = self.model[indexPath.row]["name"]
        cell.discount.text = self.model[indexPath.row]["discount"]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 22
    }
    
}
