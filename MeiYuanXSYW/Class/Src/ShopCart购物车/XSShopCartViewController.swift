//
//  XSShopCartController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/6.
//

import UIKit
import QMUIKit


class TBNotPlayOrderView: TBBaseView {
    
    lazy var msgLabel: UILabel = {
        let msgLabel = UILabel()
        msgLabel.text = "[商家名称AAAA商家]未满足起送价，无法一键结算"
        msgLabel.textColor = .white
        msgLabel.font = MYFont(size: 12)
        return msgLabel
    }()
   
    
    override func configUI() {
        super.configUI()
        backgroundColor = UIColor.hex(hexString: "#000000")
        alpha = 0.6
        
        addSubview(msgLabel)
        msgLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        
    }
    
   
}

class XSShopCartController: XSBaseViewController {

    var bizType: Int? = nil
    var pageIndex: Int = 1
    var caculateAmtModel: XSShopCaculateMoreAmtModel?
    var selectIds: [Int] = [Int]()
    /// 判断是否可以结算，如果有值则未满足起送价格，如果为nil，则可以结算了
    var checkBalanceOrder: OrderCarVOList?
    
    //var merchantId: String = ""
    var checkOrderSuccess: OrderCarVOList = OrderCarVOList()
    
    var datas: [XSShopCartSectionViewModel] = [XSShopCartSectionViewModel]() {
        didSet {
            cartTableView.reloadData()
        }
    }
    
    lazy var carBottomView: XSShopCartBottomView = {
        let carBottomView = XSShopCartBottomView()
        carBottomView.selectAllBlock = { [weak self] isSelect in
            self?.selectAll(isSelect)
        }
        // 一件结算
        carBottomView.clickAllOrderBlock = {
            guard let hasBalanceOrder = self.checkBalanceOrder else {
            
                // 调到订单结算界面 0外卖，1团购，2私厨 4会员
                if self.checkOrderSuccess.bizType == 0 {
                    let orderSubmitDeliver = CLOrderSubmitDeliverController()
                    orderSubmitDeliver.idList = self.selectIds
                    self.navigationController?.pushViewController(orderSubmitDeliver, animated: true)
                } else if(self.checkOrderSuccess.bizType == 1) {
                    let orderSubmitGroupBuy = CLOrderSubmitGroupBuyController()
                    orderSubmitGroupBuy.idList = self.selectIds

                    self.navigationController?.pushViewController(orderSubmitGroupBuy, animated: true)
                } else if(self.checkOrderSuccess.bizType == 2) {
                    let orderSubmitPrivateKitchen = CLOrderSubmitPrivateKitchenController()
                    orderSubmitPrivateKitchen.idList = self.selectIds

                    self.navigationController?.pushViewController(orderSubmitPrivateKitchen, animated: true)
                }
                return
            }
            
            self.notPlayOrderView.msgLabel.text = "[\(hasBalanceOrder.merchantName)]未满足起送价，无法一键结算"
            self.notPlayOrderView.isHidden = false
            
        }
        
        carBottomView.multSelectActionBlock = {[weak self] in
            self?.multSelect()
        }
        return carBottomView
    }()
    
    lazy var notPlayOrderView: TBNotPlayOrderView = {
        let view = TBNotPlayOrderView()
        view.isHidden = true
        return view
    }()
    
    lazy var cartTableView : UITableView = {
        let tableV = UITableView.init(frame: CGRect.zero, style: UITableView.Style.grouped)
        tableV.backgroundColor = .background
        tableV.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        tableV.tableFooterView = UIView(frame: CGRect.zero)
        tableV.separatorStyle = .none
        tableV.dataSource = self
        tableV.delegate = self
        tableV.register(cellType: XSShopCartInfoTopTableViewCell.self)
        tableV.register(cellType: XSShopCartGroupBuyTableViewCell.self)
        tableV.register(cellType: XSShopCartDelieveTableViewCell.self)
        tableV.register(cellType: XSShopCartPrivateKitchenTableViewCell.self)
        
        //tableV.register(cellType: XSShopCartBaseTableViewCell.self)
        
        tableV.register(cellType: XSShopCartBottomOutBoundsTableViewCell.self)
        tableV.register(cellType: XSShopCartBottomBalanceOrderTableViewCell.self)
        
        tableV.register(cellType: XSFootMarkTableViewCell.self)
        tableV.register(cellType: XSShopCartDiscountInfoTableViewCell.self)

        
        return tableV
    }()
    
