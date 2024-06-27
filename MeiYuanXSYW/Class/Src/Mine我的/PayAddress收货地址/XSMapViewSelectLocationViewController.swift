//
//  XSMapViewSelectLocationViewController.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/12.
//

import UIKit
import MAMapKit
import AMapFoundationKit
import AMapSearchKit

class XSMapViewSelectLocationViewController: XSBaseViewController {

    var mapView: MAMapView!
    var customUserLocationView: MAAnnotationView!
    var search: AMapSearchAPI!
    var gpsButton: UIButton!

    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    var searchLocationModels = [CLReceiverAddressModel]()
    
    
    var selectLocationCompleteBlock: ((_ locationModel: CLReceiverAddressModel) -> Void)?
    
    private lazy var addressTableView: TBBaseTableView = {
        let table = TBBaseTableView(frame: .zero, style: .plain)
        table.register(cellType: TBHomeResultLocationTableViewCell.self)
//        table.register(cellType: XSBaseTableViewCell.self)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    lazy var searchTextField: TBSearchTextField = {
        let search = TBSearchTextField()
        search.searchDelegate = self
        search.placeholderText = "搜索地点"
        return search
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 开启定位
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSearch()
        initMapView()
    }
    
    func initSearch() {
        search = AMapSearchAPI()
        search.delegate = self
    }
    
    func makeGPSButtonView() -> UIButton! {
        let ret = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        ret.backgroundColor = UIColor.white
        ret.layer.cornerRadius = 4
        
        ret.setImage(UIImage.init(named: "gpsStat1"), for: .normal)
        ret.addTarget(self, action: #selector(self.gpsAction), for: .touchUpInside)
        
        return ret
    }
    
    func initMapView() {
        // 不知道为啥地图要包一层，否则底部有白边。。。
        let backView = UIView()
        ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
        AMapServices.shared().enableHTTPS = true
        mapView = MAMapView(frame: backView.bounds)
        mapView.zoomLevel = 16
        mapView.delegate = self
        //mapView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        self.view.addSubview(backView)
        
        backView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(322)
        }
        
        backView.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        
        self.view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(backView.snp_bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        //searchTextField.frame = CGRect(x: 10, y: backView.tb_bottom + 15, width: screenWidth - 20, height: 30)
        
        self.view.addSubview(addressTableView)
        addressTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp_bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.view.usnp.bottom)
        }
        
        let annotation = UIImage(named: "homePage_wholeAnchor_24x37_")
        let imageView = UIImageView(image: annotation)
        backView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 37))
        }
        
        gpsButton = self.makeGPSButtonView()
        backView.addSubview(gpsButton)
        gpsButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.bottom.equalToSuperview().offset(-20)
            make.right.equalToSuperview().offset(-20)
        }
        
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
        request.location = AMapGeoPoint.location(withLatitude: self.latitude, longitude: self.longitude)
        search.aMapReGoecodeSearch(request)
    }
    
    //定位按钮点击
    @objc func gpsAction() {
        if(self.mapView.userLocation.isUpdating && self.mapView.userLocation.location != nil) {
            self.mapView.setCenter(self.mapView.userLocation.location.coordinate, animated: true)
            self.gpsButton.isSelected = true
        }
    }
    
}

// MARK: - UITableViewDataSource&UITableViewDelegate
extension XSMapViewSelectLocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchLocationModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBHomeResultLocationTableViewCell.self)
        let searchModel = self.searchLocationModels[indexPath.row]
        cell.nameLab.text = searchModel.name;
        cell.detailAddressLab.text = searchModel.receiverDetailAddress
        cell.distanceLab.text = searchModel.distance
        
        cell.accessoryType = searchModel.isSelect ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let searchModel = self.searchLocationModels[indexPath.row]
        if let selectLocationCompleteBlock = selectLocationCompleteBlock {
            selectLocationCompleteBlock(searchModel)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension XSMapViewSelectLocationViewController: TBSearchTextFieldDelegate {
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
            searchPoiByCenterCoordinate(keywords:text)
        } else {
            
        }
    }
}



// MARK: - MAMapViewDelegate
extension XSMapViewSelectLocationViewController: MAMapViewDelegate {

    func mapViewRequireLocationAuth(_ locationManager: CLLocationManager!) {
        locationManager.requestAlwaysAuthorization()
    }
    
    /**
     * @brief 位置或者设备方向更新后，会调用此函数
     * @param mapView 地图View
     * @param userLocation 用户定位信息(包括位置与设备方向等数据)
     * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
     */
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        if updatingLocation {
            let coordinate = userLocation.location.coordinate
            uLog(coordinate.latitude)
            uLog(coordinate.longitude)
            self.latitude = coordinate.latitude
            self.longitude = coordinate.longitude
            self.mapView.setCenter(coordinate, animated: true)

        }
    }
    
    func mapView(_ mapView: MAMapView!, regionDidChangeAnimated animated: Bool) {

        let centerCoordinate = mapView.region.center
        self.latitude = centerCoordinate.latitude
        self.longitude = centerCoordinate.longitude
        geocoderSearch()

        
        self.mapView.setCenter(centerCoordinate, animated: true)



    }
    

}

// MARK: - AMapSearchDelegate
extension XSMapViewSelectLocationViewController: AMapSearchDelegate {
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        let nsErr:NSError? = error as NSError
        uLog(nsErr?.localizedDescription)
        XSTipsHUD.hideAllTips()
        XSTipsHUD.showError("获取周边POPI失败!")
    }
    
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
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
            self.searchLocationModels = POIAddressArray
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
                let province  = aPOI.province ?? ""
                let city  = aPOI.city ?? ""
                let district  = aPOI.district ?? ""

                let lng = aPOI.location.longitude
                let receiverDetailAddress = aPOI.address ?? ""
                let distance = "\(aPOI.distance)m"
                let name = aPOI.name ?? ""

                let address = CLReceiverAddressModel(lat: lat, lng: lng, distance: distance, name: name ,receiverDetailAddress: receiverDetailAddress,
                    province:province,city: city, district: district)
                POIAddressArray.append(address)
            }
//            if resultAddressTable.isHidden { // 推荐附近地址,无参数搜索
//                self.models.append(POIAddressArray)
//                self.addressTableView.reloadData()
//            } else { // 搜索关键字
                self.searchLocationModels = POIAddressArray
                self.addressTableView.reloadData()
//            }
            
        }

    }
    
}
