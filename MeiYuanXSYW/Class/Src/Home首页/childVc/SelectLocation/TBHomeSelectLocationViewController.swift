//
//  TBHomeSelectLocationViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/19.
//

import UIKit
import QMUIKit
import SwiftyJSON
import AMapSearchKit

class TBHomeSelectLocationViewController: XSBaseViewController {

    var models = [[CLReceiverAddressModel]]()
    var searchLocationModels = [CLReceiverAddressModel]()


    let sectionTitles = ["我的收获地址", "附近地址"]
    
    var search: AMapSearchAPI!

    var didSelectAddressBlock: (() -> Void)?
    
    lazy var leftBtn : QMUIButton = {
        let arrowBtn = QMUIButton(type: .custom)
        arrowBtn.imagePosition = QMUIButtonImagePosition.left
        arrowBtn.setImage(UIImage(named: "home_location"), for: .normal)
        arrowBtn.setTitle("深圳", for: UIControl.State.normal)
        arrowBtn.setTitleColor(.text, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYFont(size: 14)
        //arrowBtn.addTarget(self, action: #selector(clickAddAction), for: .touchUpInside)
        return arrowBtn
    }()
    
    lazy var refreshLocationBtn : QMUIButton = {
        let arrowBtn = QMUIButton(type: .custom)
        arrowBtn.imagePosition = QMUIButtonImagePosition.left
        arrowBtn.setImage(UIImage(named: "home_location"), for: .normal)
        arrowBtn.setTitle("重新定位", for: UIControl.State.normal)
        arrowBtn.setTitleColor(.text, for: UIControl.State.normal)
        arrowBtn.titleLabel?.font = MYFont(size: 14)
        arrowBtn.addTarget(self, action: #selector(startLocation), for: .touchUpInside)
        return arrowBtn
    }()
    
    lazy var addressNameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .text
        lb.font = MYFont(size: 14)
        lb.text = "城市天地广场"
        return lb
    }()
    
    lazy var searchTextField: TBSearchTextField = {
        let search = TBSearchTextField()
        search.searchDelegate = self
        search.placeholderText = "请输入收货地址"
        return search
    }()
    
    lazy var addressTableView: TBBaseTableView = {
        let table = TBBaseTableView(frame: .zero, style: .plain)
        table.register(cellType: TBHomeSelectLocationMoreTableViewCell.self)
        table.register(cellType: TBHomeSelectLocationTableViewCell.self)
        table.register(cellType: XSBaseTableViewCell.self)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    lazy var resultAddressTable: TBBaseTableView = {
        let table = TBBaseTableView(frame: .zero, style: .plain)
        table.register(cellType: TBHomeResultLocationTableViewCell.self)
        table.dataSource = self
        table.delegate = self
        table.isHidden = true
        return table
    }()
    

    lazy var searchView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
    
        container.addSubview(searchTextField)
        searchTextField.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(15)
            $0.size.equalTo(CGSize(width: FMScreenScaleFrom(258), height: 30))
        }
        
        container.addSubview(leftBtn)
        leftBtn.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 64, height: 22))
            $0.left.equalToSuperview().offset(10)
            $0.centerY.equalTo(searchTextField)
        }
        
        return container
    }()
    
    lazy var locationView: UIView = {
        let iv = UIView()
        iv.backgroundColor = .white
        let topLine = UIView()
        topLine.backgroundColor = UIColor.hex(hexString: "#E5E5E5")
        iv.addSubview(topLine)
        topLine.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        iv.addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        iv.addSubview(addressNameLabel)
        addressNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        iv.addSubview(refreshLocationBtn)
        refreshLocationBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(24)
            make.width.equalTo(140)
            make.centerY.equalToSuperview()
        }
        
        return iv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAddressData()
        
        let cityStr = UserDefaults.standard.string(forKey: kCurrCityStr)
        addressNameLabel.text = cityStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        initSearch()
    
    }
    
    override func initSubviews() {
        navigationTitle = "位置选择"
        
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints {
            $0.top.left.right.equalTo(self.view)
            $0.height.equalTo(60)
        }
        
        self.view.addSubview(locationView)
        locationView.snp.makeConstraints {
            $0.left.right.equalTo(self.view)
            $0.top.equalTo(searchView.snp_bottom).offset(0)
            $0.height.equalTo(50)
        }
        
        self.view.addSubview(addressTableView)
        addressTableView.snp.makeConstraints {
            $0.edges.equalTo(self.view).inset(UIEdgeInsets(top: 110, left: 10, bottom: bottomInset, right: 10))
        }
        
        self.view.addSubview(resultAddressTable)
        resultAddressTable.snp.makeConstraints {
            $0.edges.equalTo(addressTableView).inset(UIEdgeInsets.zero)
        }
        
        addressTableView.uempty = UEmptyView(description: "还没有收货地址")
        addressTableView.uempty?.emptyState = .noDataState
        addressTableView.uempty?.allowShow = true
        
    }
    
    override func setupNavigationItems() {
        super.setupNavigationItems()
        let buttonItem = UIBarButtonItem(title: "新增地址", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addAddress))
        buttonItem.tintColor = .king
        self.navigationItem.rightBarButtonItem = buttonItem
        /// 消除导航栏的横线
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func initSearch() {
        search = AMapSearchAPI()
        search.delegate = self
    }
        
    private func searchPoiByCenterCoordinate(keywords: String = "") {
                
        let request = AMapPOIAroundSearchRequest()
        let latitude = XSAuthManager.shared.latitude
        let longitude = XSAuthManager.shared.longitude
        request.keywords = keywords
        request.types = "写字楼|学校|公寓|生活服务|风景名胜|公司企业|政府机构及社会团体"
        /* 按照距离排序. */
        request.sortrule = 0
        request.requireExtension = true
        request.location = AMapGeoPoint.location(withLatitude: latitude, longitude: longitude)
        search?.aMapPOIAroundSearch(request)

    }
    
    private func geocoderSearch() {
        let request = AMapReGeocodeSearchRequest()
        request.requireExtension = true
        request.location = AMapGeoPoint.location(withLatitude: XSAuthManager.shared.latitude, longitude: XSAuthManager.shared.longitude)
        search.aMapReGoecodeSearch(request)
    }
    
   @objc private func startLocation() {
       XSTipsHUD.showLoading("正在定位", inView: self.view)
        XSLocationManager.manager.startLocation { location in
            print(location)
            if let loc = location.first?.coordinate {
              let long =  loc.longitude
              let lat  =  loc.latitude
                //uLog(long, lat)
                XSAuthManager.shared.latitude = lat
                XSAuthManager.shared.longitude = long
                UserDefaults.standard.set(lat, forKey: kLatitude)
                UserDefaults.standard.set(long, forKey: kLongitude)

            }

        } failureBlock: { error in
            print(error.localizedDescription)
        }
    
    geocoderBlock: { geocoderArray in
        //uLog(geocoderArray)
        XSTipsHUD.hideAllTips(inView: self.view)
            if let geocoder =  geocoderArray?.first {
                //let name = geocoder.name
                if let thoroughfare = geocoder.thoroughfare {
                    uLog("thoroughfare name\(thoroughfare)")
                    XSAuthManager.shared.currCityStr = thoroughfare
                    UserDefaults.standard.set(thoroughfare, forKey: kCurrCityStr)

                    DispatchQueue.main.async {
                        self.addressNameLabel.text = thoroughfare
                    }
                }

            }

        }
    }
    
    func setupMapSearch(search text: String) {
        searchPoiByCenterCoordinate(keywords: text)
        
    }
    
    @objc func addAddress(){
        self.navigationController?.pushViewController(XSPayAddressEditViewController(addressId: nil), animated: true)
    }
    
}


