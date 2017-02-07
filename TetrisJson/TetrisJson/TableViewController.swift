//
//  TableViewController.swift
//  TetrisJson
//
//  Created by  on 06.02.17.
//  Copyright © 2017 Matthias Zarzecki. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController: UITableViewController {

    let sourceUrl = "https://api.github.com/search/repositories?q=%20tetris"
    var objects = [Repository]()
    
    // MARK: - Setup functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: sourceUrl) {
            if let data = try? Data(contentsOf: url) {
                createRepositoriesFromDictionary(dictionary: JSON(data: data))
            }
        }
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
        cell.textLabel!.text = object.displayName
        if !object.hasWiki {
            cell.backgroundColor = UIColor.init(colorLiteralRed: 0.1, green: 0.1, blue: 0.1, alpha: 0)
        }
        return cell
    }
    
    // MARK: Internal functions
    
    func createRepositoriesFromDictionary(dictionary: JSON) {
        let items = dictionary["items"].arrayValue
        for currentItem in items {
            let newRepository = Repository(repositoryName: currentItem["name"].stringValue, userLoginName: currentItem["owner"]["login"].stringValue, hasWiki: currentItem["has_wiki"].boolValue, size: currentItem["size"].intValue)
            objects.append(newRepository)
        }
    }
    
}
