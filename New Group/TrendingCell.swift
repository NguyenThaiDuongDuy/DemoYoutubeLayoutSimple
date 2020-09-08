//
//  TrendingCell.swift
//  demoLayout
//
//  Created by DuyNguyen on 7/25/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import UIKit

class TrendingCell: HomeCell {
    
    override func fetchVideos() {
        ApiService.ShareInstance.fetchTrendVideos { Videos in
            self.video = Videos
            DispatchQueue.main.async {
                self.mCollectionView.reloadData()
            }
        }
    }
}
