//
//  TableViewController.swift
//  TetrisJson
//
//  Created by  on 06.02.17.
//  Copyright © 2017 Matthias Zarzecki. All rights reserved.
//

import UIKit
import SwiftyJSON

class RepositorySearchController: UITableViewController {

    let baseURL = "https://api.github.com/search/"
    let searchType = "repositories"
    var searchTerm = "tetris"
    let numberOfResults = 10
    var currentResultPage = 0
    
    var objects = [Repository]()
    let formatter = ByteCountFormatter()
    let hasWikiColor = UIColor.init(colorLiteralRed: 0.1, green: 0.1, blue: 0.1, alpha: 0)
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Setup functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        searchBar.text = searchTerm
        setupViewWithResults(number: numberOfResults)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupViewWithResults(number: Int) {
        currentResultPage += 1
        let request = "\(baseURL)\(searchType)?q=\(searchTerm)&page=\(currentResultPage)&per_page=\(numberOfResults)"
        if let url = URL(string: request) {
            if let data = try? Data(contentsOf: url) {
                createRepositoriesFromJsonData(json: JSON(data: data), number: numberOfResults, currentPage: currentResultPage)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        return "\(searchType) / \(searchTerm)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= objects.count - 1 {
            setupViewWithResults(number: numberOfResults)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RepositoryCell
        let object = objects[(indexPath as NSIndexPath).row]
        cell.displayRepositoryName.text = object.repositoryName
        cell.displayUserLoginName.text = object.userLoginName
        cell.displaySize.text = getFileSizeDisplay(sizeInKB: object.size)
        if object.hasWiki {
            cell.backgroundColor = hasWikiColor
        } else {
            cell.backgroundColor = UIColor.white
            cell.displayHasWiki.text = ""
        }
        return cell
    }
    
    // MARK: Search bar functions
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            search(searchTerm: text)
        }
    }
    
    func search(searchTerm: String) {
        currentResultPage = 0
        objects = [Repository]()
        self.searchTerm = searchTerm
        setupViewWithResults(number: numberOfResults)
    }
    
    // MARK: Internal functions
    
    func createRepositoriesFromJsonData(json: JSON, number: Int = 10, currentPage: Int) {
        for currentItem in json["items"].arrayValue {
            objects.append(Repository(repositoryName: currentItem["name"].stringValue, userLoginName: currentItem["owner"]["login"].stringValue, hasWiki: currentItem["has_wiki"].boolValue, size: currentItem["size"].intValue))
        }
        tableView.reloadData()
    }
    
    func getFileSizeDisplay(sizeInKB: Int) -> String {
        return formatter.string(fromByteCount: Int64(sizeInKB * 1024))
    }
    
}
