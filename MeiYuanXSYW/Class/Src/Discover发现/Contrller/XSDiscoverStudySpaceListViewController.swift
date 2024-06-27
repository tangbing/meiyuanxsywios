//
//  XSDiscoverStudySpaceListViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit

class XSDiscoverStudySpaceListViewController: XSBaseTableViewController {

    override func setupNavigationItems() {
        super.setupNavigationItems()
    }
    
    override func initSubviews() {
        super.initSubviews()
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.contentInset(top: 10, left: 0, bottom: 10, right: 0)
        
        tableView.register(cellType: XSDiscoverStudySpaceListTableViewCell.self)


    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(tableView)
        tableView.snp_remakeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
    }
    
}

extension XSDiscoverStudySpaceListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverStudySpaceListTableViewCell.self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(XSDiscoverStudySpaceDetailViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.background
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .red
        return iv
    }
    
    

}
