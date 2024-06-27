//
//  XSDiscoverSearchViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/3.
//

import UIKit

class XSDiscoverSearchViewController: XSBaseViewController {

    //let searchHistorys = ["椰子鸡", "椰子鸡", "椰子鸡", "椰子鸡"]
    var isShowFooterDeleteView: Bool = false {
        didSet {
            searchHistoryTableView.tableFooterView = isShowFooterDeleteView ? clearHistoryfooterView : UIView()
        }
    }
    
    private lazy var searchHistory: [String]! = {
        return UserDefaults.standard.value(forKey: String.searchDiscoverHistoryKey) as? [String] ?? [String]()
    }()
    
    lazy var searchHistoryTableView: UITableView = {
        let sw = UITableView(frame: CGRect.zero, style: .plain)
        sw.backgroundColor = UIColor.lightBackground
        sw.delegate = self
        sw.dataSource = self
        sw.register(cellType: XSDiscoverSearchTableViewCell.self)
        sw.register(cellType: XSDiscoverResultShortTableViewCell.self)
        sw.register(cellType: XSDiscoverResultLongTableViewCell.self)
        sw.separatorStyle = .none
        return sw
    }()
    
    lazy var searchResultTableView: UITableView = {
        let sw = UITableView(frame: CGRect.zero, style: .plain)
        sw.backgroundColor = UIColor.background
        sw.delegate = self
        sw.dataSource = self
        sw.register(cellType: XSDiscoverResultShortTableViewCell.self)
        sw.register(cellType: XSDiscoverResultLongTableViewCell.self)
        sw.separatorStyle = .none
        sw.isHidden = true
        return sw
    }()
    
    lazy var clearHistoryfooterView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 40))
        view.backgroundColor = .white
        
        let button = UIButton()
        button.setTitle("清除搜索记录", for: .normal)
        button.titleLabel?.font = MYFont(size: 14)
        button.setTitleColor(.twoText, for: .normal)
        button.addTarget(self, action: #selector(clear), for: .touchUpInside)
        view.addSubview(button)
        button.frame = view.bounds
        
        return view
    }()
    
    lazy var line: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: 59, width: screenWidth, height: 1))
        line.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        return line
    }()
    
    lazy var searchTextField: TBSearchTextField = {
        let search = TBSearchTextField()
        search.text = "aaaa"
        search.frame = CGRect(x: 15, y: 15, width: screenWidth - 30, height: 30)
        search.searchDelegate = self
        return search
    }()
    
    lazy var searchTextFieldView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        iv.addSubview(searchTextField)
        iv.addSubview(line)
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.background

        self.view.addSubview(searchTextFieldView)
        searchTextFieldView.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view)
            $0.height.equalTo(60)
        }
        
        self.view.addSubview(searchHistoryTableView)
        searchHistoryTableView.snp.makeConstraints {
            $0.left.equalTo(self.view.snp_left).offset(0)
            $0.right.equalTo(self.view.snp_right).offset(0)
            $0.top.equalTo(searchTextFieldView.snp_bottom).offset(0)
            $0.bottom.equalTo(self.view.usnp.bottom)
        }
        
        self.view.addSubview(searchResultTableView)
        searchResultTableView.snp.makeConstraints {
            $0.left.equalTo(self.view.snp_left).offset(10)
            $0.right.equalTo(self.view.snp_right).offset(-10)
            $0.top.equalTo(searchTextFieldView.snp_bottom).offset(0)
            $0.bottom.equalTo(self.view.usnp.bottom)
        }
        
        

    }
    
    @objc func clear() {
        searchHistory.removeAll()
        searchHistoryTableView.reloadData()
        
        isShowFooterDeleteView = !searchHistory.isEmpty

        
        UserDefaults.standard.removeObject(forKey: String.searchDiscoverHistoryKey)
        UserDefaults.standard.synchronize()
    }

}

extension XSDiscoverSearchViewController: TBSearchTextFieldDelegate {
    func searchTextFieldDidBeginEditing(textField: TBSearchTextField) {
        print("searchTextFieldDidBeginEditing" + textField.text!)
    }
    
    func searchTextFieldDidTextChange(textField: TBSearchTextField) {
        print("searchTextFieldDidTextChange:" + textField.text!)
        
        guard let text = textField.text else { return }
        searchRelative(searchText: text)
        
    }
    
    func searchTextFieldDidClickSearchBtn(textField: TBSearchTextField) {
        guard let text = textField.text else { return }
                
        let defaults = UserDefaults.standard
        var histoary = defaults.value(forKey: String.searchDiscoverHistoryKey) as? [String] ?? [String]()
        histoary.removeAll([text])
        histoary.insertFirst(text)
        
        searchHistory = histoary
        searchHistoryTableView.reloadData()
        
        isShowFooterDeleteView = !searchHistory.isEmpty

        
        defaults.set(searchHistory, forKey: String.searchDiscoverHistoryKey)
        defaults.synchronize()
        
    }
    
    private func searchResult(_ text: String) {
        if text.count > 0 {
            searchHistoryTableView.isHidden = true
            searchResultTableView.isHidden = false
            //searchBar.text = text
//            ApiLoadingProvider.request(UApi.searchResult(argCon: 0, q: text), model: SearchResultModel.self) { (returnData) in
//                self.comics = returnData?.comics
//                self.resultTableView.reloadData()
//            }
            
            let defaults = UserDefaults.standard
            var histoary = defaults.value(forKey: String.searchHistoryKey) as? [String] ?? [String]()
            histoary.removeAll([text])
            histoary.insertFirst(text)
            
            searchHistory = histoary
            searchHistoryTableView.reloadData()
            
            defaults.set(searchHistory, forKey: String.searchHistoryKey)
            defaults.synchronize()

        } else {
            searchHistoryTableView.isHidden = false
            searchResultTableView.isHidden = true
        }
    }
    
    private func searchRelative(searchText: String){
        if searchText.count > 0 {
            searchHistoryTableView.isHidden = true
            searchResultTableView.isHidden = false
            
//            currentRequest?.cancel()
//            currentRequest = ApiProvider.request(UApi.searchRelative(inputText: text), model: [SearchItemModel].self) { (returnData) in
//                self.relative = returnData
//                self.searchTableView.reloadData()
//            }
        } else {
            searchHistoryTableView.isHidden = false
            searchResultTableView.isHidden = true

        }
        
    }
    
    
 
}

extension XSDiscoverSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchHistoryTableView {
            return searchHistory.count
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.searchHistoryTableView {
            return 1
        }
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.searchHistoryTableView {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverSearchTableViewCell.self)
            cell.historyDeleteBtnHandler = { [weak self] deletHistoryText in
                let defaults = UserDefaults.standard
                var histoary = defaults.value(forKey: String.searchDiscoverHistoryKey) as? [String] ?? [String]()

                histoary.remove(deletHistoryText)
                self?.searchHistory = histoary
                self?.searchHistoryTableView.reloadData()
                
                self?.isShowFooterDeleteView = !(self?.searchHistory!.isEmpty ?? false)
                defaults.set(self?.searchHistory, forKey: String.searchDiscoverHistoryKey)
                defaults.synchronize()
                
            }
            let searchText = searchHistory[indexPath.row]
            cell.searchText = searchText
            return cell
        } else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverResultShortTableViewCell.self)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSDiscoverResultLongTableViewCell.self)
                return cell
            }
          
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.searchHistoryTableView {
            return 40
        }
        return UITableView.automaticDimension
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
