//
//  XSHomeSelectFilterViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/11.
//

import UIKit

class XSFilterView: UIView {
    let titleLabel: UILabel = {
        let iv = UILabel(frame: CGRect(x: 0, y: 10, width: 200, height: 15))
        iv.textColor = .text
        iv.font = MYFont(size: 14)
        return iv
    }()
    
    let margain:CGFloat = 10
    var title: String = ""
    var buttonTitles = [String]()
    var topContainerView: UIView?
    var colNum: Int = 0
    
    init(title: String,  buttonTitles: [String], colNum:Int = 3, containerView: UIView?) {
        self.title = title
        self.colNum = colNum
        self.buttonTitles = buttonTitles
        self.topContainerView = containerView
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    func setup(){
        titleLabel.text = self.title
        self.addSubview(titleLabel)
        
        if topContainerView != nil {
            self.addSubview(topContainerView!)
            topContainerView?.frame = CGRect(x: 0, y: titleLabel.tb_maxY + margain, width: screenWidth - 30, height: 32)
        }

        let colCount:Int = colNum
        let buttonW:CGFloat = colNum == 4 ? 70 : 90
        let buttonH:CGFloat = 32
        var buttonX:CGFloat = 0
        let buttonTop:CGFloat = topContainerView != nil ?  topContainerView!.tb_maxY + margain : titleLabel.tb_maxY + margain
        var buttonY:CGFloat = 0

        let spacingX:CGFloat = (screenWidth - 30 - buttonW * CGFloat(colCount)) / CGFloat((colCount - 1))
       
        
        for idx in 0..<buttonTitles.count {
            
            let row = idx / colCount
            let col = idx % colCount
            
            buttonX = (buttonW + spacingX) * CGFloat(col)
            buttonY = (buttonH + margain) * CGFloat(row)
            print("idx: \(idx),row: \(row),buttonX:\(buttonX),buttonY:\(buttonY)")
            
            let button = UIButton(type: .custom)
            button.setTitle(buttonTitles[idx], for: .normal)
            button.titleLabel?.font = MYFont(size: 14)
            button.hg_setAllCornerWithCornerRadius(radius: 16)
            button.setTitleColor(.white, for: .selected)
            button.setTitleColor(UIColor.hex(hexString: "#B3B3B3"), for: .normal)
            button.setBackgroundImage(UIColor.hex(hexString: "#F8F8F8").image(), for: .normal)
            button.setBackgroundImage(UIColor.tag.image(), for: .selected)
            self.addSubview(button)
            button.frame = CGRect(x: buttonX, y: buttonTop + buttonY, width: buttonW, height: buttonH)
            button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonClick(button: UIButton){
        button.isSelected = !button.isSelected
    }
}

class XSBottomSureView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var clear: UIButton = {
        let clear = UIButton(type: .custom)
        clear.setTitle("清空", for: .normal)
        clear.setTitleColor(UIColor.hex(hexString: "#B3B3B3"), for: .normal)
        clear.addTarget(self, action: #selector(clearButtonClick(button:)), for: .touchUpInside)
        return clear
    }()
    
    lazy var filter: UIButton = {
        let filter = UIButton(type: .custom)
        filter.setTitle("查找", for: .normal)
        filter.backgroundColor = .tag
        filter.setTitleColor(.white, for: .normal)
        filter.addTarget(self, action: #selector(filterButtonClick(button:)), for: .touchUpInside)
        return filter
    }()
    
    func setup() {
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 1))
        topLine.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.addSubview(topLine)
        
        let centerLine = UIView(frame: CGRect(x: screenWidth * 0.5, y: 1, width: 1, height: 43))
        centerLine.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        self.addSubview(centerLine)
        
        self.addSubview(clear)
        clear.frame = CGRect(x: 0, y: 0, width: screenWidth * 0.5, height: 43)
        
        self.addSubview(filter)
        filter.frame = CGRect(x: centerLine.tb_maxX, y: 0, width: screenWidth * 0.5, height: 44)
       
    }
    
    @objc func clearButtonClick(button: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name.XSUpdateMenuTitleNotification, object: nil)

    }
    @objc func filterButtonClick(button: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name.XSUpdateMenuTitleNotification, object: nil)

    }
    
    
    
}

