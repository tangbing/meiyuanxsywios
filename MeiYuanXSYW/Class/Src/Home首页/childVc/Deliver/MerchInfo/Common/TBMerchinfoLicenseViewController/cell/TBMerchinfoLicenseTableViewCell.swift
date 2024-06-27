//
//  TBMerchinfoLicenseTableViewCell.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/30.
//

import UIKit

class TBMerchinfoLicenseTableViewCell: XSBaseTableViewCell {

    lazy var licenseImageView: UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()

    override func configUI() {
        super.configUI()
        contentView.backgroundColor = UIColor.background

        self.contentView.addSubview(licenseImageView)
        licenseImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 450))
            make.top.bottom.equalToSuperview()
        }
    }

}
