//
//  XSHomeSearchViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/12.
//

import UIKit
import SwiftyJSON
import HandyJSON

enum TBHomeSearchStyle {
    case homeSearch
    case merchInfoSearch
    
}

class XSHomeSearchViewController: XSBaseViewController {

    
    var searchResults: [TBHomeSearchProtocol] = [TBHomeSearchProtocol]()
    
    var searchStyle: TBHomeSearchStyle = .homeSearch
    
    init(searchStyle: TBHomeSearchStyle = .homeSearch) {
        self.searchStyle = searchStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    var searchText: String?
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var searchReommands: [String]? {
        didSet {
            historyCollectView.reloadData()
        }
    }
    
    var filterVcs = [XSHomeLocationFilterViewController(isTwoStepFilter: true),
                     XSHomeLocationFilterViewController(isTwoStepFilter: false),
                     XSHomeLocationFilterViewController(isTwoStepFilter: true),
                     XSHomeLocationFilterViewController(isTwoStepFilter: false)]
    
    private lazy var searchHistory: [String]! = {
        return UserDefaults.standard.value(forKey: String.searchHistoryKey) as? [String] ?? [String]()
    }()
    
    lazy var scrollToBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.isHidden = true
        btn.setBackgroundImage(#imageLiteral(resourceName: "home_ scroll_top"), for: .normal)
        btn.addTarget(self, action: #selector(scrollTop), for: .touchUpInside)
        return btn
    }()
    
    lazy var cartBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.isHidden = true
        btn.setBackgroundImage(UIImage(named: "search_shoppingcart"), for: .normal)
        btn.addTarget(self, action: #selector(goCart), for: .touchUpInside)
        return btn
    }()
    
    lazy var historyCollectView: UICollectionView = {
        let lt = PPCollectionViewFlowLayout()
        lt.minimumInteritemSpacing = 10
        lt.minimumLineSpacing = 10
        lt.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        cw.backgroundColor = self.view.backgroundColor
        cw.dataSource = self
        cw.delegate = self
        cw.register(cellType: TBHomeSearchHistoryCollectionViewCell.self)

        cw.register(supplementaryViewType: TBHomeSearchHead.self, ofKind: UICollectionView.elementKindSectionHeader)
        return cw
    }()
    
    
    lazy var pullDownMenu: TBPullDownMenu  = {
        let menu = TBPullDownMenu(showInView: self.view,dataSource: self)
        menu.frame = CGRect(x: 0, y: 0, width: screenWidth - 20, height: 40)
        menu.delegate = self
        return menu
    }()

    lazy var searchTableView: UITableView = {
        let sw = UITableView(frame: CGRect.zero, style: .plain)
        sw.backgroundColor = UIColor.lightBackground
        sw.delegate = self
        sw.dataSource = self
        if searchStyle == .homeSearch {
            sw.register(cellType: XSCollectShopTableCell.self)
            sw.register(cellType: TBHomeSearchMoreTableViewCell.self)
            sw.register(cellType: TBHomeSearchResultLessTableViewCell.self)
            sw.register(cellType: XSCollectMerchTableCell.self)
        } else {
            sw.register(cellType: TBMerchInfoRightTableViewCell.self)
        }
        sw.separatorStyle = .none
        return sw
    }()
    
    lazy var searchTextField: TBSearchTextField = {
        let search = TBSearchTextField()
        search.frame = CGRect(x: 15, y: 15, width: screenWidth - 30, height: 30)
        search.searchDelegate = self
        return search
    }()
    
    lazy var line: UIView = {
        let line = UIView(frame: CGRect(x: 0, y: 59, width: screenWidth, height: 1))
        line.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        return line
    }()
    
    lazy var searchTextFieldView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        iv.addSubview(searchTextField)
        iv.addSubview(line)
        return iv
    }()
    
    lazy var bottomCartView: TBCartBottomView = {
        let bottomView = TBCartBottomView.loadFromNib()
        return bottomView
    }()
    
    var pageIndex: Int = 1
    var recommandPageIndex: Int = 1
    var merchantCount: Int = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let searchText = searchText {
            searchTextField.text = searchText
            searchTextFieldDidClickSearchBtn(textField: searchTextField)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationTitle = "搜索"
        self.view.backgroundColor = UIColor.lightBackground
        initSubviewsUI()
        
        
        loadSearchRecommandData()
        
         
        searchTableView.uempty = UEmptyView(description: "暂无数据")
        searchTableView.uempty?.emptyState = .noDataState
        searchTableView.uempty?.allowShow = true
                 
        searchTableView.uFoot = URefreshAutoFooter(refreshingBlock: { [weak self] in
             guard let self = self else { return }
            
            
            self.loadMerchantSearch(searchText: self.searchTextField.text ?? "", pageIdx: self.pageIndex + 1)
            
            
         })
        
    }
     func initSubviewsUI() {
        self.view.backgroundColor = UIColor.lightBackground

        self.view.addSubview(searchTextFieldView)
        searchTextFieldView.snp.makeConstraints {
            $0.left.right.equalTo(self.view)
            $0.top.equalTo(self.view.usnp.top)
            $0.height.equalTo(60)
        }
        
        self.view.addSubview(historyCollectView)
        historyCollectView.snp.makeConstraints {
            $0.left.equalTo(self.view.snp_left).offset(10)
            $0.right.equalTo(self.view.snp_right).offset(-10)
            $0.top.equalTo(searchTextFieldView.snp_bottom).offset(0)
            $0.bottom.equalTo(self.view.usnp.bottom)
        }
        
     
        self.view.addSubview(pullDownMenu)
        pullDownMenu.isHidden = true
        pullDownMenu.snp.makeConstraints {
            $0.left.equalTo(self.view.snp_left).offset(10)
            $0.right.equalTo(self.view.snp_right).offset(-10)
            $0.top.equalTo(searchTextFieldView.snp_bottom).offset(15)
            $0.height.equalTo(40)
        }
        
        self.view.addSubview(searchTableView)
        searchTableView.isHidden = true
        searchTableView.snp.makeConstraints {
            $0.left.equalTo(self.view.snp_left).offset(0)
            $0.right.equalTo(self.view.snp_right).offset(0)
            $0.top.equalTo(pullDownMenu.snp_bottom).offset(15)
            $0.bottom.equalTo(self.view.usnp.bottom)
        }
        
        self.view.addSubview(scrollToBtn)
        scrollToBtn.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 40, height: 40))
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalTo(self.view.usnp.bottom).offset(-46)
        }
        
        self.view.addSubview(cartBtn)
        cartBtn.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 40, height: 40))
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalTo(scrollToBtn.usnp.top).offset(-10)
        }
        
        setupMerchInfoUI()

    }
    
    private func setupMerchInfoUI() {
        if searchStyle == .merchInfoSearch {
            self.view.addSubview(bottomCartView)
            bottomCartView.snp.makeConstraints { make in
                make.height.equalTo(64)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(self.view.usnp.bottom)
            }
            
            searchTableView.snp.remakeConstraints() {
                $0.bottom.equalTo(bottomCartView.usnp.bottom)
                $0.left.equalTo(self.view.snp_left).offset(0)
                $0.right.equalTo(self.view.snp_right).offset(0)
                $0.top.equalTo(pullDownMenu.snp_bottom).offset(15)
//
//                make.bottom.equalTo(bottomCartView.snp_top).offset(0)
            }
        }
    }

    // MARK: - event click
    @objc func rightButtonAction(for button: UIButton) {
        print(button.title(for: .normal)!)
        guard let text = button.title(for: .normal)  else {
            print("button.title nil!!!")
            return
        }
      
        if text == "换一批" {
            loadSearchRecommandData()
        } else {
            print("delete")
            searchHistory.removeAll()
            historyCollectView.reloadData()
            UserDefaults.standard.removeObject(forKey: String.searchHistoryKey)
            UserDefaults.standard.synchronize()
            
        }
    }
    
    @objc func scrollTop() {
        searchTableView.contentOffset = CGPoint.zero
    }
    
    @objc func goCart() {
        print("goCart")
    }

}