class XSHomeSelectFilterViewController: XSBaseViewController {


    init(selectFilterStyle: TBHomeStyle) {
        self.selectFilterStyle = selectFilterStyle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selectFilterStyle: TBHomeStyle = .homeDefault
    
    
    var merchServiceTitle: (title: String, buttonTitles: [String]) {
        if selectFilterStyle == .homeDefault {
            return ("商家服务", ["新开好店","新品推荐","自营商家","配送","到店自取","支持预定"])
        } else if(selectFilterStyle == .delivery) {
            return ("商家服务", ["新开好店","新品推荐","自营商家","配送","到店自取","支持预定"])
        } else {
            return ("商家服务", ["自营商家", "新开好店","新品推荐"])
        }
    }
    
   
    lazy var typeView: XSFilterView = {
        let filterView = XSFilterView(title: "业务类型", buttonTitles: ["外卖","团购","私厨"], containerView: nil)
        filterView.frame = CGRect(x: 15, y: 0, width: screenWidth - 30, height: 72)
        return filterView
    }()
    
    lazy var textFieldView: UIView = {
        let iv = UIView()
        
        let lowPriceTF = UITextField(frame: CGRect(x: 0, y: 0, width: 140, height: 32))
        lowPriceTF.placeholder("自定义最低价")
        lowPriceTF.textAlignment = .center
        lowPriceTF.jk.setPlaceholderAttribute(font: MYFont(size: 14), color: UIColor.hex(hexString: "#B3B3B3"))
        lowPriceTF.hg_setAllCornerWithCornerRadius(radius: 16)
        lowPriceTF.backgroundColor = UIColor.hex(hexString: "#F8F8F8")
        iv.addSubview(lowPriceTF)
        
        let hightPriceTF = UITextField(frame: CGRect(x: screenWidth - 30 - 140, y: 0, width: 140, height: 32))
        hightPriceTF.placeholder("自定义最高价")
        hightPriceTF.textAlignment = .center
        hightPriceTF.jk.setPlaceholderAttribute(font: MYFont(size: 14), color: UIColor.hex(hexString: "#B3B3B3"))
        hightPriceTF.hg_setAllCornerWithCornerRadius(radius: 16)
        hightPriceTF.backgroundColor = UIColor.hex(hexString: "#F8F8F8")
        iv.addSubview(hightPriceTF)
        
        let line = UIView()
        line.tb_height = 1
        line.tb_centerY = 35 * 0.5
        line.tb_x = lowPriceTF.tb_right + 8
        line.tb_width = screenWidth - 30 - 280 - 16
        line.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        iv.addSubview(line)
        
        return iv
    }()
    
    lazy var priceStepView: XSFilterView = {
        let filterView = XSFilterView(title: "价格区间", buttonTitles: ["0-50","50-150","50-300","300+"],colNum: 4 ,containerView: textFieldView)
        filterView.frame = CGRect(x: 15, y: 0, width: screenWidth - 30, height: 114)
        return filterView
    }()
    
    /// 配送费
    lazy var distributView: XSFilterView = {
        let filterView = XSFilterView(title: "配送费（外卖商家）", buttonTitles: ["免配送费","0-5","5+"], containerView: nil)
        filterView.frame = CGRect(x: 15, y: 0, width: screenWidth - 30, height: 72)
        return filterView
    }()
    
    /// 用餐人数（团购商家）
    lazy var eatUserNumView: XSFilterView = {
        let filterView = XSFilterView(title: "用餐人数（团购商家）", buttonTitles:["单人餐","双人餐","3-4人餐","5-6人餐","7-10人餐","10人以上"] , containerView: nil)
        filterView.frame = CGRect(x: 15, y: 0, width: screenWidth - 30, height: 114)
        return filterView
    }()
    
    /// 优惠活动
    lazy var activityView: XSFilterView = {
        let filterView = XSFilterView(title: "优惠活动", buttonTitles:["商家优惠","会员商家","活动优惠","首单立减","满减优惠"] , containerView: nil)
        filterView.frame = CGRect(x: 15, y: 0, width: screenWidth - 30, height: 114)
        return filterView
    }()
    
    /// 商家服务
    lazy var merchServiceView: XSFilterView = {
        let filterView = XSFilterView(title: merchServiceTitle.title, buttonTitles: merchServiceTitle.buttonTitles, containerView: nil)
        filterView.frame = CGRect(x: 15, y: 0, width: screenWidth - 30, height: 124)
        return filterView
    }()
    
    lazy var bottomView: XSBottomSureView = {
        let bottom = XSBottomSureView()
        return bottom
    }()
    
    let scrollView: UIScrollView = {
        let sc = UIScrollView()
        sc.backgroundColor = UIColor.white
        sc.bounces = false
        sc.showsHorizontalScrollIndicator = false
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: self.view.tb_height - 44)
        bottomView.frame = CGRect(x: 0, y: scrollView.tb_maxY, width: screenWidth, height: 44)
        
    }