    lazy var editButton: UIButton = {
        let edit = UIButton(type:.custom)
        edit.setTitle("编辑", for: .normal)
        edit.setTitle("完成", for: .selected)
        edit.setTitleColor(.black, for: .normal)
        edit.tb_size = CGSize(width: 44, height: 44)
        edit.addTarget(self, action: #selector(editAction(editButton:)), for: .touchUpInside)
        return edit
    }()
    
    lazy var selectAll: QMUIButton = {
        let all = QMUIButton(type: .custom)
        all.setImage(UIImage(named: "mine_tick_normal"), for: .normal)
        all.setImage(UIImage(named: "mine_tick_selected"), for: .selected)
        all.setTitle("全选", for: .normal)
        all.spacingBetweenImageAndTitle = 5
        all.setTitleColor(.text, for: .normal)
        all.titleLabel?.font = MYBlodFont(size: 18)
        all.addTarget(self, action: #selector(selectAllAction(selectAllBtn:)), for: .touchUpInside)
        return all
    }()
    
    lazy var filterButton: UIButton = {
        let edit = UIButton(type:.custom)
        edit.setTitle("筛选", for: .normal)
        edit.setTitleColor(.black, for: .normal)
        edit.tb_size = CGSize(width: 44, height: 44)
        edit.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        return edit
    }()
    
    lazy var vm : XSShopCartSectionViewModel = {
        let Vm = XSShopCartSectionViewModel()
        Vm.delegate = self
        return Vm
    }()
    
    
    lazy var filterView : XSShopCartFilterPopView = {
        let filter = XSShopCartFilterPopView()
        filter.filterSelectHandler = {[weak self] buttonTag in
            guard let self = self else { return }
            switch buttonTag {
            case 0:
                self.bizType = nil
            case 1:
                self.bizType = 0
            case 2:
                self.bizType = 1
            case 3:
                self.bizType = 2
            default:
                break
            }
            
            // 重新加载第一页数据
            self.pageIndex = 1
            
            filter.fadeOut()
            
            self.fetchShopCartData()
            //self.cartTableView.uHead.beginRefreshing()
        }
        return filter
    }()
    


    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        
        navigationTitle = "购物车"
        
        let editItem = UIBarButtonItem(customView: editButton)
        self.navigationItem.rightBarButtonItem = editItem

        let filterItem = UIBarButtonItem(customView: filterButton)
        self.navigationItem.leftBarButtonItem = filterItem
        
    }
    
    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(shopCartPopViewReduceClick(notice:)), name: NSNotification.Name.XSCartMerchInfoPopCellReduceBtnClickNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(shopCartPopViewPlusClick(notice:)), name: NSNotification.Name.XSCartMerchInfoPopCellplusBtnClickNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchShopCartData), name: NSNotification.Name.XSCartUpdateSpecAttributeNotification, object: nil)
        
        //NotificationCenter.default.addObserver(self, selector: #selector(fetchShopCartData), name: NSNotification.Name.XSLoginEndNotification, object: nil)

    }
    
    @objc func shopCartPopViewPlusClick(notice: NSNotification) {
        
        guard let _ = notice.userInfo?["OrderShoppingTrolleyVOList"] as? OrderShoppingTrolleyVOList
              else { return }
        
        self.cartTableView.reloadData()
    }
    
    @objc func shopCartPopViewReduceClick(notice: NSNotification) {
        
        guard let _ = notice.userInfo?["OrderShoppingTrolleyVOList"] as? OrderShoppingTrolleyVOList
              else { return }
        
        self.cartTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchShopCartData()
    }
    
     @objc func fetchShopCartData() {

//         cartTableView.uHead = URefreshAutoHeader(refreshingBlock: { [weak self] in
//             guard let self = self else { return }
//
//             self.vm.fetchShopCartData(self.bizType, isEfficacy: true, lat: lat, lng:lon, page: 1, pageSize: 2)
//
//         })
         
//         cartTableView.uFoot = URefreshAutoFooter(refreshingBlock: { [weak self] in
//             guard let self = self else { return }
             
            // self.vm.fetchShopCartData(self.bizType, isEfficacy: true, lat: lat, lng:lon, page: self.pageIndex + 1, pageSize: 2)
         //})
         
//         self.cartTableView.uHead.beginRefreshing()
         
         if XSAuthManager.shared.isLoginEd {
             XSTipsHUD.showLoading("", inView: self.view)
             self.vm.fetchShopCartData(self.bizType, isEfficacy: true, lat: lat, lng:lon, page: 1, pageSize: 1000)
         }
         
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObserver()
        
        self.view.addSubview(carBottomView)
        carBottomView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(65)
        }
        
        self.view.addSubview(cartTableView)
        cartTableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(self.view.usnp.top)
            make.bottom.equalTo(carBottomView.snp_top)
        }
        
        self.view.addSubview(notPlayOrderView)
        notPlayOrderView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.bottom.equalTo(carBottomView.snp_top).offset(0)
            make.left.right.equalToSuperview()
        }
        
        cartTableView.uempty = UEmptyView(description: "暂无数据")
        cartTableView.uempty?.emptyState = .noDataState
        cartTableView.uempty?.allowShow = true
        
    }
}

