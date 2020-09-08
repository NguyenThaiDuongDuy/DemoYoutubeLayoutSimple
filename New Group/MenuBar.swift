//
//  MenuBar.swift
//  demoLayout
//
//  Created by DuyNTD1 on 7/9/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//
import UIKit

class MenuBar: UIView,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let MenuCellId = "MenuCell"
    let ArrayIconImage = ["Home","Trend","Sub","User"]
    var mHomeViewController:HomeViewController?
    var LeadingConstraint:NSLayoutConstraint?
    var isTap:Bool?
    
    let mBottomMenuBar:UIView = {
        let BottomMenuBar = UIView()
        BottomMenuBar.backgroundColor = .white
        BottomMenuBar.translatesAutoresizingMaskIntoConstraints = false
        return BottomMenuBar
    }()
    
    
    let mCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .red
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(mCollectionView)
        addSubview(mBottomMenuBar)
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.backgroundColor = .red
        backgroundColor = .red
        mCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCellId)
        setUpcontraintForCollectionView()
        let index = IndexPath(item: 0, section: 0)
        mCollectionView.selectItem(at: index, animated: false, scrollPosition: .init())
        
    }
    
    func setUpcontraintForCollectionView() {
        mCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        mBottomMenuBar.topAnchor.constraint(equalTo: mCollectionView.bottomAnchor).isActive = true
        LeadingConstraint = mBottomMenuBar.leadingAnchor.constraint(equalTo:leadingAnchor)
        LeadingConstraint?.isActive = true
        mBottomMenuBar.widthAnchor.constraint(equalTo:widthAnchor, multiplier: 0.25).isActive = true
        mBottomMenuBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        mBottomMenuBar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    //Config Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCellId, for: indexPath) as! MenuCell
        cell.backgroundColor = .red
        cell.mIconMenu.image = UIImage(named: ArrayIconImage[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.frame.width / 4, height: self.frame.height)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.mHomeViewController!.scrolltoIndex(indexPath:indexPath)
        self.mHomeViewController?.titleNaviLabel.text = self.mHomeViewController?.titleNavi[indexPath.row]
    }
    
    func selectItemNum(indexdex:IndexPath) {
        self.mCollectionView.selectItem(at: indexdex, animated: true, scrollPosition:.init())
    }
    
    func setTintImageForCell(index:IndexPath) {
        var cell = MenuCell()
        var indexPath = IndexPath()
        for i in 0...3 {
            indexPath = IndexPath(item: i, section: 0)
            cell = mCollectionView.cellForItem(at:indexPath) as! MenuCell
            if i == index.item {
                cell.mIconMenu.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                cell.mIconMenu.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
        }
        
    }
}

class MenuCell: UICollectionViewCell {
    
    let mIconMenu:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "Home")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            mIconMenu.tintColor = isHighlighted ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            mIconMenu.tintColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(mIconMenu)
        backgroundColor = .red
        mIconMenu.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mIconMenu.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mIconMenu.widthAnchor.constraint(equalToConstant: 27.0).isActive = true
        mIconMenu.heightAnchor.constraint(equalToConstant: 27.0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
