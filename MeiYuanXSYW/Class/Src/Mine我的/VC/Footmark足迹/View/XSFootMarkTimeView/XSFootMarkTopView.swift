//
//  XSFootMarkTimeVIew.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/17.
//

import UIKit
import Reusable


class XSFootMarkModel {
    var isSelect: Bool = false // 是否是选中状态
    var isCurrentDate: Bool = false // 是否是当前日期
    var cmps: DateComponents?
    
    
    
    init(isSelect: Bool,isCurrentDate: Bool = false, cmps: DateComponents?) {
        self.isSelect = isSelect
        self.isCurrentDate = isCurrentDate
        self.cmps = cmps
    }
}

class XSFootMarkTopView: UIView, NibLoadable {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var previousTimeBtn: UIButton!
    @IBOutlet weak var nextTimeBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var collectionViewH: NSLayoutConstraint!
    var times: [XSFootMarkModel] = [XSFootMarkModel]()
    var selectRow: Int = 0
    var selectModel: XSFootMarkModel?
    var year: Int = 0
    var month: Int = 0
    
    var selectTimeBlock: ((_ selectModel: XSFootMarkModel) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let flowLayout = UICollectionViewFlowLayout()
        let flow_w = (screenWidth/7.0)-0.3
        flowLayout.itemSize = CGSize(width: flow_w, height: 44)
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(cellType: XSCalendarCell.self)
        /// 获取当前时间
        let currentStr = Date.jk.timestampToFormatterTimeString(timestamp: Date.jk.secondStamp, format: "yyyy-MM")
        let timeArray = currentStr.components(separatedBy: "-")
        dealwithShowDate(timeArray: timeArray)
        
        nextTimeBtn.isEnabled = false
        
    }
    
    func dealwithShowDate(timeArray: [String]){
     
        if timeArray.count >= 2 {
            year = Int(timeArray[0]) ?? 0
            month = Int(timeArray[1]) ?? 00
            
            timeLabel.text = "\(year)" + "年" + "\(month)" + "月"

            let tempFirstStr = String(format: "%04ld-%02ld-01 12:00", year,month)
            
            /// string -> Date
           let firstDateInMonth = Date.jk.formatterTimeStringToDate(timesString: tempFirstStr, formatter: "yyyy-MM-dd HH:mm")
            /// 获取所选中的Date所在的天数
            let curDayNum = Date.jk.daysCount(year: year, month: month)
            let curComponents = XSTool.getDateComponentsWithDate(theDate: firstDateInMonth)
            // 获取今天是周几
            let firstWeekday = curComponents.weekday!
            let curWeekday = changeWeekNum(weekday: firstWeekday)
            //debugPrint("curWeekday:" + curWeekday)
            
            
            /// 这个月的结束日期
            let nextDateStr = String(format: "%04ld-%02ld-%02ld 12:00", year,month, curDayNum)
            
            let nextDateInMonth = Date.jk.formatterTimeStringToDate(timesString: nextDateStr, formatter: "yyyy-MM-dd HH:mm")
            // 获取时间是周几
            let nextWeekday = XSTool.getDateComponentsWithDate(theDate: nextDateInMonth).weekday!
            let curNextWeekday = changeWeekNum(weekday: nextWeekday)
            //debugPrint("curWeekday:" + curNextWeekday)

            times.removeAll()
            
            for i in 0..<curDayNum {
                let tempTime = String(format: "%04ld-%02ld-%02d 12:00", curComponents.year!, curComponents.month!, i+1)
                let tempTimeDate = Date.jk.formatterTimeStringToDate(timesString: tempTime, formatter: "yyyy-MM-dd HH:mm")
                let curDateComponents = XSTool.getDateComponentsWithDate(theDate: tempTimeDate)
                let model = XSFootMarkModel(isSelect: false,isCurrentDate: true, cmps: curDateComponents)
                times.append(model)
            }
            
            
            
            /// 上个月数据
            let thisFirstDate = XSTool.getPriousorLaterDateFromDate(date: firstDateInMonth, month: -1)
            let thisComponents = XSTool.getDateComponentsWithDate(theDate: thisFirstDate)
            let thisDayNum = Date.jk.daysCount(year: thisComponents.year!, month: thisComponents.month!)

            for i in 0..<curWeekday - 1 {
                let tempTime = String(format: "%04ld-%02ld-%02d 12:00", thisComponents.year!, thisComponents.month!, thisDayNum - i)
                let tempTimeDate = Date.jk.formatterTimeStringToDate(timesString: tempTime, formatter: "yyyy-MM-dd HH:mm")
                let cmps = XSTool.getDateComponentsWithDate(theDate: tempTimeDate)
                let model = XSFootMarkModel(isSelect: false, cmps: cmps)
                times.insert(model, at: 0)
            }
            
            // 下个月数据
            let nextFirstDate = XSTool.getPriousorLaterDateFromDate(date: firstDateInMonth, month: 1)
            let nextCmps = XSTool.getDateComponentsWithDate(theDate: nextFirstDate)
            for i in 0..<(7 - curNextWeekday)  {
                let tempTime = String(format: "%04ld-%02ld-%02d 12:00", nextCmps.year!, nextCmps.month!, i+1)
                let tempTimeDate = Date.jk.formatterTimeStringToDate(timesString: tempTime, formatter: "yyyy-MM-dd HH:mm")
                let cmps = XSTool.getDateComponentsWithDate(theDate: tempTimeDate)
                let model = XSFootMarkModel(isSelect: false, cmps: cmps)
                times.append(model)
            }
            
            let todayCmps = XSTool.getDateComponentsWithDate(theDate: Date())
            // 初始化默认今天选中
            for (_, model) in times.enumerated() {
                if model.cmps!.year == todayCmps.year &&
                   model.cmps!.month == todayCmps.month &&
                   model.cmps!.day == todayCmps.day
                    {
                    model.isSelect = true
//                    self.collectionView(collectionView, didSelectItemAt: IndexPath(item: idx, section: 0))
                    break
                }
            }
          
            // 第一次不改变
            if expandButton.isSelected {
                let row = totalHeightOfCalendar()
                collectionViewH.constant = CGFloat(row * 44)
                self.layoutIfNeeded()
            }
            /// 选择的model或当天是否在这个数组里，在第几行
            selectRowAction()
            
            scrollViewDidScroll(collectionView)
            collectionView.reloadData()
        }
    }
    