typealias selectCaculateCompleteBlock = ((_ caculateAmtModel : XSShopCaculateMoreAmtModel ) -> Void)
// MARK: - httpRequest
extension XSShopCartController: XSShopCartSectionViewModelDelegate {
    
    func caculateMoreAmt(select id: Int,selectCompleteBlock: @escaping selectCaculateCompleteBlock) {
        
        guard selectIds.count > 0 else {
            return
        }
        
        MerchantInfoProvider.request(.calculateMoreCarAmt(_idList: selectIds, isSettle: false), model: XSShopCaculateMoreAmtModel.self) { returnData in
            
            guard let caculateAmtModel = returnData else { return }
            self.caculateAmtModel = caculateAmtModel
            selectCompleteBlock(caculateAmtModel)
            
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }

    }

    
    
    func onFetchComplete(datas sections: [XSShopCartSectionViewModel], isNomoreData: Bool) {
        //self.cartTableView.uHead.endRefreshing()
        
//        if isNomoreData {
//            self.cartTableView.uFoot.endRefreshingWithNoMoreData()
//        } else {
//            self.cartTableView.uFoot.endRefreshing()
//            pageIndex += 1
//        }
        
        XSTipsHUD.hideAllTips()

        self.datas = sections
        
        
    }
    
   
    func onFetchFailed(with reason: String) {
//        self.cartTableView.uHead.endRefreshing()
//        self.cartTableView.uFoot.endRefreshing()
        
        XSTipsHUD.hideAllTips()
        XSTipsHUD.showText(reason)
    }
    
}

// MARK: - event touch
extension XSShopCartController {
    
    func applyTicket(merchantId: String) {
        let applyTicket = XSShopCartApplyTicketPopView()
        applyTicket.merchantId = merchantId
        applyTicket.show()
    }
    
    @objc func cartClarLoseTimeAction(button: QMUIButton) {
        let selectSection = button.tag
        
        self.showAlert(title: "清空商品", message: "确认删除所有失效商品？", alertType: .alert, sureBlock: {[weak self] in
            
            MerchantInfoProvider.request(.delTrolleyOrNoEfficacy("" , status: 0), model: XSMerchInfoHandlerModel.self) { [weak self] returnData in
                guard let self = self else {
                    return
                }
                
                if (returnData?.trueOrFalse ?? 0) == 0 {
                    self.cartTableView.beginUpdates()
                    self.datas.remove(at: selectSection)

                    self.cartTableView.deleteSections([selectSection], with: .none)
                    self.cartTableView.endUpdates()
                    
                }
                
            } errorResult: { errorMsg in
                uLog(errorMsg)
                XSTipsHUD.showText(errorMsg)
            }
            
            
            
        }, cancelBlock: nil)
    }
    
    @objc func selectAllAction(selectAllBtn: QMUIButton) {
        selectAll(selectAllBtn.isSelected)
    }
    
