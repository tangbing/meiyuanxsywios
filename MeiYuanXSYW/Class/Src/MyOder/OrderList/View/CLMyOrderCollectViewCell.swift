//
//  CLMyOrderCollectViewCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/23.
//

import UIKit
import Kingfisher

class CLMyOrderCollectViewCell: UICollectionViewCell {
    
    let image = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .white
        $0.clipsToBounds = true
    }
    
    let name = UILabel().then{
        $0.text = "菜品名称"
        $0.textColor = UIColor.twoText
        $0.font = MYFont(size: 14)
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.contentView.addSubviews(views: [image,name])
        
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview()
            make.height.equalTo(60)
        }
        
        name.snp.makeConstraints { make in
            make.left.equalTo(image.snp.left)
            make.top.equalTo(image.snp.bottom).offset(2)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
