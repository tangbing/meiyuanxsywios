//
//  TBHomeSecondViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/14.
//

import UIKit
import SwiftyJSON



class TBHomeSecondViewController: XSBaseViewController {
    let bgH: CGFloat = 142 * screenWidth / iPhone6ScreenWidth
    var startOffsetX: CGFloat = 0
    
    
    var killSecondStyle: TBHomeStyle = .homeDefault
    
    var activityTimeList: [HomeSecondActivityListModel] = [HomeSecondActivityListModel]()
    var activityGoodsModel: HomeSecondActivityGoodsModel = HomeSecondActivityGoodsModel()
    
    
    init(killSecondStyle: TBHomeStyle) {
        self.killSecondStyle = killSecondStyle
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var selectIdx: Int {
        return self.segmentView.selectIndex
    }
    
    lazy var childVCs: [TBHomeSecondContainerVc] = {

        var vcs = [TBHomeSecondContainerVc]()
        let homeVC = TBHomeSecondContainerVc()
        homeVC.secondStyle = self.killSecondStyle
        vcs.append(homeVC)
 
        return vcs
    }()
    
    lazy var topContainer: UIView = {
        let top = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: bgH))
        
        top.addSubview(bgImageV)
        bgImageV.frame = top.bounds
        
        top.addSubview(locationIcon)
        locationIcon.frame = CGRect(x:screenWidth - 15 - 10 , y:kStatusTopInset + 7 , width: 15, height: 15)

        top.addSubview(selectLocationBtn)
        selectLocationBtn.frame = CGRect(x: locationIcon.tb_right - 120 - 10, y:kStatusTopInset + 17 , width: 120, height: 26)
        selectLocationBtn.tb_centerY = locationIcon.tb_centerY

        top.addSubview(backBtn)
        backBtn.frame = CGRect(x: 0, y: kStatusTopInset + 7, width: 24, height: 24)
        backBtn.tb_centerY = locationIcon.tb_centerY
        
