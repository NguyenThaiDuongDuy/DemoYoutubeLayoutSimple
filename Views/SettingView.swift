//
//  SettingView.swift
//  demoLayout
//
//  Created by DuyNTD1 on 7/14/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import Foundation
import UIKit

class Settingview:UIView, UITableViewDelegate,UITableViewDataSource{
    let CellName = "SettingCell"
    var mHomeViewController:HomeViewController?
    var isShow:Bool?
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mShadowView: UIView!
    
    
    
    var mSettingDataArray:[SettingData]?
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibFile()
        mTableView.register(UINib.init(nibName: CellName, bundle: nil), forCellReuseIdentifier: CellName)
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.backgroundColor = .systemPink
        mTableView.translatesAutoresizingMaskIntoConstraints = false
        mTableView.heightAnchor.constraint(equalToConstant: 324).isActive = true
        mTableView.separatorStyle = .none
        self.frame = frame

        let SettingObject = SettingData.init(NameIcon: "Setting", NameLabel: .Setting)
        let PrivacyObject = SettingData.init(NameIcon: "Privacy", NameLabel: .Privacy)
        let FeedBackObject = SettingData.init(NameIcon: "FeedBack", NameLabel: .FeedBack)
        let AccountObject = SettingData.init(NameIcon: "Account", NameLabel: .Account)
        let HelpObject = SettingData.init(NameIcon: "Help", NameLabel: .Help)
        let CancelObject = SettingData.init(NameIcon: "Cancel", NameLabel: .Cancel)
        
        
        mSettingDataArray = [SettingObject,PrivacyObject,FeedBackObject,AccountObject,HelpObject,CancelObject]
        isShow = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadNibFile() {
        let view = Bundle.main.loadNibNamed("SettingView", owner: self, options: nil)![0] as? UIView
        if let mview = view {
            mview.frame = frame
            self.addSubview(mview)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mSettingDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellName, for: indexPath) as! SettingCell
        cell.SettingData = mSettingDataArray![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if let name = mSettingDataArray?[indexPath.row].nameLabel!.rawValue {
              self.mHomeViewController?.dissMissSettingViewWithAnimation(nameViewcontroller:name)
        }
    }
}
