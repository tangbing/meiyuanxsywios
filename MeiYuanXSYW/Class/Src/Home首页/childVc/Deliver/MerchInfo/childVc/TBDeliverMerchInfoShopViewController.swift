//
//  TBDeliverMerchInfoShopViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/8.
//

import UIKit
import GKPageScrollView



class TBDeliverMerchInfoShopModel {
    var title: String = ""
    var isSelect: Bool = false
    var merchInfoShopState: TBDeliverMerchInfoShopState = .normal
    
    init(title: String, isSelect: Bool = false , merchInfoShopState: TBDeliverMerchInfoShopState = .normal) {
        self.title = title
        self.isSelect = isSelect
        self.merchInfoShopState = merchInfoShopState
    }
    
}

protocol TBDeliverMerchInfoShopViewControllerDelegate: NSObjectProtocol {
    func shopTypeDidClick(_ shopViewController: TBDeliverMerchInfoShopViewController)
    
    func rightViewDidClick(_ shopViewController: TBDeliverMerchInfoShopViewController, goodsItemVoModel: GoodsItemVo)
    
    /// 减多规格的商品，弹出提示，然后自动弹出底部商家购物车
    func showShopCart()
}


class TBDeliverMerchInfoShopViewController: TBBasePageScrollViewController {
   
    var shopModels = [TBDelieverMerchInfoShopModel]()
        
    weak var delegate: TBDeliverMerchInfoShopViewControllerDelegate?
    
    var cartGoodsInfoModel: TBMerchInfoCartGoodInfoModel? {
        didSet {
            guard let model = cartGoodsInfoModel else {
                return
            }
            setCartAccountZero(true, cartGoodsInfoModel: model)
        }
    }
    
  
    lazy var leftTableView: TBBaseTableView = {
        let exendTableView = TBBaseTableView(frame: .zero, style: .plain)
        exendTableView.register(cellType: TBMerchInfoLeftTableViewCell.self)
        exendTableView.backgroundColor = .white
        exendTableView.rowHeight = 45
        exendTableView.dataSource = self
        exendTableView.delegate = self
        exendTableView.tableFooterView = UIView()
        return exendTableView
    }()
    
    lazy var rightTableView: TBBaseTableView = {
        let exendTableView = TBBaseTableView(frame: .zero, style: .plain)
        exendTableView.register(cellType: TBMerchInfoRightTableViewCell.self)
        exendTableView.backgroundColor = .white
        exendTableView.rowHeight = 95
        exendTableView.dataSource = self
        exendTableView.delegate = self
        exendTableView.tableFooterView = UIView()
        return exendTableView
    }()
    
    lazy var msgView: TBBottomMsgView = {
        return TBBottomMsgView(msgText: "msg:本店打烊了，今日预约明日07:00后配送")
    }()
    
    override func initSubviews() {
        super.initSubviews()
        
        
        self.view.addSubview(leftTableView)
        leftTableView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(FMScreenScaleFrom(80))
            make.bottom.equalToSuperview().offset(0)
        }
        