    @objc func editAction(editButton: UIButton) {
        carBottomView.configOnlyDelete(isShowDelete: editButton.isSelected)
        editButton.isSelected = !editButton.isSelected
    }
    
    @objc func filterAction() {
       
        filterView.show(showSuperView: self.view)
    }
    
}

// MARK: - 私有Helper function
extension XSShopCartController {
    /// 选中全部
    private func selectAll(_ isSelect: Bool) {
        
        var selects = [Int]()
        
        selects.removeAll()
        selectIds.removeAll()
        
        if !isSelect {

            self.datas.forEach { model in
                for var cellModel in model.cellViewModels {
                    cellModel.isSelect = isSelect
                }
            }
            //取消选中，则要删除计算结果
            for (idx, sectionModel) in self.datas.enumerated() {
                self.clearAllBottom(sectionModel: sectionModel)
            }
            
            self.cartTableView.reloadData()

            /// 多选，底部View更新
            self.caculateAmtModel?.orderCarVOList.removeAll()
            self.selectStateForBottomView(isSelect)

            return
        }
      
        self.datas.forEach { model in
            for var cellModel in model.cellViewModels {
                cellModel.isSelect = isSelect
                if isSelect {
                    selects.append(cellModel.Id)
                    selectIds = selects.filter {
                        return $0 > 0
                    }
                }
               
            }
        }
        
        self.caculateMoreAmt(select: 11) { caculateAmtModel in
            for (idx, sectionModel) in self.datas.enumerated() {
                // 选中，添加计算结果
                if isSelect {
                    let orderCaculModel = caculateAmtModel.orderCarVOList[idx]
                    
                    let info = XSShopCartDiscountInfoModel(caculateMoreAmt:orderCaculModel ,hasTopRadius: false, hasBottomRadius: true)
                    sectionModel.cellViewModels.append(info)
                    
                    self.checkCartOrderBalance(caculate: orderCaculModel, sectionModel: sectionModel)
                    
                }
            }
           
            self.cartTableView.reloadData()
            /// 多选，底部View更新
            
            self.selectStateForBottomView(isSelect)


        }
        
    }
    
    func multSelect(){
       
        var ids = [Int]()
        self.datas.forEach { sectionVm in
            for cellModel in sectionVm.cellViewModels {
                if let groupBuy = cellModel as? XSShopCartGroupBuyModel,
                   groupBuy.isSelect == true {
                    ids.append(groupBuy.orderShoppingTrolleyVOList.id)
                }

                if let delieve = cellModel as? XSShopCartDelieveModel,
                   delieve.isSelect == true{
                    ids.append(delieve.orderShoppingTrolleyVOList.id)
                }

                if let privateKitchen = cellModel as? XSShopCartPrivateKitchenModel,
                   privateKitchen.isSelect == true{
                    ids.append(privateKitchen.orderShoppingTrolleyVOList.id)
                }
            }
        }
        
        // ids.map { uLog($0) }
        MerchantInfoProvider.request(.delTrolleyByIdList(_idList: ids), model: XSMerchInfoHandlerModel.self) { returnData in
            
            if returnData?.trueOrFalse ?? 1 == 0 {
                var selectModels = [XSShopCartModelProtocol]()
                self.datas.forEach { model in
                    for (idx,cellModel) in model.cellViewModels.enumerated().reversed() {
                        if cellModel.isSelect == true {
                            selectModels.append(cellModel)
                            model.cellViewModels.remove(at: idx)
                        }
                    }
                }
                self.cartTableView.reloadData()
            }
            
        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }
  
    }
    
    /// 删除商品的操作
    private func deleteShop(idList: [Int],indexPath: IndexPath){
        showAlert(title: "删除商品", message: "确认删除所商品？", alertType: .alert) {
            MerchantInfoProvider.request(.delTrolleyByIdList(_idList: idList), model: XSMerchInfoHandlerModel.self) { returnData in
                
                if returnData?.trueOrFalse ?? 1 == 0 {
                    let sectionModel = self.datas[indexPath.section]
                    self.cartTableView.beginUpdates()
                    
                    sectionModel.cellViewModels.remove(at: indexPath.row)

                    if sectionModel.cellViewModels.count == 1 {
                        self.datas.remove(at: indexPath.section)
                        self.cartTableView.deleteSections([indexPath.section], with: .none)
                    } else {
                        self.cartTableView.deleteRows(at: [indexPath], with: .none)
                    }
                    self.cartTableView.endUpdates()
                    
                }
                
            } errorResult: { errorMsg in
                
            }

        } cancelBlock: {}

    }
    
