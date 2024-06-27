//
//  XSHomeSelectMenu.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/26.
//

import UIKit
import QMUIKit

protocol XSHomeSelectMenuClickDelegate: NSObjectProtocol {
    func clickSelectMenu(selectMenu: TBPullDownMenu, selectTitle selectMenuTitle: String)
}

protocol TBPullDownMenuDataSource: NSObjectProtocol {
    /**
     *  下拉菜单有多少列
     *
     *  @param pullDownMenu 下拉菜单
     *
     *  @return 下拉菜单有多少列
     */
    func numberOfColsInMenu(pullDownMenu: TBPullDownMenu) -> NSInteger
    
    /**
     *  下拉菜单每列对应的控制器
     *
     *  @param pullDownMenu 下拉菜单
     *  @param index        第几列
     *
     *  @return 下拉菜单每列对应的控制器
     */
    func viewControllerForColAtIndex(index: NSInteger, pullDownMenu: TBPullDownMenu) -> UIViewController

    /**
     *  下拉菜单每列对应的高度
     *
     *  @param pullDownMenu 下拉菜单
     *  @param index        第几列
     *
     *  @return 下拉菜单每列对应的高度
     */
    
    func heightForColAtIndex(index: NSInteger, pullDownMenu: TBPullDownMenu) -> CGFloat

}

class TBCover: UIView {
    var clickCover: (() -> Void)?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        clickCover?()
    }
}

class TBPullDownMenu: UIView {

    weak var delegate: XSHomeSelectMenuClickDelegate?
    
    weak var dataSource: TBPullDownMenuDataSource?
    
    let selectMenuTitles = ["附近","品类","综合排序","筛选"]
    