    override func initSubviews() {
        view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
       
        self.view.addSubview(bottomView)
        
        if selectFilterStyle == .homeDefault {
            setupHomeDefault()
        } else if (selectFilterStyle == .delivery) {
            setupDelivery()
        } else {
            setupGroupBuy()
        }

    }
    
    private func setupDelivery() {
        // 价格区间
        scrollView.addSubview(priceStepView)
        
        // 配送费
        scrollView.addSubview(distributView)
        distributView.tb_y = priceStepView.tb_maxY + 0
        
        // 优惠活动
        scrollView.addSubview(activityView)
        activityView.tb_y = eatUserNumView.tb_maxY + 0
        
        // 商家服务
        scrollView.addSubview(merchServiceView)
        merchServiceView.tb_y = activityView.tb_maxY + 0
        
        
        scrollView.contentSize(CGSize(width: screenWidth, height: merchServiceView.tb_maxY))
        
    }
    
    private func setupGroupBuy() {
        // 价格区间
        scrollView.addSubview(priceStepView)
        
        // 用餐人数
        scrollView.addSubview(eatUserNumView)
        eatUserNumView.tb_y = priceStepView.tb_maxY + 0
        
        // 优惠活动
        scrollView.addSubview(activityView)
        activityView.tb_y = eatUserNumView.tb_maxY + 0
        
        // 商家服务
        scrollView.addSubview(merchServiceView)
        merchServiceView.tb_y = activityView.tb_maxY + 0
        
        
        scrollView.contentSize(CGSize(width: screenWidth, height: merchServiceView.tb_maxY))
        
    }
    
    private func setupHomeDefault() {
        // 业务类型
        scrollView.addSubview(typeView)
        
        // 价格区间
        scrollView.addSubview(priceStepView)
        priceStepView.tb_y = typeView.tb_maxY + 0
        
        // 配送费
        scrollView.addSubview(distributView)
        distributView.tb_y = priceStepView.tb_maxY + 0
        
        // 用餐人数
        scrollView.addSubview(eatUserNumView)
        eatUserNumView.tb_y = distributView.tb_maxY + 0
        
        // 优惠活动
        scrollView.addSubview(activityView)
        activityView.tb_y = eatUserNumView.tb_maxY + 0
        
        // 商家服务
        scrollView.addSubview(merchServiceView)
        merchServiceView.tb_y = activityView.tb_maxY + 0
        
        
        scrollView.contentSize(CGSize(width: screenWidth, height: merchServiceView.tb_maxY))
    }

}
