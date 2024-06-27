//
//  CLMyOrderCommentCollectionCell.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/11/25.
//

import UIKit

class CLMyOrderCommentCollectionCell: UICollectionViewCell {
    
    var deleteBlock:((_ index:Int)->())?
    
    // 是否显示删除按钮
    var isDelete:Bool = true {
        didSet{
            if isDelete == true {
                self.deleteButton.isHidden = false
            }else{
                self.deleteButton.isHidden = true
            }
        }
    }
    var tagIdx: Int = 0 {
        didSet {
            deleteButton.tag = tagIdx
        }
    }
    //控制最后一个添加图片按钮
    var isAddImage:Bool = true {
        didSet{
            if isAddImage == true {
                self.deleteButton.isHidden = true
                self.image.isHidden = true
                self.borderImage.isHidden = false
            }else{
                self.deleteButton.isHidden = false
                self.image.isHidden = false
                self.borderImage.isHidden = true
            }
        }
    }
    
    
    let deleteButton = UIButton().then{
        $0.setImage(UIImage(named: "mine_icon_delete"), for: .normal)
        $0.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
    }
    
    
    let image = UIImageView().then{
        $0.image = UIImage(named: "test")
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = 2
        $0.clipsToBounds = true
    }
    
    let borderImage = UIImageView().then{
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "add_pictures")
    }
    
    
    @objc func deleteAction(sender:UIButton){
        guard let action = deleteBlock else {
            return
        }
        action(sender.tag)
    }

    func setupView(){
        self.contentView.backgroundColor = .lightBackground
        self.contentView.addSubviews(views: [image,deleteButton,borderImage])
                        
        image.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(65)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        borderImage.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(65)
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
