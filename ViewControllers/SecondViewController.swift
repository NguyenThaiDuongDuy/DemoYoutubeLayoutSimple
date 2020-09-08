//
//  SecondViewController.swift
//  demoLayout
//
//  Created by DuyNTD1 on 7/15/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var titleNavigationBar:String?
    var backTitleButton:String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem!.title = backTitleButton
        self.navigationItem.title = titleNavigationBar
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
