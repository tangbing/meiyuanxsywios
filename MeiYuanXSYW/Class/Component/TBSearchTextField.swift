//
//  TBSearchTextField.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/12.
//

import UIKit

@objc protocol TBSearchTextFieldDelegate: NSObjectProtocol {
   @objc optional func searchTextFieldDidBeginEditing(textField: TBSearchTextField)
   @objc optional func searchTextFieldDidTextChange(textField: TBSearchTextField)
   @objc optional func searchTextFieldDidClickSearchBtn(textField: TBSearchTextField)
}

class TBSearchTextField: UITextField {

    weak public var searchDelegate: TBSearchTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    var placeholderText: String? {
        didSet {
            self.placeholder = placeholderText
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.backgroundColor = .white
        self.hg_setAllCornerWithCornerRadius(radius: 15)
        self.jk.addBorder(borderWidth: 1, borderColor: .tag)
        self.font = MYFont(size: 14)
        self.placeholder = "搜索更多美食"
        self.jk.setPlaceholderAttribute(font: MYFont(size: 13), color: UIColor.hex(hexString: "#B3B3B3"))
        
        let rightBtn = UIButton(type: .custom)
        rightBtn.setBackgroundImage(UIColor.tag.image(), for: .normal)
        rightBtn.setTitle("搜索", for: .normal)
        rightBtn.setTitleColor(.white, for: .normal)
        rightBtn.titleLabel?.font = MYFont(size: 14)
        rightBtn.hg_setAllCornerWithCornerRadius(radius: 13)
        rightBtn.frame = CGRect(x: 0, y: 2, width: 51, height: 24)
        rightBtn.addTarget(self, action: #selector(rightSearchBtnClick), for: .touchUpInside)
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 54, height: 28))
        rightView.backgroundColor = .clear
        rightView.addSubview(rightBtn)
        rightView.hg_setAllCornerWithCornerRadius(radius: 13)
        rightBtn.tb_centerY = rightView.tb_centerY
        
        self.jk.addLeftIcon(#imageLiteral(resourceName: "home_left_search"), leftViewFrame: CGRect(x: 0, y: 0, width: 34, height: 30), imageSize: CGSize(width: 21, height: 21))
        self.rightView = rightView
        self.rightViewMode = UITextField.ViewMode.always
        
        NotificationCenter.default.addObserver(self, selector: #selector(searchTextFieldDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)
        NotificationCenter.default.addObserver(self, selector: #selector(searchTextFieldDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
    
    @objc func searchTextFieldDidBeginEditing() {
        guard let searchFieldDelegate = searchDelegate else {
            return
        }
        searchFieldDelegate.searchTextFieldDidBeginEditing?(textField: self)
    }
    
    @objc func searchTextFieldDidChange(){
        guard let searchFieldDelegate = searchDelegate else {
            return
        }
        searchFieldDelegate.searchTextFieldDidTextChange?(textField: self)
    }
    
    @objc func rightSearchBtnClick(){
        guard let searchFieldDelegate = searchDelegate else {
            return
        }
        searchFieldDelegate.searchTextFieldDidClickSearchBtn?(textField: self)
    }


}