    func setTopInfoSelect(_ sectionModel: XSShopCartSectionViewModel, isSelect: Bool) {
        for var vm in sectionModel.cellViewModels {
            if vm.style == .shopInfoTop {
                vm.isSelect = isSelect
                break
            }
        }
 
    }
    
    func checkTopInfoisSelect(sectionModel: XSShopCartSectionViewModel) {
        var num = 0
        var selectNum = 0
        var isLoop = false
        /// 找到外卖，团购，私厨在所在的sectionModel中的数量，
        /// 找到外卖，团购，私厨在所在的sectionModel中的选中的数量
        for vm in sectionModel.cellViewModels {
            if vm.style == .delieve || vm.style == .groupBuy || vm.style == .privateKitchen {
                num += 1
                if vm.isSelect {
                    selectNum += 1
                }
                isLoop = true
            }
        }
        /// 如果两个数量是相同,则证明点击了cell，是数量中最后一个cell，则让topInfoCell，按钮选中
        if isLoop && num == selectNum {
           setTopInfoSelect(sectionModel, isSelect: true)
        }
    }
    
    func checkCartOrderBalance(caculate:OrderCarVOList,sectionModel: XSShopCartSectionViewModel) {
        // true:达到起送价格,false:未达到可起送价格，差多少起送
        if !caculate.isReachMinPrice && caculate.diffPrice.doubleValue > 0.0 {// 是否达到起送价格
            let balanceOrder = XSShopCartBalanceOrderModel(caculateMoreAmt: caculate, hasTopRadius: false, hasBottomRadius: false)
            sectionModel.cellViewModels.append(balanceOrder)
            
            checkBalanceOrder = caculate
            self.notPlayOrderView.isHidden = true
            
        } else {
            for (idx,rowModel) in sectionModel.cellViewModels.enumerated().reversed() {
                if rowModel.style == .balanceOrder {
                    sectionModel.cellViewModels.remove(at: idx)
                }
            }
            checkBalanceOrder = nil
            self.checkOrderSuccess = caculate
            self.notPlayOrderView.isHidden = true
        }
    }
    
    func clearAllBottom(sectionModel: XSShopCartSectionViewModel) {
        for (idx,rowModel) in sectionModel.cellViewModels.enumerated().reversed() {
            if rowModel.style == .discountInfo {
                sectionModel.cellViewModels.remove(at: idx)
            }
        }
        for (idx,rowModel) in sectionModel.cellViewModels.enumerated().reversed() {
            if rowModel.style == .balanceOrder {
                sectionModel.cellViewModels.remove(at: idx)
            }
        }
    }
    
    func selectMulit(select isSelect: Bool, sectionModel: XSShopCartSectionViewModel,caculateAmtModel: XSShopCaculateMoreAmtModel? = nil) {
        
        guard let caculate = caculateAmtModel?.orderCarVOList.first! else { return }

        if isSelect {
            /// 底部计算结果
            var hasDiscountInfo = false
            
            for (idx,rowModel) in sectionModel.cellViewModels.enumerated().reversed() {
                if rowModel.style == .discountInfo {
                    let discount = rowModel as! XSShopCartDiscountInfoModel
                    discount.caculateMoreAmt = caculate
                    hasDiscountInfo = true
                }
            }
            
            if !hasDiscountInfo {
                let info = XSShopCartDiscountInfoModel(caculateMoreAmt:caculate ,hasTopRadius: false, hasBottomRadius: true)
                sectionModel.cellViewModels.append(info)
            }

            checkCartOrderBalance(caculate: caculate, sectionModel: sectionModel)


        } else { // 点击取消选中按钮，删除计算结果，
            
            self.notPlayOrderView.isHidden = true
            
            if selectIds.count > 0 { // 已经有了计算信息，则直接更新
                for (idx,rowModel) in sectionModel.cellViewModels.enumerated().reversed() {
                    if rowModel.style == .discountInfo {
                        let discount = rowModel as! XSShopCartDiscountInfoModel
                        discount.caculateMoreAmt = caculate
                    }
                }

                // 再次检查是否满足起送价格
                checkCartOrderBalance(caculate: caculate, sectionModel: sectionModel)

            } else {
                clearAllBottom(sectionModel: sectionModel)
            }
        }
    }
    
