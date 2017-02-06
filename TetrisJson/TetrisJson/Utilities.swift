//
//  Utilities.swift
//  TetrisJson
//
//  Created by  on 06.02.17.
//  Copyright © 2017 Matthias Zarzecki. All rights reserved.
//

import Foundation

class Utilities {
    
    static func getJSonFileAsDictionary(_ urlString: String = "") -> NSDictionary? {
        var jsonData: [String : AnyObject]? = nil
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: {
            (data, response, error) in
            if(error != nil) {
                print("error")
            } else {
                do {
                    jsonData = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String : AnyObject]
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
        return jsonData as NSDictionary?
    }
    
}
