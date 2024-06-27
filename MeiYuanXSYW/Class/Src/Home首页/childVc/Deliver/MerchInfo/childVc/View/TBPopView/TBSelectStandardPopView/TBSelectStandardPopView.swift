//
//  TBSelectStandardPopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/11.
//

import UIKit
import QMUIKit
import CloudKit

var shopCartDefaultSelectSpecId: String = ""


class TBCartSelectBottomView : UIView {
    
    var titleText: String!
    
    init(titleText: String) {
        self.titleText = titleText
        super.init(frame: .zero)
        setupUI()
    }
    
    lazy var merchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "【康美甄】营养餐"
        label.textColor = .text
        label.font = MYBlodFont(size: 13)
        return label
    }()
    

    lazy var plusReduceView: TBCartPlusReduceButtonView = {
        let plusReduce = TBCartPlusReduceButtonView()
        return plusReduce
    }()
  
    
    lazy var discountLabel: UILabel = {
        let discount = UILabel()
        discount.textColor = .twoText
        discount.textAlignment = .right
        discount.font = MYFont(size: 13)
        discount.text = "2件9折，3件8.5折"
        return discount
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        self.addSubview(merchNameLabel)
        merchNameLabel.text = titleText
        merchNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }

        self.addSubview(plusReduceView)
        plusReduceView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        
        self.addSubview(discountLabel)
        discountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
        }
        
        
        
    }
    
    func setBuyNumData(){
        discountLabel.isHidden = true
    }
    
    func setMuitDiscountData(){
        plusReduceView.isHidden = true
    }
    
  
    
}


class TBSelectStandardPopView: UIView {
    var joinCartSuccesHandler:((_ selectNum: UInt) -> Void)?
    
    var items = [AttributesItem]()
    var selectSpecItem: SpecItem!
    var selectAttributesIdList: [String] = [String]()
    

    var goodsId: String = ""
    var ID: Int = 0
    
    var goodsModel: GoodsItemVo? {
        didSet {
            guard let model = goodsModel else { return }
            
            merchIcon.xs_setImage(urlString: model.picAddress, placeholder: UIImage.placeholder)
            merchNameLabel.text = model.goodsName
            
            setSelectPrice(priviousIsHidden: model.finalPrice == model.originalPrice, finalprice: model.finalPrice, originalPrice: model.originalPrice)

            priveView.reduceDownPriceLabel.isHidden = true
            
            
            // 规格
            if let specItem = model.specItem {
                ruleView.configDataModel((sectionTitle : "规格", item: specItem))
            }
            // 属性
            if let attributes = model.attributesItem {
                items = attributes
                
                items.forEach { item in
                    selectAttributesIdList.appends(item.selectAttrId)
                }

                attributeItemCollection.reloadData()
            }
            
            multDiscountView.discountLabel.text = model.discountStr
            

        }
    }
    
    func configData(goodsSpecAttributeModel: XSGoodsSpecsAttributesModel,orderShop: XSShopCartTrolleyVOList) {
        
        merchIcon.xs_setImage(urlString: orderShop.topPic, placeholder: UIImage.placeholder)
        merchNameLabel.text = orderShop.goodsName
        
        setSelectPrice(priviousIsHidden: orderShop.finalPrice == orderShop.originPrice, finalprice: orderShop.finalPrice, originalPrice: orderShop.originPrice)

        priveView.reduceDownPriceLabel.isHidden = true
        
        inputButton.setTitle("确定", for: .normal)
        self.goodsId = goodsSpecAttributeModel.goodsId
        self.ID = orderShop.id
        // 规格
        shopCartDefaultSelectSpecId = orderShop.specId
        
        let spec = goodsSpecAttributeModel.specDetails
        let item = spec.map { specModel -> SpecItem in
            SpecItem(specId: specModel.specId, specName: specModel.specName, finalPrice: specModel.price)
        }
        ruleView.configDataModel((sectionTitle : "规格", item: item))
        
        // 属性
        selectAttributesIdList = orderShop.attributesIdDetails.components(separatedBy: ",")
        let details = goodsSpecAttributeModel.attributesDetails.map { detail -> AttributesItem in
            
            let valueItems = detail.attributesValues.map { attributeValue -> AttributesValueItem in
                AttributesValueItem(attributesId: attributeValue.attributesId, attributesValue: attributeValue.attributesValue, isSelect: false)
            }
            
            return AttributesItem(attributesName: detail.attributesName, selectAttrId: selectAttributesIdList, attributesValueItems: valueItems, attributesRule: 0)
        }
        
        items = details
        attributeItemCollection.reloadData()
        multDiscountView.discountLabel.text = goodsSpecAttributeModel.moreDiscount
        
    }
    
