//
//  ViewController.swift
//  TetrisJson
//
//  Created by  on 06.02.17.
//  Copyright © 2017 Matthias Zarzecki. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    // MARK: - Setup Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://github.com/matthiaszarzecki/tetris_json.git")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    
                    OperationQueue.main.addOperation({
                    })
                    
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //        let object = objects[(indexPath as NSIndexPath).row]
        //        cell.displayName!.text = "\(Route.getDisplayName(route: object)) - \(Route.getPriceString(route: object))"
        //        if let request = Route.getProviderIconRequestURL(route: object) {
        //            cell.providerIcon.loadRequest(request)
        //        }
        cell.textLabel!.text = "asds"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}

