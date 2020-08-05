//
//  Extension.swift
//  demoLayout
//
//  Created by DuyNTD1 on 7/6/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import UIKit

//Change color for status bar
extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
   }
}

//Handle save data video to cache
let imageCache = NSCache<AnyObject, AnyObject>()
class  UIImageViewCustom : UIImageView {
    var urlString :String?
    
    func setImagewithUrl(url:String?) {
        
        self.urlString = url
        
        if let imageFromCache = imageCache.object(forKey: url! as NSObject) as? UIImage {
            print("imageFromCache")
            self.image = imageFromCache
            return
        }
        if let mUrlString = url {
            image = nil
            let mUrl = URL.init(string: mUrlString)
            URLSession.shared.dataTask(with: mUrl!) { (data, reponse, error) in
                if error != nil {
                    print(error!)
                }
                if let mdata = data {
                    DispatchQueue.main.async{
                        let mImageCache = UIImage(data: mdata)!
                        
                        if self.urlString == url {
                            self.image = mImageCache
                        } else {
                            print("self.urlString is \(self.urlString!)")
                            print("url is \(url!))")
                            print("Something wong here need to undersand")
                        }
                        imageCache.setObject(mImageCache, forKey: url! as NSObject)
                    }
                }
            }.resume()
        }
    }
}
