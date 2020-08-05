//
//  ApiService.swift
//  demoLayout
//
//  Created by DuyNguyen on 7/16/20.
//  Copyright © 2020 DuyNTD1. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let ShareInstance =  ApiService()
    var videos: [Video]?
    func fetchHomeVideos(completion: @escaping ([Video]?) -> () ) {
        let mJsonString = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        let mJsonURL = URL.init(string: mJsonString)
        
        URLSession.shared.dataTask(with: mJsonURL!) { (data, reponse, error) in
            if error != nil {
                print(error!)
            }
            if let mdata = data {
                do {
                    self.videos = try JSONDecoder().decode([Video].self, from: mdata)
                    completion(self.videos)
                } catch {
                    print("Something wrong")
                }
            }
        }.resume()
    }
    
    func fetchTrendVideos(completion: @escaping ([Video]?) -> () ) {
        let mJsonString = "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
        let mJsonURL = URL.init(string: mJsonString)
        
        URLSession.shared.dataTask(with: mJsonURL!) { (data, reponse, error) in
            if error != nil {
                print(error!)
            }
            if let mdata = data {
                do {
                    self.videos = try JSONDecoder().decode([Video].self, from: mdata)
                    completion(self.videos)
                } catch {
                    print("Something wrong")
                }
            }
        }.resume()
    }
    
    func fetchSubVideos(completion: @escaping ([Video]?) -> () ) {
        let mJsonString = "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json"
        let mJsonURL = URL.init(string: mJsonString)
        
        URLSession.shared.dataTask(with: mJsonURL!) { (data, reponse, error) in
            if error != nil {
                print(error!)
            }
            if let mdata = data {
                do {
                    self.videos = try JSONDecoder().decode([Video].self, from: mdata)
                    completion(self.videos)
                } catch {
                    print("Something wrong")
                }
            }
        }.resume()
    }
    
    
}