    lazy var containView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        return iv
    }()
    
    lazy var overlayView: UIControl = {
        let control = UIControl(frame: UIScreen.main.bounds)
        control.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.6)
        control.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        control.isHidden = true
        return control
    }()

    lazy var merchIcon: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.hg_setAllCornerWithCornerRadius(radius: 5)
        iv.image = #imageLiteral(resourceName: "login_LOGO")
        return iv
    }()
    
    lazy var merchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "【康美甄】营养餐"
        label.textColor = .text
        label.font = MYBlodFont(size: 16)
        return label
    }()
    
    lazy var priveView: XSCollectPriceView = {
        let priveView = XSCollectPriceView()
        return priveView
    }()
    
    lazy var selectMsgLabel: UILabel = {
        let label = UILabel()
        label.text = "请选择：规格，件数"
        label.textColor = .twoText
        label.font = MYBlodFont(size: 13)
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "merchinfo_ticket_closure"), for: .normal)
        backButton.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        return backButton
    }()
    
    
    lazy var ruleView: TBSelectRuleView = {
        let rule = TBSelectRuleView()
        rule.tagBtnClickedHandler = { [weak self] item in
            self?.selectSpecItem = item
            
            self?.setSelectPrice(priviousIsHidden: item.finalPrice == item.originalPrice, finalprice: item.finalPrice, originalPrice: item.originalPrice)
        }
        return rule
    }()
    
    lazy var attributeItemCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(cellType: XSSelectStandardItemCollectionViewCell.self)
        collectionView.register(supplementaryViewType: XSSelectStandardItemHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)

        return collectionView
    }()
    
    lazy var inputButton: UIButton = {
        let input = UIButton(type: .custom)
        input.setTitle("加入购物车", for: .normal)
        input.setTitleColor(.white, for: .normal)
        input.setBackgroundImage(UIColor.king.image(), for: .normal)
        input.hg_setAllCornerWithCornerRadius(radius: 22)
        input.addTarget(self, action: #selector(joinCartBtnClick), for: .touchUpInside)
        return input
    }()
    
    lazy var buyNumView: TBCartSelectBottomView = {
        let bottom = TBCartSelectBottomView(titleText: "购买数量")
        bottom.setBuyNumData()
        bottom.plusReduceView.plusBtnClickHandler = { [weak self] bottomView in
            bottomView.buyNum += 1
            
            bottom.plusReduceView.buyNum = bottomView.buyNum
            
        }
        bottom.plusReduceView.reduceBtnClickHandler = { [weak self] bottomView in
            bottomView.buyNum -= 1
            if bottomView.buyNum == 0 {
                self?.goodsModel?.buyOfNum = 1
            }
            
            bottom.plusReduceView.buyNum = bottomView.buyNum
        }
        return bottom
    }()
    
    lazy var multDiscountView: TBCartSelectBottomView = {
        let bottom = TBCartSelectBottomView(titleText: "多件折扣")
        bottom.setMuitDiscountData()
        return bottom
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.bounces = false
        return scroll
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCustomView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupCustomView() {
        
        self.backgroundColor = .white
        
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        }
        
        scrollView.addSubview(containView)
        containView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(screenWidth - 20)

        }
        
        containView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        containView.addSubview(inputButton)
        inputButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(44)
        }
        
        containView.addSubview(merchIcon)
        merchIcon.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.width.equalTo(120)
            /// multipliedBy, 120 * 0.75 , dividedBy , 直接除以一个数值
            make.height.equalTo(merchIcon.snp_width).multipliedBy(0.75)
        }
        
        containView.addSubview(merchNameLabel)
        merchNameLabel.snp.makeConstraints { make in
            make.left.equalTo(merchIcon.snp_right).offset(10)
            make.top.equalTo(merchIcon)
        }
        
        containView.addSubview(priveView)
        priveView.snp.makeConstraints { make in
            make.left.equalTo(merchNameLabel)
            make.right.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(merchNameLabel.snp_bottom).offset(4)
        }
        
        containView.addSubview(selectMsgLabel)
        selectMsgLabel.snp.makeConstraints { make in
            make.top.equalTo(priveView.snp_bottom).offset(4)
            make.left.equalTo(priveView)
        }
        
        containView.addSubview(ruleView)
        ruleView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(merchIcon.snp_bottom).offset(15)
        }
        
        containView.addSubview(attributeItemCollection)
        attributeItemCollection.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(155)
            make.top.equalTo(ruleView.snp_bottom).offset(15)
        }
        
        containView.addSubview(buyNumView)
        buyNumView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(attributeItemCollection.snp_bottom).offset(14)
            make.height.equalTo(22)
        }
        
        containView.addSubview(multDiscountView)
        multDiscountView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(buyNumView.snp_bottom).offset(15)
            make.height.equalTo(22)
            make.bottom.equalTo(inputButton.snp_top).offset(-27)
        }
        
    }
    
    func setSelectPrice(priviousIsHidden: Bool, finalprice: NSNumber, originalPrice: NSNumber) {
        priveView.previousPriceLabel.isHidden = priviousIsHidden
        priveView.finalPriceLabel.text = "￥\(finalprice)"
        priveView.previousPriceLabel.text = "￥\(originalPrice)"
    }
    
    func getPopViewHeight() -> CGFloat {
        return 522
    }
    
    // MARK: - public event
    func show(){
       
        let window = UIApplication.shared.keyWindow
        window?.addSubview(overlayView)
        window?.addSubview(self)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: getPopViewHeight())
        fadeIn()
    }
    
    func fadeIn() {
     
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = false
            self.frame = CGRect(x: 0, y: screenHeight - self.getPopViewHeight(), width: screenWidth, height: self.getPopViewHeight())
        }
    }
    
    @objc func fadeOut() {
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = true
            self.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: self.getPopViewHeight())
        } completion: { (finish) in
            self.overlayView.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
    
    func updateCartSpecAndAttribute() {
        
        let updatedSpecId = selectSpecItem.specId
        let updatedAttributesId = selectAttributesIdList.joined(separator: ",")

        
        MerchantInfoProvider.request(.updateShoppingTrolleySpecAttributesId(_ID:self.ID, goodsId: self.goodsId, attributesIdList: updatedAttributesId, specId: updatedSpecId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
            if (returnData?.trueOrFalse ?? 0) == 0 {
                self?.fadeOut()
                NotificationCenter.default.post(name: NSNotification.Name.XSCartUpdateSpecAttributeNotification, object: self, userInfo:nil)
                
                
                //self?.joinCartSuccesHandler?(count)
            }
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }
    }
    
    // MARK: - 加入购物车网络请求
    @objc func joinCartBtnClick(button: UIButton) {
        
        if button.currentTitle == "确定" {
            updateCartSpecAndAttribute()
            return
        }

        let count = buyNumView.plusReduceView.buyNum
        let goodsId = goodsModel?.goodsId ?? ""
        let merchantId = goodsModel?.merchantId ?? ""
        let selectSpecId = selectSpecItem.specId
        let selectAttributesIdStr = selectAttributesIdList.joined(separator: ",")
        
        MerchantInfoProvider.request(.updateShoppingTrolleyCount(Int(count), attributesIdList: selectAttributesIdStr, goodsId: goodsId, merchantId: merchantId, specId: selectSpecId), model: XSMerchInfoHandlerModel.self) {  [weak self] returnData in
            if (returnData?.trueOrFalse ?? 0) == 0 {
                self?.fadeOut()
                self?.joinCartSuccesHandler?(count)
            }
        } errorResult: { errorMsg in
            uLog(errorMsg)
            XSTipsHUD.showText(errorMsg)
        }

    }

}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension TBSelectStandardPopView: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let item = items[section]
        return item.attributesValueItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: XSSelectStandardItemCollectionViewCell.self)
        let item = items[indexPath.section]
        let value = item.attributesValueItems![indexPath.row]
        
        cell.titleLabel.text = value.attributesValue

        if item.attributesRule == 0 { // 单选
            if item.selectAttrId.first == value.attributesId {
                value.isSelect = true
            } else {
                value.isSelect = false
            }
        } else {
            item.selectAttrId.forEach { ID in
                if ID == value.attributesId {
                    value.isSelect = true
                } else {
                    value.isSelect = false
                }
            }
        }

        if value.isSelect {
            cell.backgroundColor(UIColor(r: 252, g: 242, b: 230, a: 1.0))
            cell.titleLabel.textColor = .king
        } else {
            cell.backgroundColor(UIColor.white)
            cell.titleLabel.textColor = .text
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = items[indexPath.section]
        let value = item.attributesValueItems![indexPath.row]
        
        let attribute = value.attributesValue
        let w = attribute.jk.singleLineWidth(font: MYFont(size: 14)) + 25
        return CGSize(width:w , height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.section]
        let attributeItems = item.attributesValueItems!
     
        // 选中的id赋值给selectAttrId
        let value = attributeItems[indexPath.row]
        
        if item.attributesRule == 0 { // 单选，直接数组赋值
            if item.selectAttrId.contains(value.attributesId) {
                // 默认一个选中
            } else {
                item.selectAttrId = [value.attributesId]
            }
           
        } else {// 多选，直接append多个选中的ID
            if item.selectAttrId.contains(value.attributesId) {
                //item.selectAttrId.remove(value.attributesId)
            } else {
                item.selectAttrId.append(value.attributesId)
            }
        }
        selectAttributesIdList.removeAll()
        items.forEach { item in
            selectAttributesIdList.appends(item.selectAttrId)
        }
     
        
      attributeItemCollection.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: XSSelectStandardItemHeaderView.self)
        let item = items[indexPath.section]
        head.titleLab.text = item.attributesName
        return head
    }
    
}

