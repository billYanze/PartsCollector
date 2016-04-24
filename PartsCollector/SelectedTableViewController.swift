//
//  SelectedTableViewController.swift
//  PartsCollector
//
//  Created by ximinz on 2016-04-23.
//  Copyright © 2016 ximinz. All rights reserved.
//

import UIKit

protocol SelectedTableViewControllerDataSource:class{
    func get_selected_parts()->[Part]
    func save_selected_parts(parts:[Part])->Void
}

class SelectedTableViewController: UITableViewController {

    var dataSource:SelectedTableViewControllerDataSource?
    var selectedParts:[Part]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedParts = dataSource?.get_selected_parts()
        self.title = "已选择" + "(" + String(selectedParts!.count) + ")"
        let confirmbutton = UIBarButtonItem(title: "清空", style:.Done, target: self, action: #selector(self.clearAll))
        self.navigationItem.rightBarButtonItem = confirmbutton
        //print("parts are\n\(self.selectedParts)")
    }

    func clearAll(){
        
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return selectedParts?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        cell.imageView?.image = selectedParts?[indexPath.row].img
        cell.textLabel?.text = selectedParts?[indexPath.row].name
        cell.detailTextLabel?.text = selectedParts?[indexPath.row].manufacture

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("SelectedDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? PartDetailViewController{
            dest.partToDisplay = selectedParts![self.tableView.indexPathForSelectedRow!.row]
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            selectedParts?.removeAtIndex(indexPath.row)
            self.dataSource?.save_selected_parts(selectedParts!)
            self.title = "已选择" + "(" + String(selectedParts!.count) + ")"
            self.tableView.reloadData()
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
}
