//
//  VideoCell.swift
//  demoLayout
//
//  Created by DuyNTD1 on 7/8/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    @IBOutlet weak var mMainView: UIView!
    @IBOutlet weak var mVideoThumbnail: UIImageViewCustom!
    @IBOutlet weak var mUserImage: UIImageViewCustom!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mDecriptionLabel: UILabel!
    
    var video:Video? {
        didSet {
            self.mTitleLabel.text = video?.title ?? ""
            let numBerofView = video?.number_of_views ?? 0
            let name = video?.channel?.name ?? ""
            self.mDecriptionLabel.text = ("\(name) • \(numBerofView)")
            self.mVideoThumbnail.setImagewithUrl(url: video?.thumbnail_image_name)
            self.mUserImage.setImagewithUrl(url: video?.channel?.profile_image_name)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mMainView.translatesAutoresizingMaskIntoConstraints = false
        mMainView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        mVideoThumbnail.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        mVideoThumbnail.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * (9/16)).isActive = true
        
        mVideoThumbnail.contentMode = .scaleAspectFill
        mMainView.clipsToBounds = true
        
        mUserImage.layer.cornerRadius = 22;
        mUserImage.contentMode = .scaleAspectFill
        
        mTitleLabel.lineBreakMode = .byWordWrapping
        mTitleLabel.numberOfLines = 0
        mTitleLabel.textColor = UIColor.init(named: "TitleVideoColor")
        mTitleLabel.font = UIFont.systemFont(ofSize: 20)
        
        mDecriptionLabel.textColor = UIColor(named: "DecriptionVideoColor")
        mDecriptionLabel.font = UIFont.systemFont(ofSize: 15)
    }

}
