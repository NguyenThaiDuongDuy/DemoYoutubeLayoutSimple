//
//  LargeCellwWthClass.swift
//  demoLayout
//
//  Created by DuyNguyen on 7/25/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell,UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellName = "VideoCell"
    var video: [Video]?
    
    let mCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = .vertical
        let mCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        return mCollectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        self.backgroundColor = .green
        setUpCollectionView()
        fetchVideos()
    }
    
    func setUpCollectionView() {
        mCollectionView.register(UINib.init(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        mCollectionView.contentInsetAdjustmentBehavior = .never
        self.widthAnchor.constraint(equalToConstant: 414).isActive = true
        if let mLayout = mCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            mLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            mLayout.minimumLineSpacing = 0.0
        }
        addSubview(mCollectionView)
        mCollectionView.translatesAutoresizingMaskIntoConstraints = false
        mCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        mCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mCollectionView.backgroundColor = .white
       
    }
    
    func fetchVideos() {
        ApiService.ShareInstance.fetchHomeVideos { Videos in
            self.video = Videos
            DispatchQueue.main.async {
                self.mCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.video?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mCollectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! VideoCell
        if let video = self.video?[indexPath.item] {
        cell.video = video
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mVideoLaucher = VideoLaucher()
        mVideoLaucher.showVideoPlayer()
    }
}
