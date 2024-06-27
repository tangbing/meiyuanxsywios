//
//  CLMyOrderDetailContactCollectView.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/24.
//

import UIKit
import Kingfisher

class CLMyOrderDetailContactCollectView: UICollectionViewCell {

    let image = UIImageView()
    
    let name = UILabel().then{
        $0.textColor = UIColor.text
        $0.font = MYFont(size: 13)
    }
    
    func setupView(){
        self.backgroundColor = .white
        self.contentView.addSubviews(views: [image,name])
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(22)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(10)
            make.centerX.equalTo(image.snp.centerX)
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
