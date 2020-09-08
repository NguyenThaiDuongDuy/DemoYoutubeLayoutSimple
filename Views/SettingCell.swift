//
//  SettingCell.swift
//  demoLayout
//
//  Created by DuyNTD1 on 7/14/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var mIconImage: UIImageView!
    @IBOutlet weak var mLabel: UILabel!
    
    var SettingData:SettingData? {
        didSet{
            mIconImage.image = UIImage.init(named: SettingData!.nameIcon!)
            mLabel.text =  SettingData!.nameLabel!.rawValue
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        contentView.backgroundColor = highlighted ? UIColor.gray : UIColor.white
        mLabel.textColor = highlighted ? UIColor.white : UIColor.black
        mIconImage.tintColor = highlighted ? UIColor.white:UIColor.black
        
        print(highlighted)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .white
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
