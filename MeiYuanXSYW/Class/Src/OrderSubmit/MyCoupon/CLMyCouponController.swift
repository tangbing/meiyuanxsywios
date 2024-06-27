//
//  CLMyCouponController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/16.
//

import UIKit

enum MyCoupon{
    case coupon(isAbel:Bool)
    case head(title:String,color:UIColor)
}
class CLMyCouponController: XSBaseViewController {
        
    var cellModel:[MyCoupon]  = []
    
    let titleLabel = UILabel().then{
        $0.text = "我的优惠券"
        $0.font = MYFont(size: 16)
        $0.textColor = .text
    }
    
    
    let closeButton = UIButton().then{
        $0.setImage(UIImage(named: "merchinfo_ticket_closure"), for: .normal)
        $0.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }
    @objc func done(){
        self.dismiss(animated: true, completion: nil)
        
        let NotifMycation = NSNotification.Name(rawValue:"selectMyCoupon")
        NotificationCenter.default.post(name: NotifMycation, object: nil)
    }
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(cellType: CLMyCouponCell.self)
        $0.register(cellType: CLUpgradeMemberHeadCell.self)

        $0.separatorStyle = .none
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        cellModel.append(.coupon(isAbel: true))
        cellModel.append(.coupon(isAbel: true))
        cellModel.append(.head(title:"不可用优惠券",color: .twoText))
        cellModel.append(.coupon(isAbel: false))
        cellModel.append(.coupon(isAbel: false))

        self.view.backgroundColor = .white
        self.view.addSubview(titleLabel)
        self.view.addSubview(closeButton)
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }

        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.usnp.bottom).offset(-20)
        }
    }
}
extension CLMyCouponController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellModel[indexPath.row] {
        case .coupon(let isAble):
            let cell:CLMyCouponCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyCouponCell.self)
            cell.isAbel = isAble
            return cell

        case .head(title: let title, color: let color):
            let cell:CLUpgradeMemberHeadCell = tableView.dequeueReusableCell(for: indexPath, cellType: CLUpgradeMemberHeadCell.self)
            cell.setting(title, color)
            return cell
        }
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellModel[indexPath.row] {
        case .coupon:
            return 90
        case .head:
            return 24
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}
