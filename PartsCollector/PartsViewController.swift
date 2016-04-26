//
//  PartsViewController.swift
//  PartsCollector
//
//  Created by ximinz on 2016-04-23.
//  Copyright © 2016 ximinz. All rights reserved.
//

import UIKit


class PartsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NewPartViewControllerDelegate,PartDetailViewControllerDelegate,SelectedTableViewControllerDataSource{

    @IBOutlet weak var PartsTableView: UITableView!
    @IBOutlet weak var selectedBarItem: UIBarButtonItem!
    
    
    let partsCollector = PartCollector()
    var mediaTypeForNewPart:UIImagePickerControllerSourceType = .PhotoLibrary
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.title = "部件管理工具"
        PartsTableView.delegate = self;
        PartsTableView.dataSource = self;
        partsCollector.load_parts()
        // Do any additional setup after loading the view.
    }
    
    
    //PartTableView Delegate & DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partsCollector.get_size();
    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        //let image = self.images[indexPath.row] as UIImage;
//        return 25;
//    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PartCell")! as UITableViewCell;
        let part = partsCollector.get_part_by_index(indexPath.row)
        if let image = partsCollector.get_image_by_part(part){
            cell.imageView?.image = image
        }
        cell.textLabel?.text = part.name
        cell.detailTextLabel?.text = part.info
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("DetailSegue", sender: self)
    }
    
    @IBAction func backToPartsView(segue:UIStoryboardSegue){
        self.updateView()
        self.PartsTableView.reloadData()
    }
    @IBAction func viewPickedItemsTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("SelectedSegue", sender: self)
    }
   
    //delegate
    func add_part_to_collector(part: Part) {
        self.partsCollector.add_part(part)
    }
    
    func add_to_selected(selectedPart: Part) {
        self.partsCollector.select_a_part(selectedPart)
    }
    
    func get_selected_parts() -> [Part] {
        return self.partsCollector.get_selected_parts()
    }
    func save_selected_parts(parts: [Part]) {
        self.partsCollector
        updateView()
    }
    
    
    @IBAction func AddByCameraButtonTapped(sender: AnyObject) {
        self.mediaTypeForNewPart = .Camera
        self.performSegueWithIdentifier("NewPartSegue", sender: self)
    }
    @IBAction func AddByPhotoButtonTapped(sender: AnyObject) {
        self.mediaTypeForNewPart = .PhotoLibrary
        self.performSegueWithIdentifier("NewPartSegue", sender: self)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? NewPartViewController{
            dest.delegate = self
            dest.mediaType = self.mediaTypeForNewPart
        }
        if let dest = segue.destinationViewController as? PartDetailViewController{
            dest.partToDisplay = partsCollector.get_part(self.PartsTableView.indexPathForSelectedRow!.row)
            dest.delegate = self
        }
        if let dest = segue.destinationViewController as? SelectedTableViewController{
            //print("transitioning\n")
            dest.dataSource = self
        }
    }
    
    func updateView(){
        self.selectedBarItem.title = "已选" + "(" + String(self.partsCollector.get_selected_parts().count) + ")"
    }
    

    
    
}