// MARK: - AMapSearchDelegate
extension TBHomeSelectLocationViewController: AMapSearchDelegate {
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        let nsErr:NSError? = error as NSError
        uLog(nsErr?.localizedDescription)
        XSTipsHUD.hideAllTips()
        XSTipsHUD.showError("获取周边POPI失败!")
    }
    // 推荐附近地址,无参数搜索
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        XSTipsHUD.hideAllTips()

        if response.regeocode == nil {
            return
        }
        
        if let poisArray = response.regeocode.pois {
            var POIAddressArray = [CLReceiverAddressModel]()
            for aPOI in poisArray {
                let lat = aPOI.location.latitude
                let lng = aPOI.location.longitude
                let receiverDetailAddress = aPOI.address ?? ""
                let distance = "\(aPOI.distance)m"
                let name = aPOI.name ?? ""
                
                let province  = aPOI.province ?? ""
                let city  = aPOI.city ?? ""
                let district  = aPOI.district ?? ""

                let address = CLReceiverAddressModel(lat: lat, lng: lng, distance: distance, name: name ,receiverDetailAddress: receiverDetailAddress,
                    province:province,city: city, district: district)
                POIAddressArray.append(address)
            }
            self.models.append(POIAddressArray)
            self.addressTableView.reloadData()
        }
        
    }
    
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        XSTipsHUD.hideAllTips()

        if response.count == 0 {
            return
        }
        
        uLog(response.pois)
        if let poisArray = response.pois {
            var POIAddressArray = [CLReceiverAddressModel]()
            for aPOI in poisArray {
                let lat = aPOI.location.latitude
                let lng = aPOI.location.longitude
                let receiverDetailAddress = aPOI.address ?? ""
                let distance = "\(aPOI.distance)m"
                let name = aPOI.name ?? ""

                let address = CLReceiverAddressModel(lat: lat, lng: lng, distance: distance, name: name ,receiverDetailAddress: receiverDetailAddress)
                POIAddressArray.append(address)
            }
             // 搜索关键字
                self.searchLocationModels = POIAddressArray
                self.resultAddressTable.reloadData()            
        }

    }
    
}