        self.view.addSubview(rightTableView)
        rightTableView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(leftTableView.snp_right).offset(0)
            //make.bottom.equalTo(bottomCartView.snp_top).offset(0)
        }
        
        leftTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .none)

    }
    
    private func setupMsgView(){
        self.view.addSubview(msgView)
        msgView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(46)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(shopCartPopViewReduceClick(notice:)), name: NSNotification.Name.XSCartMerchInfoPopCellReduceBtnClickNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(shopCartPopViewPlusClick(notice:)), name: NSNotification.Name.XSCartMerchInfoPopCellplusBtnClickNotification, object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    func setupData() {
        super.initData()
        MerchantInfoProvider.request(.getGoodsInfo(merchantId), model: [TBDelieverMerchInfoShopModel].self) { [weak self] returnData in
        
            if let dataModel = returnData {
                self?.shopModels.removeAll()
                
                self?.shopModels = dataModel
                self?.getDefaultCartOrderInfo()
            }
           
            
        } errorResult: { errorMsg in
            print(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

    }
    
    func getDefaultCartOrderInfo() {
        MerchantInfoProvider.request(.getOrderMerchantInCarVO(merchantId), model: TBMerchInfoCartGoodInfoModel.self) { [weak self] returnData in
            if let cartGoodsInfoModel = returnData {
                self?.setCartAccountZero(false, cartGoodsInfoModel: cartGoodsInfoModel)
            }

        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

    }
    
    func setCartAccountZero(_ zero: Bool, cartGoodsInfoModel: TBMerchInfoCartGoodInfoModel ) {
        cartGoodsInfoModel.orderShoppingTrolleyVOList?.forEach({ orderShoppingTrolleyVOList in
            
            self.shopModels.forEach { goodItem in
                goodItem.goodsItemVos.forEach { goodsInfoModel in
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
            }
            
        })
        self.leftTableView.reloadData()
        self.rightTableView.reloadData()
        
    }
    
    
   override func setContentInset(bottomInset: CGFloat){
        self.leftTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0)
        self.rightTableView.contentInset = self.leftTableView.contentInset
    }
    
    override func listScrollView() -> UIScrollView {
         //uLog(NSStringFromClass(self.classForCoder) + " listScrollView")
         return self.rightTableView
     }
    
    func changeMerchState(){
        shopModels.forEach { shopModel in
            shopModel.goodsItemVos.forEach { item in
                item.merchInfoShopState = .pauseBusiness
            }
        }
        rightTableView.reloadData()
    }
    
    func getCartOrderInfo() {
        MerchantInfoProvider.request(.getOrderMerchantInCarVO(merchantId), model: TBMerchInfoCartGoodInfoModel.self) { returnData in
            //uLog(returnData)
            if let cartGoodsInfoModel = returnData {
                NotificationCenter.default.post(name: NSNotification.Name.XSJoinGoodsInCartNotification, object: self, userInfo: ["cartGoodsInfo" : cartGoodsInfoModel])
                
                // 获取加到购物车的数据，是不是同一个商品相同规格
                //DispatchQueue.main.async {
                    self.setGoodsInfoMoreSpec(cartGoodsInfoModel)
                //}
               
            }

        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

    }
    
    func setGoodsInfoMoreSpec(_ cartGoodsInfoModel: TBMerchInfoCartGoodInfoModel) {
        cartGoodsInfoModel.orderCarGoodsAccountVOList?.forEach{ [weak self] accountMoel in
            guard let self = self else { return }
            
            self.shopModels.forEach { goodItem in
                goodItem.goodsItemVos.forEach { goodsInfoModel in
                    if goodsInfoModel.goodsId == accountMoel.goodsId {
                        goodsInfoModel.moreSpec = accountMoel.moreSpec
                        
                    }
                }
            }
        }
        self.rightTableView.reloadData()
    }
    
}


extension TBDeliverMerchInfoShopViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == leftTableView {
            return 1
        }
        return shopModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return shopModels.count
        }
        
        let goordItems = shopModels[section].goodsItemVos
        return goordItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTableView {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoLeftTableViewCell.self)
            let model = shopModels[indexPath.row]
            cell.titlabel.text = model.groupName
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchInfoRightTableViewCell.self)
            cell.delegate = self
            let goordItems = shopModels[indexPath.section].goodsItemVos
            let goodsItemVoModel = goordItems[indexPath.row]
            cell.rightInfoModel = goodsItemVoModel
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == leftTableView {
            return 0.1
        }
        
        return 33
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == leftTableView {
            return nil
        }
        let header = UIView()
        header.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.hex(hexString: "#737373")
        titleLabel.font = MYFont(size: 13)
        header.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(header).offset(4)
            make.centerY.equalTo(header)
        }
        let model = shopModels[section]
        titleLabel.text = model.groupName
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 右侧tableView滚动时, 左侧tableView滚动到相应 Row
        if scrollView == rightTableView {
            // 只有用户拖拽才触发, 点击左侧不触发
            if scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating {
                if let topIndexPath = self.rightTableView.indexPathsForVisibleRows?.first {
                    let moveToIndexPath = IndexPath(row: topIndexPath.section, section: 0)
                    // selectRow不会调用didSelectRowAt方法，会调用cell的setSelected方法
                    self.leftTableView.selectRow(at: moveToIndexPath, animated: true, scrollPosition: .top)
                }
            }
        }
        scrollCallBack!(scrollView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == leftTableView {
                        
            self.leftTableView.selectRow(at: IndexPath(row: indexPath.row , section: 0) , animated: true, scrollPosition: .top)
            // 协议回掉主页面吸顶
            self.delegate?.shopTypeDidClick(self)
            // 右边tableview滚动到点击所在组区域
            self.rightTableView.scrollToRow(at: IndexPath(row: 0 , section: indexPath.row), at: .top, animated: true)

        } else {
            let goordItems = shopModels[indexPath.section].goodsItemVos
            let goodsItemVoModel = goordItems[indexPath.row]
            self.delegate?.rightViewDidClick(self, goodsItemVoModel: goodsItemVoModel)

            
            let delieveGoodsInfoVc =  TBDelievePrivateKitGoodsInfoVc(style: self.showHomeStyle, merchantId: goodsItemVoModel.merchantId, goodsId: goodsItemVoModel.goodsId)
            self.navigationController?.pushViewController(delieveGoodsInfoVc, animated: true)
            
        }
        
    }
}

