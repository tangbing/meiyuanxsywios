//
//  TBMerchinfoLicenseViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/30.
//

import UIKit


struct TbLicenseModel {
    let sectionTitle: String
    let licenses: [String]
}

class TBMerchinfoLicenseViewController: XSBaseTableViewController, UITableViewDataSource, UITableViewDelegate {
   
    var licenseModes = [TbLicenseModel]()
    var dataModels: TBDelieveMerchatInfoModel?  {
        didSet {
            guard let model = dataModels else {
                return
            }
            
            if let merchantLicense = model.merchantLicense {
                let license = TbLicenseModel(sectionTitle: "营业执照", licenses: merchantLicense)
                licenseModes.append(license)
            }
            
            if let foodLicense = model.foodLicense {
                let food = TbLicenseModel(sectionTitle: "营业执照", licenses: foodLicense)
                licenseModes.append(food)
            }
            tableView.reloadData()
            
        }
    }

    override func setupNavigationItems() {
        super.setupNavigationItems()
        navigationTitle = "商家资质"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: TBMerchinfoLicenseTableViewCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return licenseModes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = licenseModes[section]
        return model.licenses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TBMerchinfoLicenseTableViewCell.self)
        let model = licenseModes[indexPath.section]
        let licenseUrl = model.licenses[indexPath.row]
        cell.licenseImageView.xs_setImage(urlString: licenseUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let iv = UIView()
        iv.backgroundColor = UIColor.background
        
        let label = UILabel()
        label.textColor = .text
        label.font = MYBlodFont(size: 16)
        
        let model = licenseModes[section]
        label.text = model.sectionTitle

        iv.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        return iv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    
    
    


}
