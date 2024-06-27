//
//  XSRegisterRedPacketPopView.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/7.
//

import UIKit

class XSRegisterRedPacketPopView: TBBaseView {

    lazy var applyButton: UIButton = {
        let apply = UIButton(type: .custom)
        apply.setBackgroundImage(UIImage(named: "register_redpacket_receive"), for: .normal)
        apply.addTarget(self, action: #selector(applyRedPacket), for: UIControl.Event.touchUpInside)
        return apply
    }()
    
    lazy var redPacketListTableView: TBBaseTableView = {
        let redPacket = TBBaseTableView(frame: .zero, style: .plain)
        redPacket.register(cellType: XSRegisterRedPacketPopTableViewCell.self)
        redPacket.backgroundColor = .clear
        redPacket.dataSource = self
        redPacket.delegate = self
        redPacket.tableFooterView = UIView()
        return redPacket
    }()
    
    lazy var containerView: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var bgimageContainer: UIImageView = {
        let bg = UIImageView()
        bg.image = UIImage(named: "register_red_packet_bg")
        return bg
    }()
    
    lazy var timeLabel: UILabel = {
        let time = UILabel()
        time.textColor = UIColor.hex(hexString: "#EF8434")
        time.font = MYBlodFont(size: 10)
        time.text = "剩余领取时间：1天14:23:35"
        return time
    }()
    
    lazy var overlayView: UIControl = {
        let control = UIControl(frame: UIScreen.main.bounds)
        control.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.8)
        //control.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        control.isHidden = true
        return control
    }()
    
    lazy var backButton: UIButton = {
        let back = UIButton()
        back.setImage(UIImage(named: "register_redpacket_closure"), for: .normal)
        back.addTarget(self, action: #selector(fadeOut), for: .touchUpInside)
        return back
    }()
    
    override func configUI() {
        super.configUI()
        
//        self.addSubview(containerView)
//        containerView.snp.makeConstraints { make in
//            make.ed
//        }
        
        self.addSubview(bgimageContainer)
        bgimageContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0))
        }
        
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.centerX.equalToSuperview()
            make.height.equalTo(14)
        }
        
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.top.equalTo(bgimageContainer.snp_bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: FMScreenScaleFrom(250), height: FMScreenScaleFrom(50)))
            make.bottom.equalTo(bgimageContainer.snp_bottom).offset(-15)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(redPacketListTableView)
        redPacketListTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(applyButton.snp_top).offset(-15)
        }
    
    }
    
    @objc func applyRedPacket() {
        
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 330, height: 450 + 40)
    }

    // MARK: - public event
    func show(){
        let window = UIApplication.shared.keyWindow
        window?.addSubview(overlayView)
        window?.addSubview(self)
        self.frame = CGRect(x: 0, y: 0, width: intrinsicContentSize.width, height: intrinsicContentSize.height)
        self.center = CGPoint(x: screenWidth * 0.5, y: screenHeight * 0.5)
        fadeIn()
    }
    
    func fadeIn() {
     
        UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.overlayView.isHidden = false
            self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        } completion: { finish in
                UIView.animate(withDuration: 0.15) {
                    self.transform = .identity

                } completion: { finish in
                    
                }
              
         }
    }
    
    @objc func fadeOut() {
        UIView.animate(withDuration: 0.15) {
            self.overlayView.isHidden = true
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        } completion: { (finish) in
            
            UIView.animate(withDuration: 0.15) {
                self.transform = .identity
            } completion: { finish in
                self.overlayView.removeFromSuperview()
                self.removeFromSuperview()
            }
        }
    }

}

extension XSRegisterRedPacketPopView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSRegisterRedPacketPopTableViewCell.self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.clear
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = .clear
        return iv
    }
    
    
}
