//
//  CLMyNoticeDetailController.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/16.
//

import UIKit

class CLMyNoticeDetailController:XSBaseViewController {
    
    var cellModel:[MyNoticeCenter]  = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = .white
        $0.register(cellType: CLMyNoticeCell.self)
        $0.separatorStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.usnp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.usnp.bottom)
        }
    }
}
extension CLMyNoticeDetailController:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModel.count
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CLMyNoticeCell.self)
        return cell
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}