    func selectStateForBottomView(_ isSelect: Bool){
        var totalAmt = 0.0
        
        guard let caculateAmtModel = self.caculateAmtModel else {
            carBottomView.caculTotalPriceLabel.text = "¥\(totalAmt)"
            return
            
        }

        for orderCard in caculateAmtModel.orderCarVOList {
            totalAmt += orderCard.payAmt.doubleValue
        }
        
        carBottomView.caculTotalPriceLabel.text = "¥\(totalAmt)"
        carBottomView.configSelectState(select: isSelect, closeAccountSubTitle: "\(caculateAmtModel.orderCarVOList.count)个商家")
        
    }
    
}

// MARK: - XSShopCartDelieveTableViewCellDelegate
extension XSShopCartController: XSShopCartDelieveTableViewCellDelegate {
    func showSelectStandard(_ delieveTableCell: XSShopCartDelieveTableViewCell) {
        if let orderShop = delieveTableCell.delieveModel?.orderShoppingTrolleyVOList {
            
            let goodsId = orderShop.goodsId
            
            MerchantInfoProvider.request(.getGoodsSpecsAttributes(_merchantId: orderShop.merchantId, goodsId: goodsId), model: XSGoodsSpecsAttributesModel.self) { returnData in
                
                if let goodsSpecAttributeModel = returnData {
                    let select = TBSelectStandardPopView()
                    select.configData(goodsSpecAttributeModel: goodsSpecAttributeModel, orderShop: orderShop)
                    select.show()
                }
                
            } errorResult: { errorMsg in
                print(errorMsg)
                XSTipsHUD.showText(errorMsg)
            }
            
        }
    }
    func plusReduceViewZero(viewModel: XSShopCartModelProtocol) {
        let Id = viewModel.Id

        for (sectionIdx, sectionModel) in self.datas.enumerated() {
            if let rowIdx = sectionModel.cellViewModels.firstIndex(where: {$0.Id == Id}) {
                let idxPath = IndexPath(row: rowIdx, section: sectionIdx)
                deleteShop(idList: [Id], indexPath: idxPath)
            }
            
        }
    }

}

