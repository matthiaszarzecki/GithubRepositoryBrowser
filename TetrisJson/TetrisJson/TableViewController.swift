//
//  TableViewController.swift
//  TetrisJson
//
//  Created by  on 06.02.17.
//  Copyright © 2017 Matthias Zarzecki. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let sourceUrl = "https://api.github.com/search/repositories?q=%20tetris"
    var objects = [Repository]()
    
    // MARK: - Setup functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getJsonData(url: sourceUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[(indexPath as NSIndexPath).row]
        cell.textLabel!.text = object.getDisplayName()
        if !object.hasWiki {
            cell.backgroundColor = UIColor.gray
        }
        return cell
    }
    
    func getJsonData(url: String = "") {
        let requestURL: NSURL = NSURL(string: sourceUrl)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            
            if (statusCode == 200) {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String: AnyObject]
                    self.createRepositoriesFromDictionary(dictionary: dictionary!)
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        
        task.resume()
    }
    
    func createRepositoriesFromDictionary(dictionary: [String: AnyObject]) {
        if let items = dictionary["items"] as? [String: AnyObject] {
            
            for currentItem in items {
                let newRepository = Repository()
//                if let name = currentItem["name"] as? String {
//                    newRepository.name = name
//                }
//                if let hasWiki = currentItem["has_wiki"] as? Bool {
//                    newRepository.hasWiki = hasWiki
//                }
                objects.append(newRepository)
            }
        }
    }
    
}
