//
//  XSDelieverMerchInfoSearchViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/29.
//

import UIKit

class TBDelieverMerchInfoSearchViewController: XSBaseViewController {

    var merchantId: String = ""
    var cartGoodsInfoModel: TBMerchInfoCartGoodInfoModel!
    var searchGoods: [GoodsItemVo] = [GoodsItemVo]()
    
    lazy var popView: TBCartPopView = {
        return TBCartPopView()
    }()

    lazy var bottomCartView: TBCartBottomView = {
        let bottomView = TBCartBottomView.loadFromNib()
        bottomView.cartBottomClickHandler = { [weak self] bottomView in
            self?.popView.getCartOrderInfo(merchantId: self?.merchantId ?? "")
            self?.popView.cartClarAllHandler = { [weak self] popViw in
                
                bottomView.cartNumBadge = 0
                if let model = popViw.cartGoodInfoModel {
                    self?.setCartAccountZero(true, cartGoodsInfoModel: model)
                }
                
            }
            self?.popView.show(showSuperView: self?.view, bottomSpace: bottomCartViewH)
            self?.view.bringSubviewToFront(bottomView)

            /// 将一个UIView显示在最前面,调用其父视图的 bringSubviewToFront（）
            /// 将一个UIView层推送到背后,调用其父视图的 sendSubviewToBack（）
        }
        return bottomView
    }()
    
    lazy var searchTableView: UITableView = {
        let sw = UITableView(frame: CGRect.zero, style: .plain)
        sw.backgroundColor = UIColor.background
        sw.delegate = self
        sw.dataSource = self
        sw.register(cellType: TBMerchInfoRightTableViewCell.self)
        sw.separatorStyle = .none
        return sw
    }()
    
    lazy var searchTextField: TBSearchTextField = {
        let search = TBSearchTextField()
        search.frame = CGRect(x: 15, y: 15, width: screenWidth - 30, height: 30)
        search.searchDelegate = self
        return search
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    init(merchantId: String) {
        self.merchantId = merchantId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(shopCartPopViewReduceClick(notice:)), name: NSNotification.Name.XSCartMerchInfoPopCellReduceBtnClickNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(shopCartPopViewPlusClick(notice:)), name: NSNotification.Name.XSCartMerchInfoPopCellplusBtnClickNotification, object: nil)
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        self.navigationItem.titleView = searchTextField
    }
    
    
    override func initSubviews() {
        super.initSubviews()
        
        self.view.addSubview(bottomCartView)
        bottomCartView.snp.makeConstraints { make in
            make.height.equalTo(bottomCartViewH)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.usnp.bottom)
        }
        
        self.view.addSubview(searchTableView)
        searchTableView.snp.makeConstraints {
            $0.left.equalTo(self.view.snp_left).offset(0)
            $0.right.equalTo(self.view.snp_right).offset(0)
            $0.top.equalTo(self.view.snp.top).offset(0)
            $0.bottom.equalTo(bottomCartView.snp_top).offset(0)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        conformUser2MerchantDistance()
    }
    
    override func initData() {
        super.initData()
        getCartOrderInfo()
        conformUser2MerchantDistance()
    }
    
    func setCartAccountZero(_ zero: Bool, cartGoodsInfoModel: TBMerchInfoCartGoodInfoModel ) {
        cartGoodsInfoModel.orderShoppingTrolleyVOList?.forEach({ orderShoppingTrolleyVOList in
            
            self.searchGoods.forEach { goodsInfoModel in
                if goodsInfoModel.goodsId == orderShoppingTrolleyVOList.goodsId {
                    if zero {
                        goodsInfoModel.merchInfoShopState = goodsInfoModel.isChoose == .isChoose ? .selectStandard : .normal
                        goodsInfoModel.buyOfNum = 0
                    } else {
                        
                        goodsInfoModel.merchInfoShopState = .plusReduce
                        goodsInfoModel.buyOfNum += orderShoppingTrolleyVOList.account
                    }
                    
                    
                }
            }
        })
        self.searchTableView.reloadData()
    }
    
}

