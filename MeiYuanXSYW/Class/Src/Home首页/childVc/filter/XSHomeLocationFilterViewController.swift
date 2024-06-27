//
//  XSHomeFilterViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/9.
//

import UIKit

class XSHomeLocationFilterViewController: XSBaseViewController {
    
    let leftTitles = ["附近","商圈","地铁"]
    let rightTitles = ["1km","1km","1km"]
    
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var centerTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
    var isTwoStepFilter: Bool = false
    
    @IBOutlet weak var centerTableViewW: NSLayoutConstraint!
        
    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = UIColor.white

        self.centerTableView.isHidden = true
        self.rightTableView.isHidden = true
        
        leftTableView.register(cellType: XSSelectMenuTableViewCell.self)
        centerTableView.register(cellType: XSSelectMenuTableViewCell.self)
        rightTableView.register(cellType: XSSelectMenuTableViewCell.self)
    
        
        updateToTwoFilter()
    }
    
    init(isTwoStepFilter: Bool) {
        self.isTwoStepFilter = isTwoStepFilter
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateToTwoFilter(){
        if isTwoStepFilter {
            self.centerTableViewW.constant = 0
            self.centerTableView.isHidden = true
        }
    }
}

extension XSHomeLocationFilterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === leftTableView {
            return leftTitles.count
        } else if(tableView == centerTableView) {
            return leftTitles.count
        }
        return rightTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView === leftTableView {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSSelectMenuTableViewCell.self)
            cell.textLabel?.text = leftTitles[indexPath.row]
            return cell
        } else if (tableView === centerTableView) {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSSelectMenuTableViewCell.self)
            cell.textLabel?.text = leftTitles[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: XSSelectMenuTableViewCell.self)
            cell.textLabel?.text = rightTitles[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView === leftTableView {
            if self.isTwoStepFilter {
                self.rightTableView.isHidden = false
                self.rightTableView.reloadData()
            } else {
                self.centerTableView.isHidden = false
                self.centerTableView.reloadData()
            }
           
        } else if(tableView == centerTableView) {
            if self.isTwoStepFilter {
                let cell = tableView.cellForRow(at: indexPath)
                cell?.isSelected = !cell!.isSelected
                cell?.accessoryView = cell!.isSelected ? UIImageView(image: #imageLiteral(resourceName: "mine_tick_selected")) : nil
                NotificationCenter.default.post(name: NSNotification.Name.XSUpdateMenuTitleNotification, object: nil)
                
            } else {
                self.rightTableView.isHidden = false
                self.rightTableView.reloadData()

            }
        } else {
            let cell = tableView.cellForRow(at: indexPath)
            cell?.isSelected = !cell!.isSelected
            cell?.accessoryView = cell!.isSelected ? UIImageView(image: #imageLiteral(resourceName: "mine_tick_selected")) : nil
            NotificationCenter.default.post(name: NSNotification.Name.XSUpdateMenuTitleNotification, object: nil)
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = !cell!.isSelected
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    
}

