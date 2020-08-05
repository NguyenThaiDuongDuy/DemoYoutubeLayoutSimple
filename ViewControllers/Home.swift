//
//  ViewController.swift
//  demoLayout
//
//  Created by DuyNTD1 on 7/3/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
   
    let cellLarge = "HomeCell"
    let cellTrend = "TrendingCell"
    let cellSub = "SubCell"
    var video:[Video]?
    let titleNavi = ["Home", "Trending", "Sub", "User"]
    var titleNaviLabel = UILabel()
    
    let naviTitle:UIView = {
        let mnaviTitle = UIView.init()
        return mnaviTitle
    }()
    
    
    lazy var mMenubar:MenuBar = {
        let mmenu = MenuBar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 48))
        mmenu.mHomeViewController = self
        return mmenu
    }()
    
    lazy var mSettingView:Settingview = {
        let settingView = Settingview(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        settingView.mTableView.frame.origin.y += 324
        settingView.mHomeViewController = self
        return settingView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupMenuBar()
        setupCollectionView()
        
        collectionView.backgroundColor = UIColor(named: "mBlueColor")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: cellLarge)
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: cellTrend)
        collectionView.register(SubLargeCell.self, forCellWithReuseIdentifier: cellSub)
        self.view.backgroundColor = .yellow
        mSettingView.mShadowView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(mTapShawDowView)))
    }
    
    func setupNavigationBar() {
        titleNaviLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        titleNaviLabel.text = "Home"
        titleNaviLabel.font = UIFont.systemFont(ofSize: 25)
        titleNaviLabel.textColor = .white
        navigationItem.titleView = titleNaviLabel
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        
        //MoreButton
        let mMoreButton = UIBarButtonItem(image: UIImage(named: "More")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(mTapMoreButton))
        
         let mSearchButton = UIBarButtonItem(image: UIImage(named: "Search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(mTapSearchButton))
        
        navigationItem.rightBarButtonItems = [mMoreButton,mSearchButton]
    }
    
    
    @objc func mTapMoreButton() {
        print("mTapMoreButton")
        showSettingViewWithAnimation()
    }
    
    func showSettingViewWithAnimation() {
        if mSettingView.isShow! == false {
            self.navigationController?.view.addSubview(self.mSettingView)
            mSettingView.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.mSettingView.alpha = 1.0
                self.mSettingView.mTableView.frame.origin.y -= 324
            }) { (isFinish) in
                print(isFinish)
                self.mSettingView.isShow? = true
            }
        }
    }
    
    func dissMissSettingViewWithAnimation(nameViewcontroller:String?) {
        if mSettingView.isShow! == true {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.mSettingView.alpha = 0
                self.mSettingView.mTableView.frame.origin.y += 324
            }) { (isFinish) in
                self.mSettingView.removeFromSuperview()
                self.mSettingView.isShow? = false
                guard let nameVc = nameViewcontroller else {
                    return
                }
                self.pushViewController(name: nameVc)
            }
        }
    }
    
    func pushViewController(name:String) {
        let vc = SecondViewController(nibName: "SecondViewController", bundle: nil)
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        vc.mNaviTitle = name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func mTapSearchButton() {
        //self.mMenubar.selectItemNum(indexdex: IndexPath(item: 2, section: 0))
        print("mSearchButton")
    }
    
    @objc func mTapShawDowView() {
        dissMissSettingViewWithAnimation(nameViewcontroller: nil)
    }
    
    func setupMenuBar() {
        //navigationController?.hidesBarsOnSwipe = true
        let mview = UIView()
        mview.translatesAutoresizingMaskIntoConstraints = false
        mview.backgroundColor = .red
        view.addSubview(mview)
        view.addSubview(mMenubar)
        
       
        
        mview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mview.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        mMenubar.translatesAutoresizingMaskIntoConstraints = false
        mMenubar.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        mMenubar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mMenubar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mMenubar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        let views: [String: Any] = [
            "collection": collectionView!,
            "menuViews": mMenubar]
        let constraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collection]-0-|", options: .alignAllTop, metrics: nil, views: views as [String : Any])
        let constraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[menuViews]-0-[collection]-0-|", options: .init(), metrics: nil, views: views as [String : Any])

        NSLayoutConstraint.activate(constraintsH)
        NSLayoutConstraint.activate(constraintsV)
//        self.view.addConstraints(constraintsH)
        self.view.addConstraints(constraintsV)
        //self.collectionView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellLarge, for: indexPath) as! HomeCell
        } else if (indexPath.item == 1) {
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellTrend, for: indexPath) as! TrendingCell
        } else if (indexPath.item == 2) {
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellSub, for: indexPath) as! SubLargeCell
        } else {
            
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellLarge, for: indexPath) as! HomeCell
        
    }
    
    func scrolltoIndex(indexPath: IndexPath) {
        self.collectionView.scrollToItem(at: indexPath, at: .init(), animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height-44)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.mMenubar.LeadingConstraint?.constant = scrollView.contentOffset.x/4
        }) { (isDone) in
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = round(scrollView.contentOffset.x / self.view.frame.width)
        titleNaviLabel.text = titleNavi[Int(x)]
        let index = IndexPath(item: Int(x), section: 0)
        self.mMenubar.mCollectionView.selectItem(at: index, animated: true, scrollPosition: .init())
    }
}




