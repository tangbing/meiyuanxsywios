//
//  TBStartView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/14.
//

import UIKit

class TBStartView: UIView {
    
    var grade: Double = 0.0
    /// 完整星星个数: 四舍五入
    var star: Int {
        // 如果暂无评价，则 显示5个灰色星星
        if grade == 0.0 {
            return 5
        }
        return Int(round(grade))
    }
    
    /// 是否含半颗星
       var isHalf: Bool {
           // 整数分，或者小数部分 >= 0.5（五入），这种情况是不包含半颗星的
           // 如 grade = 4.0分, star = 4 ；或者 grade = 4.51分，四舍五入后，star = 5，都是满足这种情况；
           if Double(star) >= grade {
               return false
           }else {
               //小数部分 < 0.5 的情况，用半颗星表示
               return true
           }
       }

    
    let spacing: CGFloat = 2

    var lastStar: UIImageView?
    var tempLastStar: UIImageView?
    
    convenience init(frame: CGRect,score: Double) {
        self.init(frame: frame)
        startView(score: score)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func startView(score: Double){
        
        self.clearAll()
        lastStar = nil
        tempLastStar = nil
        //print("startView")
        self.grade = score
        
        
        /// 当成绩0.0，直接显示灰色星星
        if self.grade == 0.0 {
            for i in 0..<star {
                let startImgView = UIImageView()
                startImgView.image = UIImage(named: "stars2")
                startImgView.tag = i
                self.addSubview(startImgView)
                startImgView.snp.makeConstraints {
                    $0.size.equalTo(CGSize(width: 12, height: 12))
                    $0.centerY.equalToSuperview()
                    $0.left.equalTo(tempLastStar != nil ? tempLastStar!.snp_right : self.snp_left).offset(spacing)
                }
                
                tempLastStar = startImgView
            }
            return
            
        }

        for i in 0..<star {
            let startImgView = UIImageView()
            startImgView.image = #imageLiteral(resourceName: "score")
            startImgView.tag = i
            self.addSubview(startImgView)
            startImgView.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 12, height: 12))
                $0.centerY.equalToSuperview()
                $0.left.equalTo(lastStar != nil ? lastStar!.snp_right : self.snp_left).offset(spacing)
            }
            
            lastStar = startImgView
        }
        
        if isHalf {
            let halfStartImgView = UIImageView()
            halfStartImgView.image = #imageLiteral(resourceName: "score1")
            self.addSubview(halfStartImgView)
            halfStartImgView.snp.makeConstraints {
                $0.size.equalTo(CGSize(width: 12, height: 12))
                $0.centerY.equalToSuperview()
                $0.left.equalTo(lastStar != nil ? lastStar!.snp_right : self.snp_left).offset(spacing)
            }
        }
    }
    
    func setupUI() {
//        self.addSubview(stackView)
//        stackView.frame = self.bounds
    }
    
    
    
    

}
