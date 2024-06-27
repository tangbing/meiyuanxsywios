
# Uncomment this line to define a global platform for your project
platform :ios, '12.0'

inhibit_all_warnings!

# Comment this line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!


def thirdParty

#pod 'Alamofire'
pod 'Moya'
pod 'SwiftyJSON'
pod 'HandyJSON'
pod 'IQKeyboardManagerSwift'
pod 'EmptyDataSet-Swift'
pod 'JXSegmentedView'
pod 'HMSegmentedControl', '~> 1.0'  

pod 'Reusable'

pod 'SVProgressHUD', '~> 2.2.5'

pod 'BRPickerView'

pod 'SnapKit', '~> 4.2.0'
pod 'MJRefresh'
pod 'Kingfisher', '~> 7.1.2'

pod 'QMUIKit', '~> 4.3.0'

pod 'JKSwiftExtension', '~> 2.0.6'

#pod 'LLCycleScrollView'
pod 'YZPullDownMenu'


pod 'FSPagerView'
pod 'Presentr'
pod 'KeychainAccess', '~> 4.2.0'

pod 'GKNavigationBarSwift','~> 1.3.2'
pod 'GKPageScrollView/Swift', '~> 1.6.9'
pod 'GKPageSmoothView/Swift', '~> 1.6.9'

#pod 'Bugly'

pod 'AMapLocation'
pod 'AMap3DMap'
pod 'AMapSearch'


post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
        end
    end
end


end


def project

end

def debug

pod 'LookinServer', :configurations => ['Debug']

end


target 'MeiYuanXSYW' do

thirdParty
debug
end
