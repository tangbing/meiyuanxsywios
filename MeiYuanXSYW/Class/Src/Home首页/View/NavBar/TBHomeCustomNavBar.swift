//
//  TBHomeCustomNavBar.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/22.
//

import UIKit

enum navBarlocationAligent {
    case left
    case right
}

class TBHomeCustomNavBar: UIView {
    
    var searchTextFieldDidBeginEditingBlock: ((_ navBar: TBHomeCustomNavBar) -> Void)?
    var searchGoSelectLocationBlock: ((_ navBar: TBHomeCustomNavBar) -> Void)?
    var searchGoMessageBlock: ((_ navBar: TBHomeCustomNavBar) -> Void)?
    var searchBackBtnClick: ((_ navBar: TBHomeCustomNavBar) -> Void)?
    
    var locationAligent: navBarlocationAligent = .left
    
    lazy var selectLocationBtn: UIButton = {
        let selectLocationBtn = UIButton(type: .custom)
        selectLocationBtn.setTitle("城市天地广城市天地广", for: .normal)
        selectLocationBtn.setTitleColor(.text, for: .normal)
        selectLocationBtn.titleLabel?.font = MYBlodFont(size: 14)
        selectLocationBtn.setImage(#imageLiteral(resourceName: "home_location"), for: .normal)
        selectLocationBtn.addTarget(self, action: #selector(goSelectLocation), for: .touchUpInside)
        return selectLocationBtn
    }()
    
    lazy var locationIcon: UIButton = {
        let locationIcon = UIButton(type: .custom)
        locationIcon.setBackgroundImage(UIImage(named: "home_nav_drop-down"), for: .normal)
        locationIcon.addTarget(self, action: #selector(goSelectLocation), for: .touchUpInside)
        return locationIcon
    }()
    
    lazy var messageBtn: UIButton = {
        let messageBtn = UIButton(type: .custom)
        messageBtn.setBackgroundImage(UIImage(named: "home_nav_news"), for: .normal)
        messageBtn.addTarget(self, action: #selector(goMessage), for: .touchUpInside)
        return messageBtn
    }()
    
    lazy var searchTextField: UITextField = {
        let search = TBSearchTextField()
        search.searchDelegate = self
        return search
    }()
    
    lazy var backBtn: UIButton = {
        let back = UIButton(type: .custom)
        back.setImage(UIImage(named: "nav_back_black"), for: .normal)
        back.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        return back
    }()
    

    init(locationAligent : navBarlocationAligent = .left) {
        super.init(frame: .zero)
        self.locationAligent = locationAligent
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .background
        
        self.addSubview(messageBtn)
        messageBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(5)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
        if locationAligent == .left {
            
            self.addSubview(selectLocationBtn)
            selectLocationBtn.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(0)
                make.top.equalToSuperview().offset(5)
                make.height.equalTo(26)
                make.width.equalTo(120)
            }

            self.addSubview(locationIcon)
            locationIcon.snp.makeConstraints { make in
                make.left.equalTo(selectLocationBtn.snp_right).offset(0)
                make.centerY.equalTo(selectLocationBtn)
                make.size.equalTo(CGSize(width: 22, height: 22))
            }
            
        } else {
            self.addSubview(locationIcon)
            locationIcon.snp.makeConstraints { make in
                make.right.equalTo(messageBtn.snp_left).offset(-10)
                make.centerY.equalTo(messageBtn)
                make.size.equalTo(CGSize(width: 22, height: 22))
            }
            
            self.addSubview(selectLocationBtn)
            selectLocationBtn.snp.makeConstraints { make in
                make.right.equalTo(locationIcon.snp_left).offset(0)
                make.centerY.equalTo(messageBtn)
                make.height.equalTo(26)
                make.width.equalTo(120)
            }
            
            self.addSubview(backBtn)
            backBtn.snp.makeConstraints { make in
                make.left.equalToSuperview().offset(16)
                make.centerY.equalTo(messageBtn)
                make.size.equalTo(CGSize(width: 24, height: 24))
            }
            
            
        }

       
        self.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(selectLocationBtn.snp_bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(30)
            make.bottom.equalToSuperview().offset(0)
        }
    }
    
    // MARK: - event click
    @objc func goMessage(){
        searchTextField.resignFirstResponder()
        self.searchGoMessageBlock?(self)
    }
    
    @objc func goSelectLocation(){
        searchTextField.resignFirstResponder()
        self.searchGoSelectLocationBlock?(self)
    }
    
    @objc func backBtnClick() {
        self.searchBackBtnClick?(self)
    }

    
}

// MARK: - TBSearchTextFieldDelegate
extension TBHomeCustomNavBar: TBSearchTextFieldDelegate {
    func searchTextFieldDidBeginEditing(textField: TBSearchTextField) {
        searchTextField.resignFirstResponder()
        self.searchTextFieldDidBeginEditingBlock?(self)
    }
}