        top.addSubview(secondLogoImageV)
        secondLogoImageV.frame = CGRect(x: backBtn.tb_right + 2, y: 0, width: 78, height: 26)
        secondLogoImageV.tb_centerY = backBtn.tb_centerY
        return top
    }()
    
    lazy var bgImageV: UIImageView = {
        let bgImageV = UIImageView()
        bgImageV.image = self.killSecondStyle.image
        bgImageV.contentMode = .scaleAspectFill
        return bgImageV
    }()
    
    lazy var selectLocationBtn: UIButton = {
        let selectLocationBtn = UIButton(type: .custom)
        selectLocationBtn.setTitle("城市天地广城市天地广", for: .normal)
        selectLocationBtn.setTitleColor(.white, for: .normal)
        selectLocationBtn.titleLabel?.font = MYBlodFont(size: 14)
        selectLocationBtn.setImage(UIImage(named: "home_second_positioning"), for: .normal)
        selectLocationBtn.addTarget(self, action: #selector(goSelectLocation), for: .touchUpInside)
        return selectLocationBtn
    }()
    
    lazy var locationIcon: UIButton = {
        let locationIcon = UIButton(type: .custom)
        locationIcon.setBackgroundImage(UIImage(named: "home_second_location_pulldown"), for: .normal)
        locationIcon.addTarget(self, action: #selector(goSelectLocation), for: .touchUpInside)
        return locationIcon
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "nav_back_white"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return backBtn
    }()
    
    lazy var secondLogoImageV: UIImageView = {
        let gogoImageV = UIImageView(image: #imageLiteral(resourceName: "second_kill"))
        return gogoImageV
    }()
    
    lazy var segmentView: TBSegmentView = {
        let segment = TBSegmentView(frame: CGRect(x: 0.0, y: secondLogoImageV.tb_maxY, width: screenWidth, height: 55))
        segment.selectTextColor = killSecondStyle.secondColor
        segment.delegate = self
        return segment
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "- 距离结束 还有 00:20:21 -"
        label.font = MYFont(size: 14)
        label.textColor = UIColor.hex(hexString: "#F11F16")
        label.textAlignment = .center
        return label
    }()
    
    lazy var statusView: UIView = {
        let iv = UIView(frame: CGRect(x: 0, y: topContainer.tb_maxY + 10, width: screenWidth, height: 44))
        iv.addSubview(statusLabel)
        statusLabel.frame = iv.bounds
        return iv
    }()

    
    lazy var contentScrollView: UIScrollView = {
        let scrollW = screenWidth
        let scrollH: CGFloat = screenHeight - statusView.tb_maxY - bottomInset - 10
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: statusView.tb_maxY, width: scrollW, height: scrollH))
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.backgroundColor = .red
       
        
        for (idx, vc) in self.childVCs.enumerated() {
            self.addChild(vc)
            scrollView.addSubview(vc.view)
            vc.view.frame = CGRect(x: CGFloat(idx) * scrollW, y: 0, width: scrollW, height: scrollH)
        }
        scrollView.contentSize = CGSize(width: CGFloat(self.childVCs.count) * scrollW, height: 0)
        
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSecondTimeData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.homeSecondCountDownNotification), name: .CLCountDownNotification, object: nil)

        
        self.view.addSubview(topContainer)

        topContainer.addSubview(segmentView)
        
        self.view.addSubview(statusView)
        
        self.view.addSubview(contentScrollView)

    }
    
    func startSecondKill(countDown: Int) {
        
        if countDown < 0 { // 不启用定时器
            return
        }
        CLCountDownManager.sharedManager.start()
        CLCountDownManager.sharedManager.addSourceWithIdentifier(identifier: "HomeSecondStartSecondKill")
        uLog(CLCountDownManager.sharedManager.timeIntervalDict)
        

    }

    
    func changeSecondStatus(isFinish: Bool){
        if isFinish {
            statusView.tb_height = 0
            statusLabel.isHidden = true
        } else {
            statusView.tb_height = 44
            statusLabel.isHidden = false
        }
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

    /// 隐藏导航栏
    override func preferredNavigationBarHidden() -> Bool {
        return true
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
   
    
    override func initSubviews() {
    
    }
    
    
    // MARK: - event click
    @objc func backBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func goSelectLocation(){
        
    }
    
    @objc private func homeSecondCountDownNotification() {
        // 计算倒计时
        let timeInterval: Int
        timeInterval = CLCountDownManager.sharedManager.timeIntervalWithIdentifier(identifier:"HomeStartSecondKill")
        let countDown = self.activityGoodsModel.countDown - timeInterval
        // 当倒计时到了进行回调
        if (countDown <= 0) {
            
            // 活动开始
//            guard let handler = killSecondStartHandler else {
//                return
//            }
//            handler()
            uLog(" handler()")
            
        }else{
            // 重新赋值
            let tiemStr = Date.jk.getFormatPlayTime(seconds: countDown, type: .hour)
            statusLabel.text = tiemStr
           
        }
    }


}


// MARK: - httpRequest
extension TBHomeSecondViewController {

    func loadSecondListData(activityId: Int){

        MerchantInfoProvider.request(.secKillActivityGoodsList(businessType: 0, secKillActivityId: activityId, lat: lat, lng: lon, page: 1, pageSize: pageSize), model: HomeSecondActivityGoodsModel.self) { returnData in

            if let goodsSeconds = returnData {
                uLog(goodsSeconds)
                self.activityGoodsModel = goodsSeconds
                
                if let firstVc = self.childVCs.first {
                    firstVc.activityGoodsModel = self.activityGoodsModel
                }
                
                
            }


        } errorResult: { errorMsg in
            XSTipsHUD.hideAllTips()
            XSTipsHUD.showText(errorMsg)
        }

    }
    
    
    private func loadSecondTimeData() {
        
        let dic :[String:Any] = [:]
        myOrderProvider.request(MyOrderService.seckillactivitylist(dic)) { result in
            switch result {
            case let .success(response):
                guard let jsonData = try? JSON(data: response.data) else {
                    return
                }
                if  jsonData["resp_code"].intValue == 0{

                    let returnArray = jsonData["data"].arrayValue
                    self.activityTimeList = returnArray.compactMap {
                        
//                        let storyVC = TBHomeSecondContainerVc()
//                        storyVC.secondStyle = self.killSecondStyle
//                        self.childVCs.append(storyVC)
                        
                        return HomeSecondActivityListModel.init(jsonData:$0)
                    }

                    DispatchQueue.main.async {
                        self.segmentView.datas = self.activityTimeList
                        

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            self.segmentView.defaultSelect = 0
                            if let firstModel = self.activityTimeList.first {
                                //self.loadSecondListData(activityId: firstModel.seckillActivityId)
                                let containerVC = self.childVCs.first
                                self.loadSecondListData(activityId: firstModel.seckillActivityId)
                            }
                            
                        }
                    }
                }else{
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                }

             case let .failure(error):
                //网络连接失败，提示用户
                XSTipsHUD.showText(error.localizedDescription)
            }
        }
        

    }
    
    func setContainerVcData(idx: Int) {
        let containerVc = self.childVCs[idx]
        containerVc.activityGoodsModel = self.activityGoodsModel
    }
    
}

// MARK: - TBSegmentViewDelegate
extension TBHomeSecondViewController: TBSegmentViewDelegate {
    func didSelectItem(at index: Int) {
        //contentScrollView.setContentOffset(CGPoint(x: Int(self.view.tb_width) * index, y: 0), animated: true)
        //self.loadSecondListData(activityId: timeActivityModel.seckillActivityId)

        
        let timeActivityModel = activityTimeList[index]
        
        self.loadSecondListData(activityId: timeActivityModel.seckillActivityId)
        
    }
}

// MARK: - UIScrollViewDelegate
extension TBHomeSecondViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        uLog("scrollViewDidEndDragging")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        uLog("scrollViewDidEndDecelerating")

        if scrollView == contentScrollView {
            var endIndex = 0
            let offsetX = scrollView.contentOffset.x
            let startIndex = floor(startOffsetX / scrollView.tb_width)
            if  offsetX > startOffsetX{//左滑left
                endIndex = Int(startIndex + 1)
                if endIndex > self.childVCs.count - 1 {
                    endIndex = self.childVCs.count - 1
                }
            } else if(offsetX == startOffsetX) {//没滑过去
                endIndex = Int(startIndex)
            } else{
                endIndex = Int(startIndex - 1)
                endIndex = endIndex < 0 ? 0 : endIndex
            }
           segmentView.defaultSelect = endIndex
            
        }
        
        
        
    }

}


