//
//  AppDelegate.swift
//  fristios
//
//  Created by admin on 2021/8/2.
//

import UIKit
import AMapFoundationKit
import MAMapKit
//import Bugly


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        

        
        DispatchQueue.main.async {
            AMapServices.shared().apiKey = gaodeMapAPI
            MAMapView.updatePrivacyAgree(AMapPrivacyAgreeStatus.didAgree)
            //更新App是否显示隐私弹窗的状态，隐私弹窗是否包含高德SDK隐私协议内容的状态. since 8.1.0
            MAMapView.updatePrivacyShow(AMapPrivacyShowStatus.didShow, privacyInfo: AMapPrivacyInfoStatus.didContain)
            
            
           self.setupWindowRootVc()
            
        }

            guard let currCityStr = UserDefaults.standard.string(forKey: kCurrCityStr) else {
                self.startLocation()
                return true
            }
            print("currCityStr:\(currCityStr)")
         
        
        print("main.....")

      
        
      
        
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        Bugly.start(withAppId:.buglyAppid)
        
        ThirdLibsManager.shared.setup()
        
        return true
    }
    
    private func setupWindowRootVc() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = XSTabBarController()
        window?.makeKeyAndVisible()
    }

}

extension AppDelegate {
    private func startLocation() {
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
            if let geocoder =  geocoderArray?.first {
                //let name = geocoder.name
                if let thoroughfare = geocoder.thoroughfare {
//                    CLPlacemark *placeMark = placemarks[0];
//                   YMLog(@"当前用户所在城市：%@",placeMark.locality);
//                   YMLog(@"%@",placeMark.country);//当前国家
//                   YMLog(@"%@",placeMark.locality);//当前城市
//                   YMLog(@"%@",placeMark.subLocality);//当前位置
//                   YMLog(@"%@",placeMark.thoroughfare)//当前街道
//                   YMLog(@"%@",placeMark.name);//具体地址  市  区  街道
//
//                   NSString *address = [NSString stringWithFormat:@"%@%@%@",placeMark.locality,placeMark.subLocality,placeMark.name];
//                   YMLog(@"%@",address);
//                   [AppSingleInstance sharedInstance].currentUserAddress = address;

                    uLog("thoroughfare name\(thoroughfare)")
                    XSAuthManager.shared.currCityStr = thoroughfare
                    UserDefaults.standard.set(thoroughfare, forKey: kCurrCityStr)
                    NotificationCenter.default.post(name: NSNotification.Name.XSUpdateLocationNotification, object: nil)
                }
                //uLog("address name\(name ?? "")" + )

            }

        }
    }
}