// MARK: - httpRequest
extension TBDelieverMerchInfoSearchViewController {
    func getCartOrderInfo() {
        MerchantInfoProvider.request(.getOrderMerchantInCarVO(merchantId), model: TBMerchInfoCartGoodInfoModel.self) { returnData in
            uLog(returnData)
            if let cartGoodsInfoModel = returnData {
                //NotificationCenter.default.post(name: NSNotification.Name.XSJoinGoodsInCartNotification, object: self, userInfo: ["cartGoodsInfo" : cartGoodsInfoModel])
                
                // 获取加到购物车的数据，是不是同一个商品相同规格
                //DispatchQueue.main.async {
                    //self.setGoodsInfoMoreSpec(cartGoodsInfoModel)
                //}
                self.cartGoodsInfoModel = cartGoodsInfoModel
                
                self.setGoodsInfoMoreSpec(cartGoodsInfoModel)
                
                self.bottomCartView.cartGoodsInfoModel = cartGoodsInfoModel
               
            }

        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

    }
    
    func searchText(text: String) {
        XSTipsHUD.showLoading("", inView: self.view)
        MerchantInfoProvider.request(.shopSearchGoods(_merchantId: merchantId, goodsName: text), model: [GoodsItemVo].self) { returnData in
            XSTipsHUD.hideAllTips(inView: self.view)
            
            self.searchGoods.removeAll()
            
            if let models = returnData {
                if models.count > 0 {
                    self.searchGoods = models
                    self.setupGoodBuyNum(models)
                    
                    self.getCartOrderInfo()
                    
                } else {
                    self.searchTableView.uempty = UEmptyView(description: "暂无搜索数据")
                    self.searchTableView.uempty?.emptyState = .noDataState
                    self.searchTableView.uempty?.allowShow = true
                    self.searchTableView.reloadData()
                }
               
            }
            
           
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.hideAllTips(inView: self.view)
            XSTipsHUD.showText(errorMsg)
        }

    }
    
    func setGoodsInfoMoreSpec(_ cartGoodsInfoModel: TBMerchInfoCartGoodInfoModel) {
        cartGoodsInfoModel.orderCarGoodsAccountVOList?.forEach{ [weak self] accountMoel in
            guard let self = self else { return }
            self.searchGoods.forEach { goodsInfoModel in
                    if goodsInfoModel.goodsId == accountMoel.goodsId {
                        goodsInfoModel.moreSpec = accountMoel.moreSpec
                        
                    }
                }
        }
        self.searchTableView.reloadData()
    }
    
    /// 根据购物车返回的数量，给查询的商品，赋值数量
    func setupGoodBuyNum(_ searchGoodsModel: [GoodsItemVo]) {
        guard let orderShoppingTrolleyVolist = self.cartGoodsInfoModel.orderShoppingTrolleyVOList else { return }
        
        orderShoppingTrolleyVolist.forEach({ orderShoppingTrolleyVOList in
            searchGoodsModel.forEach { goodsItemVo in
                if goodsItemVo.goodsId == orderShoppingTrolleyVOList.goodsId {
                    goodsItemVo.buyOfNum += orderShoppingTrolleyVOList.account
                    goodsItemVo.merchInfoShopState = .plusReduce
                }
            }
            
        })
        self.searchTableView.reloadData()
    }
    
    func conformUser2MerchantDistance() {
        
        MerchantInfoProvider.request(.conformUser2MerchantDistance(lat, lon, merchantId), model: XSMerchInfoHandlerModel.self) { returnData in
            if (returnData?.trueOrFalse ?? 0) != 0 {
                let outDistance = XSDelieveOutDistancePopView()
                outDistance.changeLocationDidSelectHandler = { popView in
                    let address = XSPayAddressViewController()
                    self.navigationController?.pushViewController(address, animated: true)
                    
                }
                outDistance.show()
            }
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    
}

// MARK: - TBSearchTextFieldDelegate
extension TBDelieverMerchInfoSearchViewController: TBSearchTextFieldDelegate {
    func searchTextFieldDidClickSearchBtn(textField: TBSearchTextField) {
        uLog(textField.text)
        if let text = textField.text {
            searchText(text: text)
            self.view.endEditing(true)
        }
    }
    
    func searchTextFieldDidBeginEditing(textField: TBSearchTextField) {
        print("searchTextFieldDidBeginEditing" + textField.text!)
    }
    
    func searchTextFieldDidTextChange(textField: TBSearchTextField) {
        
        guard let text = textField.text else { return }
        if text.isEmpty {
            self.searchGoods.removeAll()
            self.searchTableView.reloadData()
        }
        print("searchTextFieldDidTextChange:" + text)
    }

}

// MARK: - TBMerchInfosearchTableViewCellDelegate
extension TBDelieverMerchInfoSearchViewController: TBMerchInfoRightTableViewCellDelegate {
    func rightTableViewCell(_ tableViewCell: TBMerchInfoRightTableViewCell, buyNumZero rightInfoModel: GoodsItemVo) {

        if rightInfoModel.isChoose == .isChoose {
            rightInfoModel.merchInfoShopState = .selectStandard
        } else {
            rightInfoModel.merchInfoShopState = .normal
        }
        
        rightInfoModel.buyOfNum = 0
        
        self.searchTableView.reloadData()

    }
    

    /// 点击plusReduce了+号按钮
    func rightPlusBtnClick(_ tableViewCell: TBMerchInfoRightTableViewCell) {
        rightBuyButtonClickHandler(tableViewCell: tableViewCell)
    }
    
    func rightReduceBtnClick(_ tableViewCell: TBMerchInfoRightTableViewCell){
        
        let model = tableViewCell.rightInfoModel!
        
        if model.moreSpec == 0 {
            XSTipsHUD.showText("不同规格的商品需在购物车减购", inView: self.view, hideAfterDelay: 0.25)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.popView.show(showSuperView: self.view, bottomSpace: bottomCartViewH)
                self.view.bringSubviewToFront(self.bottomCartView)
            }
            return
        }
        
        let count = model.buyOfNum - 1
        let goodsId = model.goodsId
        
        MerchantInfoProvider.request(.updateOneSpecShoppingTrolleyCount(Int(count), goodsId: goodsId, merchantId: merchantId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
            if (returnData?.trueOrFalse ?? 0) == 0 {
                self?.getCartOrderInfo()
                
                model.buyOfNum -= 1
                
                if model.buyOfNum == 0 {
                    self?.rightTableViewCell(tableViewCell, buyNumZero: model)
                }
                
                tableViewCell.plusRaduceButton.buyNum = UInt(model.buyOfNum)
                

            }
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
        
    }
    func rightBuyButtonClickHandler(tableViewCell: TBMerchInfoRightTableViewCell, count: Int) {
        rightBuyButtonClickHandler(tableViewCell: tableViewCell)
    }

    /// 点击了+号按钮
    func rightBuyButtonClickHandler(tableViewCell: TBMerchInfoRightTableViewCell) {
        uLog("点击了+号按钮")
        
        let model = tableViewCell.rightInfoModel!
        
        if model.isChoose == .isChoose { // 选多规格
            rightTableViewCell(tableViewCell, rightLabelClick: "", rightInfoModel: model)
        } else { // 单规格
            let goodsId = model.goodsId
            
            MerchantInfoProvider.request(.updateOneSpecShoppingTrolleyCount(Int(model.buyOfNum) + 1, goodsId: goodsId, merchantId: merchantId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
                if (returnData?.trueOrFalse ?? 0) == 0 {
                    // 更新购物车底部的数量
                    self?.getCartOrderInfo()
                    
                    // 变成有加减数量的按钮
                    model.merchInfoShopState = .plusReduce
                    
                    model.buyOfNum += 1
                    
                    self?.searchTableView.reloadData()
                
                }
            } errorResult: { errorMsg in
                uLog(errorMsg)
                XSTipsHUD.showText(errorMsg)
            }
        }
    }
    
    /// 点击了选规格的情况
    func rightTableViewCell(_ tableViewCell: TBMerchInfoRightTableViewCell, rightLabelClick rightLabelTitle: String, rightInfoModel: GoodsItemVo) {
        /// 选规格
        if rightInfoModel.isChoose == .isChoose {
            let popView = TBSelectStandardPopView()
            popView.goodsModel = rightInfoModel
            popView.joinCartSuccesHandler = { [weak self] count in
                // 获取加入购物车的数据
                self?.getCartOrderInfo()
                
                // 变成有加减数量的按钮
                rightInfoModel.merchInfoShopState = .plusReduce
                
                rightInfoModel.buyOfNum = rightInfoModel.buyOfNum + count
                
                self?.searchTableView.reloadData()
                
            }
            popView.show()
        }
    }
    
}

// MARK: - notic
extension TBDelieverMerchInfoSearchViewController {
    
    @objc func shopCartPopViewPlusClick(notice: NSNotification) {
        
        guard let model = notice.userInfo?["OrderShoppingTrolleyVOList"] as? OrderShoppingTrolleyVOList
              else { return }
        
        self.getCartOrderInfo()
        
        self.searchGoods.forEach { goodItemVo in
                if goodItemVo.goodsId == model.goodsId {
                    goodItemVo.buyOfNum += 1
                }
            }
        self.searchTableView.reloadData()
    }
    
    @objc func shopCartPopViewReduceClick(notice: NSNotification) {
        
        guard let model = notice.userInfo?["OrderShoppingTrolleyVOList"] as? OrderShoppingTrolleyVOList
              else { return }
        
        self.getCartOrderInfo()
        
        
            searchGoods.forEach { goodItemVo in
                if goodItemVo.goodsId == model.goodsId {
                    goodItemVo.buyOfNum -= 1
                    
                    if goodItemVo.buyOfNum == 0 {
                        goodItemVo.merchInfoShopState = .normal
                    }
                }
            }
        
        self.searchTableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource && UITableViewDelegate
extension TBDelieverMerchInfoSearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGoods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoRightTableViewCell.self)
        cell.rightInfoModel = searchGoods[indexPath.row]
        cell.configSearchStyle()
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let goods = searchGoods[indexPath.section]
        let goodsInfo = TBDelievePrivateKitGoodsInfoVc(style: .deliver, merchantId: merchantId, goodsId: goods.goodsId)
        
        self.navigationController?.pushViewController(goodsInfo, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = self.view.backgroundColor
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = self.view.backgroundColor
        return iv
    }

}