    func selectRowAction() {
        var row = -1
        var todayRow = 0
        for (idx, model) in times.enumerated() {
            if model.cmps?.year == selectModel?.cmps?.year &&
                model.cmps?.month == selectModel?.cmps?.month &&
                model.cmps?.day == selectModel?.cmps?.day {
                row = (idx + 1) / 7
                row = (idx + 1) % 7 > 0 ? row + 1 : row
                break
            }
        }
        
       
        for (idx, model) in times.enumerated() {
            if model.isSelect {
                todayRow = (idx + 1)/7
                todayRow = (idx + 1) % 7 > 0 ? todayRow + 1 : todayRow
            }
        }
        if row == -1 {
            row = todayRow
        }
        selectRow = row
    }
    
    /// 日历总共有多少行
    private func totalHeightOfCalendar() -> Int {
        var row = times.count / 7
        let col = times.count % 7
        if col != 0 {
            row = row + 1
        }
        return row
    }
    
    func changeWeekNum(weekday: NSInteger) -> NSInteger {
//        var i = 1
//        if (weekday == 1) {
//            i = 7
//        } else if (weekday == 2) {
//            i = 1
//        } else if (weekday == 3) {
//            i = 2
//        } else if (weekday == 4) {
//            i = 3
//        } else if (weekday == 5) {
//            i = 4
//        } else if (weekday == 6) {
//            i = 5
//        } else if (weekday == 7) {
//            i = 6
//        }
        return weekday
    }
    
    // MARK:event touch
    @IBAction func previousBtnClick(_ sender: UIButton) {
        /// 获取上个月时间
        month = month - 1
        if month <= 0 {
            month = 12
            year = year - 1
        }
        timeLabel.text = "\(year)" + "年" + "\(month)" + "月"
        nextTimeBtn.isEnabled = true
        
        let previousTimeStr = "\(year)-\(month)"
        let timeArray = previousTimeStr.components(separatedBy: "-")
        dealwithShowDate(timeArray: timeArray)
    }
    
    @IBAction func nextBtnClick(_ sender: UIButton) {
        /// 获取下个月时间
        month = month + 1
        if month >= 12 {
            month = 1
            year = year + 1
        }
        timeLabel.text = "\(year)" + "年" + "\(month)" + "月"

        let nextTimeStr = "\(year)-\(month)"
        let nextTimeStamp = Int(Date.jk.formatterTimeStringToTimestamp(timesString: nextTimeStr, formatter: "yyyy-MM", timestampType: .second))!
        
        let nowTimeStr = "\(Date().jk.year)-\(Date().jk.month)"
        let nowTimeStamp = Int(Date.jk.formatterTimeStringToTimestamp(timesString: nowTimeStr, formatter: "yyyy-MM", timestampType: .second))!
        
        // 超过当月，就不让点击，
        if nextTimeStamp >= nowTimeStamp {
            sender.isEnabled = false
        } else {
            sender.isEnabled = true
            let timeArray = nextTimeStr.components(separatedBy: "-")
            dealwithShowDate(timeArray: timeArray)
        }
    }
    
    @IBAction func expandBtnClick(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            collectionViewH.constant = 44
            self.scrollViewDidScroll(collectionView)
        } else {
            sender.isSelected = true
            collectionViewH.constant = CGFloat(44 * totalHeightOfCalendar())
        }
    }
}

extension XSFootMarkTopView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return times.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(for: indexPath, cellType: XSCalendarCell.self)
        let dataModel = times[indexPath.item]
        item.dataModel = dataModel
       return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let _ = times.map { $0.isSelect = false }
        for idx in 0..<times.count {
            if indexPath.item == idx {
                times[idx].isSelect = true
            }
        }
        let selectModel = times[indexPath.item]
        self.selectModel = selectModel
        
        if let block = selectTimeBlock {
            block(selectModel)
        }
        selectRowAction()
        collectionView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var point =  scrollView.contentOffset
        if !expandButton.isSelected {
            let scrollRow = CGFloat.maximum(0, CGFloat(selectRow - 1))
            point.y = 44 * scrollRow
            scrollView.contentOffset(point)
        }
    }
}


