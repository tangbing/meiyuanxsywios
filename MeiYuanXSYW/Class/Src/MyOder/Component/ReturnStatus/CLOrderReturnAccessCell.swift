//
//  CLOrderReturnAccessCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/24.
//

import UIKit

class CLOrderReturnAccessCell: XSBaseTableViewCell {
    
    let returnMoney = UILabel().then{
        $0.text = "退款金额:￥250.00"
        $0.textColor = .text
        $0.font = MYBlodFont(size: 16)
    }
    
    
    
    
    override func configUI() {
        super.configUI()
    }

}
