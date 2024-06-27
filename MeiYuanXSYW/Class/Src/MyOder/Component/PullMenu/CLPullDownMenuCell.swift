//
//  CLPullDownMenuCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/2.
//

import UIKit

class CLPullDownMenuCell: UICollectionViewCell {
    
//    var itemSelected : Bool = false {
//        didSet{
//            if itemSelected == true {
//                name.setTitleColor(.white, for: .normal)
//                name.hg_addGradientColor([UIColor.hex(hexString: "#EFCB9C"),
//                                                    UIColor.hex(hexString: "#E8C089")],
//                                                   size: CGSize(width: 60, height: 32),
//                                         startPoint: CGPoint(x: 0.03, y: 0.15),
//                                                   endPoint: CGPoint(x: 0.8, y: 0.8))
//            }else{
//                name.setTitleColor(.text, for: .normal)
//                name.backgroundColor = UIColor.qmui_color(withHexString: "#F8F8F8")
//            }
//        }
//    }
    
    let name = UIButton().then{
        $0.setTitleColor(.text, for: .normal)
        $0.titleLabel?.font = MYFont(size: 13)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = false
        $0.backgroundColor = UIColor.qmui_color(withHexString: "#F8F8F8")
    }
    
    @objc func click(_ sender:UIButton){

    }
    

    
    
    func setupView(){
        self.backgroundColor = .white
        
        self.contentView.addSubview(name)
        name.addTarget(self, action: #selector(click(_ :)), for: .touchUpInside)
        
        name.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
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