// MARK: - httpRequest
extension XSHomeSearchViewController {
    func loadMerchantSearch(searchText: String, pageIdx: Int) {
        MerchantInfoProvider.request(.indexPageMerchantSearch(lat: lat, lng: lon, merchantOrGoodsName:searchText , businessType: "", page: pageIdx, pageSize: pageSize), model: XSHomeMerchantSearchModel.self) { returnData in

            if let merchantModel = returnData {
                //uLog(merchantModel)
                self.merchantCount = merchantModel.count
                
                
                let merchantModel = merchantModel.data.map { merchant -> TBHomeSearchMerchantModel  in
                    TBHomeSearchMerchantModel(searchMerchantModel: merchant)
                }
                self.searchResults.appends(merchantModel)
                
                // 大于10条数据，分页，则显示更多商家
                if self.searchResults.count >= merchantModel.count {
                    self.searchResults = self.searchResults.filter {
                        $0.searchStyle != .moreSearch
                    }
                } else {
                    let moreMerchantModel = TBHomeSearchMoreModel()
                    self.searchResults.append(moreMerchantModel)
                }

                self.loadGoodsSearch(searchText: searchText, pageIdx: pageIdx)
                
                
            }
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }

    func loadGoodsSearch(searchText: String, pageIdx: Int) {
        MerchantInfoProvider.request(.indexPageGoodsSearch(lat: lat, lng: lon, merchantOrGoodsName: searchText, businessType: "", page: pageIdx, pageSize: pageSize), model: XSHomeGoodsSearchModel.self) { returnData in
            
            if let goodsModel = returnData {
                //uLog(goodsModel)

                let goodsModel = goodsModel.data.map { goods -> TBHomeSearchGoodsModel  in
                    TBHomeSearchGoodsModel(searchGoodsModel: goods)
                }
                self.searchResults.appends(goodsModel)
                
                if self.searchResults.count < 10 {
                    let resultLess = TBHomeSearchResultLessModel()
                    self.searchResults.append(resultLess)
                    self.loadSearchBottomRecommand()
                }
                
                
//                if self.searchResults.count >= goodsModel.count + self.merchantCount {
//                    self.searchTableView.uFoot.endRefreshingWithNoMoreData()
//                } else {
//                    self.searchTableView.uFoot.endRefreshing()
//                }
                
                
                self.searchTableView.uFoot.endRefreshing()
                self.searchTableView.reloadData()
                
                
                self.pageIndex += 1
            }

        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    func loadSearchBottomRecommand() {
        
        
        myOrderProvider.request(.getSearchBottomGoods(lat: lat, lng: lon, page: recommandPageIndex, pageSize: 1000)) { result in
            
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    uLog(jsonData["data"])
                    
                    let goodsModels = jsonData["data"].arrayValue.compactMap{
                        return XSHomeGoodsSearchData(jsonData: $0)
                    }
                    
                    let goods = goodsModels.map { searchGoods -> TBHomeSearchGoodsModel  in
                        TBHomeSearchGoodsModel(searchGoodsModel: searchGoods)
                    }
                    self.searchResults.appends(goods)
                        
                    self.searchTableView.uFoot.endRefreshing()
                    self.searchTableView.reloadData()
                    
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

             case let .failure(error):
                //网络连接失败，提示用户
                XSTipsHUD.hideAllTips(inView: self.view)
                XSTipsHUD.showText(error.localizedDescription)
                print("网络连接失败\(error)")
            }
        }

    }

    
    func loadSearchRecommandData() {
        XSTipsHUD.showLoading("", inView: self.view)

        myOrderProvider.request(.getSearchDiscover(userId: nil)) { result in
            XSTipsHUD.hideAllTips(inView: self.view)
            
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{
                    uLog(jsonData["data"])
                    
                    if let signs = jsonData["data"].arrayObject as? [String] {
                        self.searchReommands = signs
                        self.historyCollectView.reloadData()
                    }
                    
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

             case let .failure(error):
                //网络连接失败，提示用户
                XSTipsHUD.hideAllTips(inView: self.view)
                XSTipsHUD.showText(error.localizedDescription)

                print("网络连接失败\(error)")
            }
        }
    }
 
    
}

// MARK: - TBSearchTextFieldDelegate
extension XSHomeSearchViewController: TBSearchTextFieldDelegate {
    func searchTextFieldDidBeginEditing(textField: TBSearchTextField) {
        print("searchTextFieldDidBeginEditing" + textField.text!)
    }
    func searchTextFieldDidTextChange(textField: TBSearchTextField) {
        print("searchTextFieldDidTextChange:" + textField.text!)
        
        guard let text = textField.text else { return }
        searchRelative(text)
    }
    
    
    func searchTextFieldDidClickSearchBtn(textField: TBSearchTextField) {
        self.searchResults.removeAll()
        pageIndex = 1

        guard let text = textField.text else { return }
        searchResult(text)
    }
    
    private func searchResult(_ text: String) {
        if text.count > 0 {

            historyCollectView.isHidden = true
            searchTableView.isHidden = false
            bottomCartView.isHidden = false
            
            self.loadMerchantSearch(searchText: text, pageIdx: pageIndex)
            
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
            historyCollectView.reloadData()
            
            defaults.set(searchHistory, forKey: String.searchHistoryKey)
            defaults.synchronize()
            
            cartBtn.isHidden = searchTableView.isHidden
            scrollToBtn.isHidden = searchTableView.isHidden
            pullDownMenu.isHidden = searchTableView.isHidden
        } else {
            historyCollectView.isHidden = false
            searchTableView.isHidden = true
            bottomCartView.isHidden = true
            
            cartBtn.isHidden = searchTableView.isHidden
            scrollToBtn.isHidden = searchTableView.isHidden
            pullDownMenu.isHidden = searchTableView.isHidden
        }
    }
    
    private func searchRelative(_ text: String) {
        if text.count > 0 {
            historyCollectView.isHidden = true
            searchTableView.isHidden = false
            bottomCartView.isHidden = false

            
            cartBtn.isHidden = searchTableView.isHidden
            scrollToBtn.isHidden = searchTableView.isHidden
            pullDownMenu.isHidden = searchTableView.isHidden
            
//            currentRequest?.cancel()
//            currentRequest = ApiProvider.request(UApi.searchRelative(inputText: text), model: [SearchItemModel].self) { (returnData) in
//                self.relative = returnData
//                self.searchTableView.reloadData()
//            }
        } else {
            historyCollectView.isHidden = false
            searchTableView.isHidden = true
            bottomCartView.isHidden = true

            cartBtn.isHidden = searchTableView.isHidden
            scrollToBtn.isHidden = searchTableView.isHidden
            pullDownMenu.isHidden = searchTableView.isHidden
        }
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate & PPCollectionViewDelegateFlowLayout
extension XSHomeSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate,PPCollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searchHistory.count == 0 ? 1 : 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchHistory.count > 0 && section == 0 {
            return searchHistory.count
        }
        return searchReommands?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TBHomeSearchHistoryCollectionViewCell.self)
        if searchHistory.count > 0 && indexPath.section == 0 {
            cell.titleLabel.text = searchHistory[indexPath.item]
        } else {
            cell.titleLabel.text = searchReommands?[indexPath.item]
        }
        cell.layer.cornerRadius = cell.bounds.height * 0.5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: screenWidth, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: TBHomeSearchHead.self)
        head.rightButton.addTarget(self, action: #selector(rightButtonAction(for:)), for: .touchUpInside)
        if searchHistory.count == 0 {
            head.titleLab.text = "搜素发现"
            head.rightButton.setTitle("换一批", for: .normal)
            head.rightButton.setTitleColor(UIColor.hex(hexString: "#979797"), for: .normal)
            head.rightButton.setImage(UIImage(named: "home_search_refresh"), for: .normal)
            head.rightButton.jk.setImageTitleLayout(.imgRight, spacing: 5)
        } else {
            if indexPath.section == 0 {
                head.titleLab.text = "历史搜索"
                head.rightButton.setTitleColor(UIColor.lightBackground, for: .normal)
                head.rightButton.setTitle("换一批", for: .normal)
                head.rightButton.setImage(UIImage(named: "home_search_delete"), for: .normal)
                head.rightButton.jk.setImageTitleLayout(.imgRight, spacing: 5)
                
            } else {
                head.titleLab.text = "搜素发现"
                head.rightButton.setTitle("换一批", for: .normal)
                head.rightButton.setTitleColor(UIColor.hex(hexString: "#979797"), for: .normal)
                head.rightButton.setImage(UIImage(named: "home_search_refresh"), for: .normal)
                head.rightButton.jk.setImageTitleLayout(.imgRight, spacing: 5)
            }
        }
        
        
        return head
    }

    func backgroundColorForSection(collectionView: UICollectionView, layout: UICollectionViewLayout, section: NSInteger) -> UIColor {
        return UIColor.white
    }
    
    func cornerRadiiForSection(collectionView: UICollectionView, layout: UICollectionViewLayout, section: NSInteger) -> CGSize {
        return CGSize(width: 5, height: 5)
    }
    
    func cornerForSection(collectionView: UICollectionView, layout: UICollectionViewLayout, section: NSInteger) -> UIRectCorner {
        return [.allCorners]
    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var title = ""
        
        if indexPath.section == 0 && searchHistory.count > 0 {
            title = searchHistory[indexPath.item]
        } else {
            title = searchReommands?[indexPath.item] ?? ""
        }
     
        let widht = title.jk.singleLineWidth(font: MYFont(size: 14))
        return CGSize(width: widht + 24, height: 32)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var searchText = ""
        if searchHistory.count > 0 && indexPath.section == 0 {
            searchText = searchHistory[indexPath.item]
        } else {
            if let title = searchReommands?[indexPath.item] {
                searchText = title
            }
        }
        searchTextField.text = searchText
        searchTextFieldDidClickSearchBtn(textField: searchTextField)
    }
}

// MARK: - UITableViewDataSource && UITableViewDelegate
extension XSHomeSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchStyle == .merchInfoSearch {
            return 1
        }
        return self.searchResults.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchStyle == .merchInfoSearch {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoRightTableViewCell.self)
            //cell.contentView.backgroundColor = self.view.backgroundColor
            return cell
        }
        
        let result = searchResults[indexPath.section]
        
        switch result.searchStyle {
        case .merchInfoSearch:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSCollectShopTableCell.self)
            cell.contentView.backgroundColor = self.view.backgroundColor
            let merchantModel = result as? TBHomeSearchMerchantModel
            cell.merchantModel = merchantModel
            return cell
        case .goodsSearch:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSCollectMerchTableCell.self)
            cell.contentView.backgroundColor = self.view.backgroundColor
            let goodsModel = result as? TBHomeSearchGoodsModel

            cell.goodsModel = goodsModel

            cell.addCartClickHandler = { idx in
                print("click 加入购物车 \(idx) cell")
            }
            cell.index = indexPath.section
            return cell
        case .moreSearch:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeSearchMoreTableViewCell.self)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeSearchResultLessTableViewCell.self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchStyle == .merchInfoSearch {
             
        } else {
            let result = searchResults[indexPath.section]
            
            switch result.searchStyle {
            case .moreSearch:
                loadMerchantSearch(searchText: searchTextField.text ?? "", pageIdx: pageIndex + 1)
            case .goodsSearch:
                if let goods = (result as? TBHomeSearchGoodsModel)?.searchGoodsModel
                {
                   let goodsId = goods.goodsId
                    // 跳转到商品详情 商品类型(0:外卖;1:团购;2:私厨)
                    if goods.goodsType == 1 {
                        let goodsInfoVc = XSGoodsInfoGroupBuyTicketViewController(style: .groupBuy, merchantId: goods.merchantId, goodId: goodsId)
                        self.navigationController?.pushViewController(goodsInfoVc, animated: true)
                    } else {
                        if let style = HomeShowStyle(rawValue: goods.goodsType) {
                            let goodsInfoVc = TBDelievePrivateKitGoodsInfoVc(style: style, merchantId: goods.merchantId, goodsId: goodsId)
                            self.navigationController?.pushViewController(goodsInfoVc, animated: true)
                        }
                    }
                   
                }

            case .merchInfoSearch:
                if let merchantModel = (result as? TBHomeSearchMerchantModel)?.searchMerchantModel {
                    let merchantId = merchantModel.merchantId
                    
                    if merchantModel.takeout == 1 && merchantModel.privateChef == 1 &&
                        merchantModel.group == 1 { // 聚合商家详情
                        let mult = TBGroupBuyMerchInfoViewController(style: .multiple, merchantId: merchantId)
                        self.navigationController?.pushViewController(mult, animated: true)

                    } else if merchantModel.takeout == 1 {
                        let kitchen = TBDeliverMerchanInfoViewController(style: .privateKitchen, merchantId: merchantId)
                        self.navigationController?.pushViewController(kitchen, animated: true)
                    } else if merchantModel.privateChef == 1 {
                        let group = TBGroupBuyMerchInfoViewController(style: .privateKitchen, merchantId: merchantId)
                        self.navigationController?.pushViewController(group, animated: true)
                    } else if merchantModel.group == 1 {
                        let group = TBGroupBuyMerchInfoViewController(style: .groupBuy, merchantId: merchantId)
                        self.navigationController?.pushViewController(group, animated: true)
                    }
                    
                   
                }
            default: break
                
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchStyle == .merchInfoSearch {
            return 95
        }
        let result = searchResults[indexPath.section]
        return result.cellHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = self.view.backgroundColor
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = self.view.backgroundColor
        //UIColor.hex(hexString: "#F9F9F9")
        return iv
    }

}

