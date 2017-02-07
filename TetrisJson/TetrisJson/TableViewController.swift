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
                let json = JSON(data: data)
                createRepositoriesFromDictionary(dictionary: json)
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
        cell.textLabel!.text = object.getDisplayName()
        if !object.hasWiki {
            cell.backgroundColor = UIColor.gray
        }
        return cell
    }
    
    
    func createRepositoriesFromDictionary(dictionary: JSON) {
        let items = dictionary["items"].arrayValue
        for currentItem in items {
            let newRepository = Repository()
            newRepository.name = currentItem["name"].stringValue
            newRepository.hasWiki = currentItem["has_wiki"].boolValue
            objects.append(newRepository)
        }
    }
    
}