// MARK: - httpRequest
extension TBHomeSelectLocationViewController {
    func loadAddressData() {
       XSTipsHUD.showLoading("", inView: self.view)
                 
       let dic :[String:Any] = [:]
       myOrderProvider.request(MyOrderService.getReceiverAddress(dic)) { result in

           switch result {
           case let .success(response):
               guard let jsonData = try? JSON(data: response.data) else {
                   return
               }
               
               if  jsonData["resp_code"].intValue == 0{
                   
                   DispatchQueue.main.async {
                       self.models.removeAll()
                       
                       let addressModels = jsonData["data"].arrayValue.compactMap{
                           return CLReceiverAddressModel.init(jsonData: $0)
                       }
                       self.models.append(addressModels)
                       self.geocoderSearch()
                   }
                   

                   
                   
               }else{
                   XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
               }

            case let .failure(_):
               //网络连接失败，提示用户
               XSTipsHUD.hideAllTips()
               XSTipsHUD.showText("网络连接失败")
               
           }
       }
   }
}

extension TBHomeSelectLocationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == addressTableView {
            return self.models.count
        }
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == addressTableView {
            let sectionModel = self.models[section]
            return sectionModel.count
        }
        return searchLocationModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == addressTableView {
            if indexPath.section == 0 {
                return 60
            }
            return 40
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == resultAddressTable {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeResultLocationTableViewCell.self)
            let searchModel = self.searchLocationModels[indexPath.row]
            cell.nameLab.text = searchModel.name;
            cell.detailAddressLab.text = searchModel.receiverDetailAddress
            cell.distanceLab.text = searchModel.distance
            
            return cell
        }
        
        
        let section = self.models[indexPath.section]
        let rowModel = section[indexPath.row]
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeSelectLocationTableViewCell.self)
            cell.model = rowModel
            
            if indexPath.row == 0 {
                cell.contentView.jk.addCorner(conrners: [.topLeft, .topRight], radius: 10)
            } else if indexPath.row == section.count - 1 {
                cell.contentView.jk.addCorner(conrners: [.bottomLeft, .bottomRight], radius: 10)
                let _ = cell.contentView.subviews.map { iv in
                    if iv.tag == 1314 {
                        iv.isHidden = true
                    }
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
            cell.textLabel?.textColor = .text
            cell.textLabel?.font = MYBlodFont(size: 14)
            cell.textLabel?.text = rowModel.receiverDetailAddress
            cell.addLine(frame: CGRect(x: 10, y: cell.frame.height-1, width: cell.frame.width-20, height: 1), color: UIColor.hex(hexString: "#DCDEE0"))
            
            if indexPath.row == 0 {
                cell.contentView.jk.addCorner(conrners: [.topLeft, .topRight], radius: 10)
            } else if indexPath.row == section.count - 1 {
                cell.contentView.jk.addCorner(conrners: [.bottomLeft, .bottomRight], radius: 10)
                let _ = cell.contentView.subviews.map { iv in
                    if iv.tag == 1314 {
                        iv.isHidden = true
                    }
                }
            }
            return cell
        }
        
        return UITableViewCell()
        
//        if indexPath.section == 0 {
//            if indexPath.row == 4 {
//                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeSelectLocationMoreTableViewCell.self)
//                cell.contentView.jk.addCorner(conrners: [.bottomLeft, .bottomRight], radius: 10)
//                return cell
//            } else {
//                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeSelectLocationTableViewCell.self)
//                if indexPath.row == 0 {
//                    cell.contentView.jk.addCorner(conrners: [.topLeft, .topRight], radius: 10)
//                }
//                return cell
//            }
//        } else {
//            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSBaseTableViewCell.self)
//            cell.textLabel?.textColor = .text
//            cell.textLabel?.font = MYBlodFont(size: 14)
//            cell.textLabel?.text = "城市天地广场东座6楼6026"
//            cell.addLine(frame: CGRect(x: 10, y: cell.frame.height-1, width: cell.frame.width-20, height: 1), color: UIColor.hex(hexString: "#DCDEE0"))
//
//
//            if indexPath.row == 4 {
//                cell.contentView.jk.addCorner(conrners: [.bottomLeft, .bottomRight], radius: 10)
//                let _ = cell.contentView.subviews.map { iv in
//                    if iv.tag == 1314 {
//                        iv.isHidden = true
//                    }
//                }
//            } else if (indexPath.row == 0){
//                cell.contentView.jk.addCorner(conrners: [.topLeft, .topRight], radius: 10)
//            }
//            return cell
       // }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var model: CLReceiverAddressModel?
        
        if tableView == addressTableView {
            let section = self.models[indexPath.section]
            model = section[indexPath.row]
        } else {
            model = self.searchLocationModels[indexPath.row]
        }
        
        guard let model = model else { return }
        
        UserDefaults.standard.set(model.lat, forKey: kLatitude)
        UserDefaults.standard.set(model.lng, forKey: kLongitude)
        UserDefaults.standard.set(model.receiverDetailAddress, forKey: kCurrCityStr)
        
        XSAuthManager.shared.longitude = model.lng
        XSAuthManager.shared.latitude  = model.lat
        
        self.navigationController?.popViewController(animated: true)
        
        didSelectAddressBlock?()
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView == resultAddressTable ? 0.001 : 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == addressTableView {
            let iv = UIView()
            iv.backgroundColor = .background
            iv.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44)
            
            let icon = UIImageView(image: UIImage(named: "home_location_edit"))
            iv.addSubview(icon)
            icon.frame = CGRect(x: 10, y: 17, width: 20, height: 20)
            
            let titleLab = UILabel(frame: CGRect(x: icon.tb_maxX + 10, y: 17, width: 100, height: 24))
            titleLab.text = sectionTitles[section]
            titleLab.textColor = .text
            titleLab.font = MYFont(size: 14)
            iv.addSubview(titleLab)
            return iv
        } else {
            return UIView()
        }
       
    }

}

// MARK: - TBSearchTextFieldDelegate

extension TBHomeSelectLocationViewController: TBSearchTextFieldDelegate {
    func searchTextFieldDidTextChange(textField: TBSearchTextField) {
        guard let text = textField.text else { return }
        searchTextField(text: text)
    }
    
    func searchTextFieldDidBeginEditing(textField: TBSearchTextField) {
    }
    
    func searchTextFieldDidClickSearchBtn(textField: TBSearchTextField) {
        guard let text = textField.text else { return }
        searchTextField(text: text)
    }
    
    private func searchTextField(text: String) {
        if text.count > 0 {
            resultAddressTable.isHidden = false
            addressTableView.isHidden = true
            setupMapSearch(search: text)
        } else {
            resultAddressTable.isHidden = true
            addressTableView.isHidden = false
        }
    }
}
