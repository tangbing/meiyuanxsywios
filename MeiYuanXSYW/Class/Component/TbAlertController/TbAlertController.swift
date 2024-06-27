//
//  TbAlertController.swift
//  TbAlertController
//
//  Created by Tb on 2021/6/17.
//

import UIKit
import SnapKit

enum TbPreferredStyle {
    case preferredStyleAlert
    case preferredStyleActionSheet
}

enum TbAlertActionStyle {
    case TbAlertActionStyleDefault
    case TbAlertActionStyleCancel
    case TbAlertActionStyleDestructive
}

typealias handler = ((_ action: TbAlertAction) -> Void)?

var kHorMargin: CGFloat = 15
var kTextFieldMargin: CGFloat = 5
var kActionButtonHeight:CGFloat = 49
var kContentWidth: CGFloat = 271
var kseparatorlLneHeight: CGFloat = 0.5
var kActionSheetHeight: CGFloat = 56


class TbAlertAction: NSObject {
    var textTitle: String
    var actionButton: UIButton?
    var textFont: UIFont = .systemFont(ofSize: 16)
    var isEnable: Bool = true {
        willSet {
            actionButton?.isEnabled = newValue
        }
        
    }
    var alertActionStyle: TbAlertActionStyle
    var handler: handler
    var titleColorDict: [UIControl.State : UIColor] = [:]
    var backgroundColorDict: [UIControl.State : UIColor] = [:]

    
    init(textTitle: String, alertActionStyle: TbAlertActionStyle, handler: handler) {
        self.textTitle = textTitle
        self.alertActionStyle = alertActionStyle
        self.handler = handler
        
        super.init()
        
        if alertActionStyle == .TbAlertActionStyleDefault {
            setTitleColor(titleColor: UIColor.hex(hexString: "#333333"), forState: .normal)
        } else if(alertActionStyle == .TbAlertActionStyleCancel) {
            setTitleColor(titleColor: UIColor.hex(hexString: "#FA3232"), forState: .normal)
        }
        
        setBackgroundColor(backgroundColor: UIColor.white, forState: .normal)
        setBackgroundColor(backgroundColor: UIColor.white.withAlphaComponent(0.5), forState: .highlighted)
        
        if alertActionStyle == .TbAlertActionStyleDestructive {
            setTitleColor(titleColor: UIColor.white, forState: .normal)
            setBackgroundColor(backgroundColor: UIColor.lightGray, forState: .normal)
        }
        
    }
    
    func setTitleColor(titleColor: UIColor?, forState state: UIControl.State) {
        if let color = titleColor {
            titleColorDict[state] = color
        }
    }
    func setBackgroundColor(backgroundColor: UIColor?, forState state: UIControl.State) {
        if let color = backgroundColor {
            backgroundColorDict[state] = color
        }
    }
    
    func titleColorForState(forState state: UIControl.State) -> UIColor {
        
        let color = titleColorDict[state]
        if color != nil {
            return color!
        } else {
            return titleColorDict[.normal] ?? UIColor.red
        }
    }
    
    func backgroundForState(forState state: UIControl.State) -> UIColor {
        let color = backgroundColorDict[state]
        if color != nil {
            return color!
        } else {
            return backgroundColorDict[.normal] ?? UIColor.red
        }
    }
    
}

class TbActionSheetTableCell: UITableViewCell {
    var contentButton: UIButton = UIButton(type: .custom)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupUI() {
        let line = UIView()
        line.backgroundColor = .red
        self.contentView.addSubview(line)
        
        self.contentView.addSubview(contentButton)
        contentButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

class TbAlertController: UIViewController {

    let actionSheetIdentifier = "actionSheet"
    var textTitle: String
    var textMessage: String
    var preferredStyle: TbPreferredStyle
    
    var contentWidth: CGFloat = kContentWidth
    
    var titleFont: UIFont = .systemFont(ofSize: 17)
    var titleColor: UIColor = .black
    
    var messageFont: UIFont = .systemFont(ofSize: 15)
    var messageColor: UIColor = UIColor(hue: 0.3, saturation: 0.3, brightness: 0.3, alpha: 1.0)
    
    var separatorlLneColor: UIColor = UIColor.lightGray
    
    let bacgroundColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    
    var textContentView: UIView = UIView()
    var textFieldsContentView: UIView = UIView()
    var actionsContentView: UIView = UIView()
    
    // 此模式只针对actionSheet有效，是否有最顶部标题
    let actionSheetHasTopLabel: Bool = false
    
    var cacheHeight:CGFloat = 30
    var backgoundTapDismissEnable:Bool = false {
        didSet {
            singleTap.isEnabled = backgoundTapDismissEnable
        }
    }
    
    var contentViewRadius: CGFloat = 4 {
        didSet {
            contentView.layer.cornerRadius = contentViewRadius
        }
    }
    
    var isShow: Bool = true
    
    let transitonAnimation: TbAlertFadeAnimation = TbAlertFadeAnimation(isPresenting: true)
    
    lazy var backgroundView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return bgView
    }()
    
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 4
        return contentView
    }()
    