// MARK: - UITableViewDataSource && UITableViewDelegate
extension XSShopCartController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = datas[section]
        return sectionModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionModel = datas[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        return rowModel.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = datas[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]

        switch rowModel.style {
        case .shopInfoTop:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSShopCartInfoTopTableViewCell.self)
            let infoTopModel = rowModel as! XSShopCartInfoTopModel
            cell.selectBtn.isSelected = rowModel.isSelect
            cell.infoTopModel = infoTopModel
            // 领劵
            cell.applyTicketBlock = {[weak self] merchantId in
                self?.applyTicket(merchantId: merchantId)
            }
            cell.btnSelectBlock = { [weak self] cell in
                
                guard let self = self else { return }
                
                for var vm in sectionModel.cellViewModels {
                    vm.isSelect = !cell.selectBtn.isSelected
                }
                
                for cellModel in sectionModel.cellViewModels {
                    if cellModel.style == .delieve || cellModel.style == .groupBuy || cellModel.style == .privateKitchen {
                        let selectId = cellModel.Id

                        if rowModel.isSelect {
                            self.selectIds.append(selectId)
                        } else {
                            if self.selectIds.contains(selectId) {
                                self.selectIds.remove(selectId)
                            }
                        }
                        
                    }
                }
                
                let select = rowModel.isSelect
                self.caculateMoreAmt(select: 11) { caculateAmtModel in
                    // 这里多选，要弹出多选折扣
                    self.selectMulit(select: select, sectionModel: sectionModel,caculateAmtModel: caculateAmtModel)
                    self.selectStateForBottomView(self.selectIds.count > 0)
                    self.cartTableView.reloadData()

                }
                
                
                if self.selectIds.count == 0
                {
                    self.selectMulit(select: false, sectionModel: sectionModel)
                    self.clearAllBottom(sectionModel: sectionModel)
                }
                
                self.cartTableView.reloadData()
                /// 多选，底部View更新
                self.selectStateForBottomView(self.selectIds.count > 0)
                
            }
            return cell
        case .groupBuy:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSShopCartGroupBuyTableViewCell.self)
            cell.bindingViewModel(viewModel: rowModel)
            cell.delegate = self
            cell.selectBtnBlock = { [weak self] deliveCell in
                
                guard let vm = deliveCell.viewModel,
                      let self = self else {
                    return
                }
                
                if !vm.isSelect {
                    self.setTopInfoSelect(sectionModel, isSelect: false)
                } else {
                    self.checkTopInfoisSelect(sectionModel: sectionModel)
                }
                
                let selectId = vm.Id
                let isSelect = deliveCell.selectBtn.isSelected
                
                if isSelect {
                    self.selectIds.append(selectId)
                } else {
                    if self.selectIds.contains(selectId) {
                        self.selectIds.remove(selectId)
                    }
                }
                
                self.caculateMoreAmt(select: selectId) { caculateAmtModel in
                    // 这里多选，要弹出多选折扣b
                    self.selectMulit(select: isSelect, sectionModel: sectionModel,caculateAmtModel: caculateAmtModel)
                    self.selectStateForBottomView(self.selectIds.count > 0)
                    self.cartTableView.reloadData()
                }
                
                if self.selectIds.count == 0
                {
                    self.selectMulit(select: false, sectionModel: sectionModel)
                    self.clearAllBottom(sectionModel: sectionModel)
                }
                
                self.cartTableView.reloadData()
                /// 多选，底部View更新
                self.selectStateForBottomView(self.selectIds.count > 0)

            }
            return cell
        case .outbounds:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSShopCartBottomOutBoundsTableViewCell.self)
            let outBounds = rowModel as! XSShopCartOutBoundsModel
            cell.outBounds = outBounds
            return cell
            
        case .balanceOrder:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSShopCartBottomBalanceOrderTableViewCell.self)
            let balanceOrderModel = rowModel as! XSShopCartBalanceOrderModel
            cell.balanceOrderModel = balanceOrderModel
            return cell
        case .privateKitchen:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSShopCartPrivateKitchenTableViewCell.self)
            cell.bindingViewModel(viewModel: rowModel)
            cell.delegate = self

            cell.selectBtnBlock = { [weak self] deliveCell in
                guard let vm = deliveCell.viewModel,
                      let self = self else {
                    return
                }
                
                if !vm.isSelect {
                    self.setTopInfoSelect(sectionModel, isSelect: false)
                } else {
                    self.checkTopInfoisSelect(sectionModel: sectionModel)
                }
                
                let selectId = vm.Id
                let isSelect = deliveCell.selectBtn.isSelected
                
                if isSelect {
                    self.selectIds.append(selectId)
                } else {
                    if self.selectIds.contains(selectId) {
                        self.selectIds.remove(selectId)
                    }
                }
                
                self.caculateMoreAmt(select: selectId) { caculateAmtModel in
                    // 这里多选，要弹出多选折扣
                    self.selectMulit(select: isSelect, sectionModel: sectionModel,caculateAmtModel: caculateAmtModel)
                    self.selectStateForBottomView(self.selectIds.count > 0)
                    self.cartTableView.reloadData()
                }
                
                
                if self.selectIds.count == 0
                {
                    self.selectMulit(select: false, sectionModel: sectionModel)
                    self.clearAllBottom(sectionModel: sectionModel)
                }
                
                self.cartTableView.reloadData()
                /// 多选，底部View更新
                self.selectStateForBottomView(self.selectIds.count > 0)

            }
            return cell
       case .recommand:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSFootMarkTableViewCell.self)
            cell.configShopCartUI()
            return cell
        case .discountInfo:
             let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSShopCartDiscountInfoTableViewCell.self)
            let infoModel = rowModel as! XSShopCartDiscountInfoModel
            cell.infoModel = infoModel
            return cell
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSShopCartDelieveTableViewCell.self)
            cell.bindingViewModel(viewModel: rowModel)
            cell.delegate = self
            cell.selectBtnBlock = { [weak self] deliveCell in
                guard let vm = deliveCell.viewModel,
                      let self = self else {
                    return
                }
                if !vm.isSelect {
                    self.setTopInfoSelect(sectionModel, isSelect: false)
                } else {
                    self.checkTopInfoisSelect(sectionModel: sectionModel)
                }
                
                
                let selectId = vm.Id
                let select = deliveCell.selectBtn.isSelected
                
                if select {
                    self.selectIds.append(selectId)
                } else {
                    if self.selectIds.contains(selectId) {
                        self.selectIds.remove(selectId)
                    }
                }
                
                self.caculateMoreAmt(select: selectId) { caculateAmtModel in
                    // 这里多选，要弹出多选折扣
                    self.selectMulit(select: select, sectionModel: sectionModel,caculateAmtModel: caculateAmtModel)
                    self.selectStateForBottomView(self.selectIds.count > 0)
                    self.cartTableView.reloadData()
                }
                
                
                if self.selectIds.count == 0
                {
                    self.selectMulit(select: false, sectionModel: sectionModel)
                    self.clearAllBottom(sectionModel: sectionModel)
                }
                
                self.selectStateForBottomView(self.selectIds.count > 0)
                self.cartTableView.reloadData()
    
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = datas[section]
        guard let _ = sectionModel.sectionHeaderTitle else {
            return 10
        }
        return 46
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var selectIds = [Int]()
            
            let sectionModel = datas[indexPath.section]
            let rowModel = sectionModel.cellViewModels[indexPath.row]
            switch rowModel.style {
            case .delieve:
               let delieveModel = rowModel as! XSShopCartDelieveModel
                selectIds.append(delieveModel.orderShoppingTrolleyVOList.id)
            case .groupBuy:
               let groupBuyModel = rowModel as! XSShopCartGroupBuyModel
                selectIds.append(groupBuyModel.orderShoppingTrolleyVOList.id)
            case .privateKitchen:
               let privateKitchenModel = rowModel as! XSShopCartPrivateKitchenModel
                selectIds.append(privateKitchenModel.orderShoppingTrolleyVOList.id)
            default: break
            }
            deleteShop(idList: selectIds, indexPath: indexPath)
        }
    }
    
    func selectId(rowModel: XSShopCartModelProtocol) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let sectionModel = datas[indexPath.section]
        let rowModel = sectionModel.cellViewModels[indexPath.row]
        if rowModel.style == .delieve || rowModel.style == .groupBuy || rowModel.style == .privateKitchen {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionModel = datas[section]
        guard let sectionTitle = sectionModel.sectionHeaderTitle else {
            return nil
        }
        
        let header = UIView()
        header.backgroundColor = .clear
        let titleLabel = UILabel()
        titleLabel.text = sectionTitle
        titleLabel.font = MYBlodFont(size: 16)
        titleLabel.textColor = .text
        
        header.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(header).offset(10)
            make.centerY.equalTo(header)
        }
        
        if sectionTitle == "失效宝贝" {
            let arrowBtn = QMUIButton()
            arrowBtn.tag = section
            arrowBtn.imagePosition = QMUIButtonImagePosition.left
            arrowBtn.setTitle("清空失效宝贝", for: UIControl.State.normal)
            arrowBtn.setImage(UIImage(named: "home_search_delete"), for: UIControl.State.normal)
            arrowBtn.setTitleColor(.twoText, for: UIControl.State.normal)
            arrowBtn.titleLabel?.font = MYFont(size: 14)
            arrowBtn.spacingBetweenImageAndTitle = 5
            arrowBtn.addTarget(self, action: #selector(cartClarLoseTimeAction(button:)), for: .touchUpInside)
            header.addSubview(arrowBtn)
            arrowBtn.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: 120, height: 20))
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        }
        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .background
        return iv
    }
    
    
}

