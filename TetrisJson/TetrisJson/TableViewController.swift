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

    let baseURL = "https://api.github.com/search/"
    let searchType = "repositories"
    let searchTerm = "tetris"
    let numberOfResults = 30
    var currentResultPage = 1
    
    var objects = [Repository]()
    let formatter = ByteCountFormatter()
    
    // MARK: - Setup functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = "\(baseURL)\(searchType)?q=\(searchTerm)&page=\(currentResultPage)per_page=\(numberOfResults)"
        
        if let url = URL(string: request) {
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return "\(searchType)/\(searchTerm)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RepositoryCell
        let object = objects[(indexPath as NSIndexPath).row]
        cell.displayRepositoryName.text = object.repositoryName
        cell.displayUserLoginName.text = object.userLoginName
        cell.displaySize.text = getFileSizeDisplay(sizeInKB: object.size)
        if object.hasWiki {
            cell.backgroundColor = UIColor.init(colorLiteralRed: 0.1, green: 0.1, blue: 0.1, alpha: 0)
        } else {
            cell.displayWiki.text = ""
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
    
    func getFileSizeDisplay(sizeInKB: Int) -> String {
        return formatter.string(fromByteCount: Int64(sizeInKB * 1024))
    }
    
}