    lazy var singleTap: UITapGestureRecognizer = {
        let singleTap = UITapGestureRecognizer(target: self, action:  #selector(singleTap(sender:)))
        singleTap.isEnabled = backgoundTapDismissEnable
        return singleTap
    }()
    
    lazy var sheetTableView: UITableView = {
        let iv = UITableView(frame: .zero, style: .plain)
        iv.backgroundColor = .clear
        iv.dataSource = self
        iv.delegate = self
        iv.register(TbActionSheetTableCell.self, forCellReuseIdentifier: actionSheetIdentifier)
        iv.layer.cornerRadius = 12
        iv.layer.masksToBounds = true
        return iv
    }()
    
    
    var alertActions: [TbAlertAction] = []
    var alertTextFields: [UITextField] = []

    
    init(textTitle: String, message: String, preferredStyle: TbPreferredStyle) {
        self.textTitle = textTitle
        self.textMessage = message
        self.preferredStyle = preferredStyle
        super.init(nibName: nil, bundle: nil)
        
        initDefaultValues()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: 公共 func
    func addAction(action: TbAlertAction) {
        alertActions.append(action)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    
    
    /**
     *  初始化默认值
     */
    func initDefaultValues() {
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    fileprivate func prepareUI() {
        self.view.backgroundColor = .clear
        addBackgroundView()
        addContentView()
        configContentView()
    }
    
    fileprivate func addBackgroundView() {
        self.view.insertSubview(backgroundView, at: 0)
        backgroundView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        addSingleTapGesture()
    }
    
    fileprivate func addContentView() {
        self.view.addSubview(contentView)
    }
    
    func configContentView() {
       
        
        if preferredStyle == .preferredStyleActionSheet  {
            contentView.backgroundColor = .clear
            contentView.snp.makeConstraints { (make) in
                make.width.equalTo(contentWidth)
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                make.centerX.equalTo(self.backgroundView)
            }
            
            contentView.addSubview(sheetTableView)
            sheetTableView.snp.makeConstraints { (make) in
                make.left.right.top.equalToSuperview()
                make.height.equalTo(kActionSheetHeight * CGFloat((alertActions.count - 1)))
            }

            let lastAction = alertActions.last!
            let cancelButton = button(alertAction: lastAction, index: alertActions.count - 1)
            cancelButton.layer.cornerRadius = 12
            cancelButton.layer.masksToBounds = true
            contentView.addSubview(cancelButton)
            
            cancelButton.snp.makeConstraints { (make) in
                make.top.equalTo(sheetTableView.snp_bottom).offset(12)
                make.left.right.equalToSuperview()
                make.height.equalTo(kActionSheetHeight)
                make.bottom.equalToSuperview().offset(-20)
            }
            
            
            
        } else {
            
            contentView.snp.makeConstraints { (make) in
                make.width.equalTo(contentWidth)
                make.center.equalTo(self.view)
            }
            
            contentView.addSubview(textContentView)
            textContentView.snp.makeConstraints { (make) in
                make.top.left.right.equalToSuperview()
            }
            
            contentView.addSubview(textFieldsContentView)
            textFieldsContentView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(textContentView.snp_bottom)
            }
            
            contentView.addSubview(actionsContentView)
            actionsContentView.snp.makeConstraints { (make) in
                make.left.bottom.right.equalToSuperview()
                make.top.equalTo(textFieldsContentView.snp_bottom)
            }
            addTextLabesl()
            addTextFields()
            addActionButtons()
        }
        

    }
    
    func addTextLabesl(){
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        titleLabel.text = self.textTitle
        textContentView.addSubview(titleLabel)
        
        let messageLabel = UILabel()
        messageLabel.font = messageFont
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.textColor = messageColor
        messageLabel.text = textMessage
        textContentView.addSubview(messageLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(textContentView)
            make.left.equalTo(textContentView.snp_left).offset(kHorMargin)
            make.right.equalTo(textContentView.snp_right).offset(-kHorMargin)
            make.top.equalTo(textContentView).offset(31)
            make.bottom.equalTo(textContentView).offset(-30).priorityLow()
        }
        
        if !textMessage.isEmpty {
            messageLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp_bottom).offset(28)
                make.left.equalTo(textContentView).offset(kHorMargin)
                make.right.equalTo(textContentView).offset(-kHorMargin)
                make.bottom.equalTo(textContentView.snp_bottom).offset(-30)

            }
        }
    }
    func addTextFields(){
        var topField: UITextField?
        guard let lastTextField = alertTextFields.last else { return }
        
        for (_, textField) in alertTextFields.enumerated() {
            textContentView.addSubview(textField)
            textField.snp.makeConstraints { (make) in
                make.left.equalTo(textContentView.snp_left).offset(kHorMargin)
                make.right.equalTo(textContentView.snp_right).offset(-kHorMargin)
                make.height.equalTo(cacheHeight)
                
                if let tf = topField {
                    make.top.equalTo(tf.snp_bottom).offset(kTextFieldMargin)
                } else {
                    make.top.equalTo(textContentView)
                }
                
                if lastTextField == textField {
                    make.bottom.equalTo(textContentView).offset(-10)
                }
                
            }
            topField = textField
            
        }
    }
    func addActionButtons(){
        if alertActions.count == 0 {
            return
        }
        
        let topLine = UIView()
        topLine.backgroundColor = separatorlLneColor
        actionsContentView.addSubview(topLine)
        topLine.snp.makeConstraints {
            $0.top.left.right.equalTo(actionsContentView)
            $0.height.equalTo(kseparatorlLneHeight)
        }
        
        if alertActions.count == 1 {
            let alertAction = alertActions.first!
            let alertButton = button(alertAction: alertAction, index: 0)
            actionsContentView.addSubview(alertButton)
            alertButton.snp.makeConstraints { (make) in
                make.top.equalTo(topLine.snp.bottom)
                make.height.equalTo(kActionButtonHeight)
                make.left.bottom.right.equalToSuperview()
            }
            
        } else if(alertActions.count == 2) {
            let firstAlertAction = alertActions.first!
            let secondAlertAction = alertActions.last!
            
            let firstAlertButton = button(alertAction: firstAlertAction, index: 0)
            let secondAlertButton = button(alertAction: secondAlertAction, index: 1)
            
            actionsContentView.addSubview(firstAlertButton)
            actionsContentView.addSubview(secondAlertButton)
            
            let verLine = UIView()
            verLine.backgroundColor = separatorlLneColor
            actionsContentView.addSubview(verLine)
            
            verLine.snp.makeConstraints { (make) in
                make.width.equalTo(kseparatorlLneHeight)
                make.top.equalTo(topLine.snp_bottom)
                make.bottom.centerX.equalToSuperview()
            }
            
            firstAlertButton.snp.makeConstraints { (make) in
                make.left.bottom.equalToSuperview()
                make.top.equalTo(topLine.snp_bottom)
                make.height.equalTo(kActionButtonHeight)
                make.right.equalTo(verLine.snp_left)
                
            }
            secondAlertButton.snp.makeConstraints { (make) in
                make.left.equalTo(verLine.snp_right)
                make.height.equalTo(kActionButtonHeight)
                make.top.equalTo(topLine.snp_bottom)
                make.right.bottom.equalToSuperview()
            }
            
        }

    }
    
    func button(alertAction: TbAlertAction, index: NSInteger) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(alertAction.textTitle, for: .normal)
        button.titleLabel?.font = alertAction.textFont
        button.isUserInteractionEnabled = alertAction.isEnable
        button.tag = index
        button.setTitleColor(alertAction.titleColorForState(forState: .normal), for: .normal)
        button.setTitleColor(alertAction.titleColorForState(forState: .highlighted), for: .highlighted)
        button.setTitleColor(alertAction.titleColorForState(forState: .disabled), for: .disabled)
        let normImage = UIColor.image(alertAction.backgroundForState(forState: .normal))()
        let highImage = UIColor.image(alertAction.backgroundForState(forState: .highlighted))()
        button.setBackgroundImage(normImage, for:.normal)
        button.setBackgroundImage(highImage, for: .highlighted)
        button.addTarget(self, action: #selector(actionButtonClicked(button:)), for: .touchUpInside)
        return button
    }
    
    @objc func actionButtonClicked(button: UIButton){
       let action = alertActions[button.tag]
        dismiss(animated: true, delay: 0) {
            if (action.handler != nil) {
                action.handler!(action)
            }
        }
    }
    
    func addSingleTapGesture() {
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(singleTap)
    }
    
    @objc func singleTap(sender: UITapGestureRecognizer) {
        dismiss(animated: true, delay: 0) {
        }
    }
    
    func dismiss(animated: Bool, delay: TimeInterval, completion: @escaping (()-> Void)) {
        isShow = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            self.dismiss(animated: animated, completion: completion)
        }
       
    }
    
}

extension TbAlertController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertActions.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: actionSheetIdentifier) as! TbActionSheetTableCell
        
        let sheetAction = alertActions[indexPath.row]
        let btn = button(alertAction: sheetAction, index: indexPath.row)
        cell.contentButton.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kActionSheetHeight
    }
    
}

extension TbAlertController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionAnimationWithIsPresenting(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return transitionAnimationWithIsPresenting(isPresenting: false)

    }
    
    func transitionAnimationWithIsPresenting(isPresenting: Bool) -> UIViewControllerAnimatedTransitioning? {
        switch self.transitonAnimation {
        case is TbAlertFadeAnimation:
            return TbAlertFadeAnimation(isPresenting: isPresenting)
            break
        default:
            break
        }
    }

}