// MARK: - notic
extension TBDeliverMerchInfoShopViewController {
    
    @objc func shopCartPopViewPlusClick(notice: NSNotification) {
        
        guard let model = notice.userInfo?["OrderShoppingTrolleyVOList"] as? OrderShoppingTrolleyVOList
              else { return }
        
        self.getCartOrderInfo()
        
        self.shopModels.forEach { shopModel in
            shopModel.goodsItemVos.forEach { goodItemVo in
                if goodItemVo.goodsId == model.goodsId {
                    goodItemVo.buyOfNum += 1
                }
            }
        }
        self.rightTableView.reloadData()
    }
    
    @objc func shopCartPopViewReduceClick(notice: NSNotification) {
        
        guard let model = notice.userInfo?["OrderShoppingTrolleyVOList"] as? OrderShoppingTrolleyVOList
              else { return }
        
        self.getCartOrderInfo()
        
        
        self.shopModels.forEach { shopModel in
            shopModel.goodsItemVos.forEach { goodItemVo in
                if goodItemVo.goodsId == model.goodsId {
                    if goodItemVo.buyOfNum == 0{
                        return
                    }
                    goodItemVo.buyOfNum -= 1
                    uLog("goodItemVo.buyOfNum: \(goodItemVo.buyOfNum)")
                    
                    if goodItemVo.buyOfNum == 0 {
                        goodItemVo.merchInfoShopState = .normal
                    }
                }
            }
        }
        
        self.rightTableView.reloadData()
    }
    
}

extension TBDeliverMerchInfoShopViewController: TBMerchInfoRightTableViewCellDelegate {
    
    func rightTableViewCell(_ tableViewCell: TBMerchInfoRightTableViewCell, buyNumZero rightInfoModel: GoodsItemVo) {

        if rightInfoModel.isChoose == .isChoose {
            rightInfoModel.merchInfoShopState = .selectStandard
        } else {
            rightInfoModel.merchInfoShopState = .normal
        }
        
        rightInfoModel.buyOfNum = 0
        
        self.rightTableView.reloadData()

    }
    

    /// 点击plusReduce了+号按钮
    func rightPlusBtnClick(_ tableViewCell: TBMerchInfoRightTableViewCell) {
        rightBuyButtonClickHandler(tableViewCell: tableViewCell)
    }
    
    /// 点击plusReduce了-号按钮
    func rightReduceBtnClick(_ tableViewCell: TBMerchInfoRightTableViewCell){
        
        let model = tableViewCell.rightInfoModel!
        
        if model.moreSpec == 0 {
            XSTipsHUD.showText("不同规格的商品需在购物车减购", inView: self.view, hideAfterDelay: 0.25)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.delegate?.showShopCart()
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
                    
                    self?.rightTableView.reloadData()
                    self?.leftTableView.reloadData()
                    
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
                
                self?.rightTableView.reloadData()
                self?.leftTableView.reloadData()
                
            }
            popView.show()
        }
    }
}