extension XSHomeSearchViewController: TBPullDownMenuDataSource, XSHomeSelectMenuClickDelegate {
    func numberOfColsInMenu(pullDownMenu: TBPullDownMenu) -> NSInteger {
        return self.filterVcs.count
    }
    
    func viewControllerForColAtIndex(index: NSInteger, pullDownMenu: TBPullDownMenu) -> UIViewController {
        return filterVcs[index]
    }
    
    func heightForColAtIndex(index: NSInteger, pullDownMenu: TBPullDownMenu) -> CGFloat {
        235
    }
    
    func clickSelectMenu(selectMenu: TBPullDownMenu, selectTitle selectMenuTitle: String) {
        print("titles" + selectMenuTitle)
        //menuBtnShowClick()
    }
    
//    private func menuBtnShowClick() {
//        if self.isViewLoaded && (self.view.window != nil) {
//            UIView.animate(withDuration: 0.3) {
//                self.pageScrollView.mainTableView.contentOffset = CGPoint(x: 0, y: self.headerH)
//                self.pageScrollView.mainTableView.isScrollEnabled = false
//            }
//        }
//    }
//    private func menuBtnDismissClick() {
//        if self.isViewLoaded && (self.view.window != nil) {
//            self.pageScrollView.mainTableView.isScrollEnabled = true
//        }
//    }

}

