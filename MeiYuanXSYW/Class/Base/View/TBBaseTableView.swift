//
//  TBBaseTableView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/19.
//

import UIKit

class TBBaseTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configTableViewUI()
    }
    
    func configTableViewUI() {
        self.backgroundColor = .background
        self.tableFooterView = UIView(frame: CGRect.zero)
        self.separatorStyle = .none
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