class TBSelectRuleView: UIView {
    var tagBtnClickedHandler:((_ specItem: SpecItem) -> Void)?
    var sectionTitle: String!
    var tags: [SpecItem]!
    var selectTagButton: TBStandardButton?
    
    
    init(sectionTitle: String, tags: [SpecItem]) {
        self.sectionTitle = sectionTitle
        self.tags = tags
        super.init(frame: .zero)
        setupUI()
    }
    
    lazy var merchNameLabel: UILabel = {
        let label = UILabel()
        label.text = "【康美甄】营养餐"
        label.textColor = .text
        label.font = MYBlodFont(size: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configDataModel(_ dataModel : (sectionTitle : String, item: [SpecItem])) {
        self.sectionTitle = dataModel.sectionTitle
        self.tags = dataModel.item
        setupUI()
    }
    
    func setupSpecTag() {
        tagLayout(tags, topConstrainView: merchNameLabel,isStandardStyle: true)
    }
    
    private func setupUI(){
        
        self.addSubview(merchNameLabel)
        merchNameLabel.text = sectionTitle
        merchNameLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
        }
       
        setupSpecTag()
    }
    
    @objc func tagButtonClick(_ sender: TBStandardButton) {
        selectTagButton?.isSelected = false
        
        sender.isSelected = true
        
        selectTagButton = sender
        
        let idx = sender.tag
        tagBtnClickedHandler?(tags[idx])
        

    }
    
    private func tagLayout(_ tags: [SpecItem],topConstrainView: UIView, isStandardStyle: Bool = false) {
        let textPadding: CGFloat = 10.0
        var width: CGFloat = 0.0
        let tuples = tags.enumerated().map { (index, item) -> (TBStandardButton, CGFloat) in
            let tagButton = TBStandardButton()
            
            if isStandardStyle {
                tagButton.setup(isStandardStyle)
                tagButton.leftLabel.text = item.specName
                tagButton.rightLabel.text = "￥\(item.finalPrice)"
                let leftWidth = item.specName.size(withFont: tagButton.leftLabel.font).width + 2 * 17
                //let rightWidth = "￥\(item.finalPrice)".size(withFont: tagButton.rightLabel.font).width + 2 * 6
                width = leftWidth + leftWidth + 10
                

            } else {
                
                let butonTitle = item.specName
                tagButton.titleLabel?.font = MYFont(size: 14)
                tagButton.setTitleColor(.text, for: .normal)
                tagButton.setTitleColor(.king, for: .selected)
                tagButton.setTitle(butonTitle, for: .normal)
                tagButton.setBackgroundImage(UIColor.white.image(), for: .normal)
                tagButton.setBackgroundImage( UIColor(r: 252, g: 242, b: 230, a: 1.0).image(), for: .selected)
                tagButton.jk.addBorder(borderWidth: 1.0, borderColor: UIColor.hex(hexString: "#979797"))
                width = butonTitle.size(withFont: (tagButton.titleLabel?.font)!).width + textPadding * 2
                
            }
            if (shopCartDefaultSelectSpecId == item.specId) {
                tagButtonClick(tagButton)
            } else if(index == 0) {// 默认选中第一个
                tagButtonClick(tagButton)
            }
            tagButton.tag = index
            tagButton.hg_setAllCornerWithCornerRadius(radius: 16)
            tagButton.addTarget(self, action: #selector(tagButtonClick(_:)), for: .touchUpInside)
            return (tagButton, width)
        }
       
        let labs = tuples.map { $0.0 }
        let textWidths = tuples.map { $0.1 }
        let _ = tuples.map {
            self.addSubview($0.0)
        }
        
        // verticalSpacing   每个view之间的垂直距离
        // horizontalSpacing 每个view之间的水平距离
        // maxWidth 是整个布局的最大宽度，需要事前传入，比如 self.view.bounds.size.width - 40
        // textWidth 是每个view的宽度，也需事前计算好
        // itemHeight 每个view的高度
        // edgeInset 整个布局的 上下左右边距，默认为 .zero
        // topConstrainView 整个布局之上的view, 从topConstrainView.snp.bottom开始计算，
        // 比如,传入上面的label,则从 label.snp.bottom + edgeInset.top 开始排列， 默认为nil, 此时布局从 superview.snp.top + edgeInset.top 开始计算
        labs.snp.distributeDetermineWidthViews(verticalSpacing: textPadding,
                                               horizontalSpacing: textPadding,
                                               maxWidth: screenWidth - 10 - 10,
                                               determineWidths: textWidths,
                                               itemHeight: 32,
                                               edgeInset: UIEdgeInsets(top: 15 + 0,
                                                                       left: 0,
                                                                       bottom: 0,
                                                                       right: 0),
                                               topConstrainView:merchNameLabel
        )
   
        
    }
    
    
    
}