    var coverColor: UIColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6)
    var controllers = [UIViewController]()
    var colsHeight = [CGFloat]()
    var menuButtons = [UIButton]()
    
    var showInView: UIView?
    
    lazy var coverView: UIView = {
        let coverX: CGFloat = 0
        let coverY: CGFloat = self.tb_maxY + 15
        let coverW: CGFloat = screenWidth
        let coverH: CGFloat = self.showInView!.tb_height
        
        let cover = TBCover(frame: CGRect(x: coverX, y: coverY, width: coverW, height: coverH))
        cover.backgroundColor = coverColor
        
        showInView?.addSubview(cover)
        showInView?.bringSubviewToFront(cover)
        // 点击蒙版调用
        cover.clickCover = { [weak self] in
            self?.dismiss()
        }
        return cover
    }()
    
    lazy var contentView: UIView = {
        let cont = UIView()
        cont.backgroundColor = .white
        cont.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 0)
        cont.clipsToBounds = true
        coverView.addSubview(cont)
        return cont
    }()
    
    init(showInView: UIView,dataSource:TBPullDownMenuDataSource) {
        self.dataSource = dataSource
        self.showInView = showInView
        super.init(frame: .zero)
        setupUI()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        self.hg_setAllCornerWithCornerRadius(radius: 5)
        
        // 监听更新菜单标题通知
        NotificationCenter.default.addObserver(forName: NSNotification.Name.XSUpdateMenuTitleNotification, object: nil, queue: OperationQueue.main) { note in
            //let col = self.controllers.indexes(note.object as! UIViewController)
            
            self.dismiss()
            
//            let allValues = note.userInfo?.allValues()
//
//            if(allValues?.count > 1) return
            
            
        }
    }
    
     func setupButton() {
        
        let count = selectMenuTitles.count
        var btnX: CGFloat = 0
        let btnY: CGFloat = 0
        let btnW = self.bounds.size.width / CGFloat(count)
        let btnH = self.bounds.size.height
        
        for i in 0..<count {
            let spaceBtn = createMenuButton(title: selectMenuTitles[i])
            spaceBtn.tag = i
            btnX = CGFloat(i) * btnW
            self.addSubview(spaceBtn)
            spaceBtn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            menuButtons.append(spaceBtn)
        }
        
//        // 附近
//        let spaceBtn = createMenuButton(title: selectMenuTitles[0])
//        spaceBtn.addTarget(self, action: #selector(clickMoreAction), for: .touchUpInside)
//        self.addSubview(spaceBtn)
//        spaceBtn.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(15)
//            make.top.bottom.equalToSuperview()
//            make.width.equalTo(44)
//        }
//
//        // 品类
//        let typeBtn = createMenuButton(title: selectMenuTitles[1])
//        typeBtn.addTarget(self, action: #selector(clickMoreAction), for: .touchUpInside)
//        self.addSubview(typeBtn)
//        typeBtn.snp.makeConstraints { make in
//            make.left.equalTo(spaceBtn.snp_right).offset(35)
//            make.top.bottom.equalToSuperview()
//            make.width.equalTo(44)
//        }
//
//        // 综合排序
//        let middleBtn = createMenuButton(title: selectMenuTitles[2])
//        middleBtn.addTarget(self, action: #selector(clickMoreAction), for: .touchUpInside)
//        self.addSubview(middleBtn)
//        middleBtn.snp.makeConstraints { make in
//            make.centerX.equalToSuperview().offset(25)
//            make.top.bottom.equalToSuperview()
//            make.width.equalTo(84)
//        }
//
//
//        // 筛选
//        let seleteBtn = createMenuButton(title: selectMenuTitles[3])
//        seleteBtn.addTarget(self, action: #selector(clickMoreAction), for: .touchUpInside)
//        self.addSubview(seleteBtn)
//        seleteBtn.snp.makeConstraints { make in
//            make.right.equalToSuperview().offset(-15)
//            make.top.bottom.equalToSuperview()
//            make.width.equalTo(44)
//        }
        
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        self.reload()
    }
    
    private func clear(){
        menuButtons.removeAll()
        controllers.removeAll()
        colsHeight.removeAll()
        
        self.subviews.forEach { iv in
            iv.removeFromSuperview()
        }
    }
    
    public func reload() {
        // 删除之前所有数据,移除之前所有子控件
        self.clear()
        
        if showInView == nil {
            showInView = self.superview
        }
        
        guard let dataSource = self.dataSource else {
            return
        }
        
        let cols = dataSource.numberOfColsInMenu(pullDownMenu: self)
        if cols == 0 {
            return
        }
        
        for col in 0..<cols {
            let height = dataSource.heightForColAtIndex(index: col, pullDownMenu: self)
            colsHeight.append(height)
            
            let vc = dataSource.viewControllerForColAtIndex(index: col, pullDownMenu: self)
            self.controllers.append(vc)
        }
        self.setupButton()
    }
    
   
    public func dismiss() {
        
        NotificationCenter.default.post(name: NSNotification.Name.init("MenuTitleNote_Btn_Dismiss_Click"), object: nil)

        // 所有按钮取消选中
        for button in menuButtons {
            button.isSelected = false
        }
        
        // 移除蒙版
        self.coverView.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0)
        UIView.animate(withDuration: 0.25) {
            self.contentView.tb_height = 0
        } completion: {  finish in
            self.coverView.isHidden = true
            self.coverView.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.7)
           
        }
        
    }

    @objc func clickSelectAction(button: UIButton) {
        //delegate?.clickSelectMenu(selectMenu: self, selectTitle: selectBtn.currentTitle!)
        
        button.isSelected = !button.isSelected
        // 取消其他按钮选中
        for otherButton in self.menuButtons {
            if otherButton === button {
                continue
            }
            otherButton.isSelected = false
        }

        if button.isSelected == true {
            NotificationCenter.default.post(name: NSNotification.Name.init("MenuTitleNote_Btn_Show_Click"), object: nil)

            // 添加对应蒙版
            self.coverView.isHidden = false
            // 获取角标
            let i = button.tag

            self.contentView.subviews.forEach { iv in
                iv.removeFromSuperview()
            }
            let vc = self.controllers[i]
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)

            let height = self.colsHeight[i]
            UIView.animate(withDuration: 0.25) {
                self.contentView.tb_height = height
            }
        } else {// 当按钮未选中，收回蒙版
            self.dismiss()
        }
        
    }
    
    private func createMenuButton(title: String) -> UIButton {
        let arrowBtn = UIButton()
        arrowBtn.setTitleColor(.twoText, for: .normal)
        arrowBtn.titleLabel?.font = MYFont(size: 14)
        arrowBtn.setTitle(title, for: .normal)
        arrowBtn.setImage(UIImage(named: "home_filter_arrow"), for: .normal)
        arrowBtn.setImage(UIImage(named: "login_under"), for: .selected)
        arrowBtn.jk.setImageTitleLayout(.imgRight, spacing: 5)
        arrowBtn.addTarget(self, action: #selector(clickSelectAction(button:)), for: .touchUpInside)
        return arrowBtn
    }
    
    deinit {
        clear()
        NotificationCenter.default.removeObserver(self)
    }

    

}
