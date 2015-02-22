//
//  SearchTableViewController.swift
//  myGiantbomb
//
//  Created by Peter Sterr on 22.02.15.
//  Copyright (c) 2015 Peter Sterr. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var gameList = [GameModel]()
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        var backgroundView = UIView(frame: CGRectZero)
        self.tableView.tableFooterView = backgroundView
        self.tableView.backgroundColor = UIColor.whiteColor()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.gameList.removeAll(keepCapacity: false)
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        DataManager.searchGiantbomb(searchBar.text) {(GBData: NSData!) -> Void in
            let json = JSON(data: GBData)
            if let gameArray = json["results"].array {
                var games = [GameModel]()
                for gameDict in gameArray {
                    var gameName: String? = gameDict["name"].stringValue
                    var gameDeck: String? = gameDict["deck"].stringValue
                    var game = GameModel(name: gameName, deck: gameDeck)
                    games.append(game)
                }
                println(games)
                dispatch_async(dispatch_get_main_queue(), {
                    if games.count == 0 {
                        //TODO
                    } else {
                        self.gameList = games
                        self.tableView.reloadData()
                    }
                })
            }
        }
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.gameList.removeAll(keepCapacity: false)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return gameList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = gameList[indexPath.row].name
        return cell
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
