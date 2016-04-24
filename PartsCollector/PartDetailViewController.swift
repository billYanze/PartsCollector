//
//  PartDetailViewController.swift
//  PartsCollector
//
//  Created by ximinz on 2016-04-23.
//  Copyright © 2016 ximinz. All rights reserved.
//

import UIKit

protocol PartDetailViewControllerDelegate:class{
    func add_to_selected(selectedPart:Part)
}


class PartDetailViewController: UIViewController {

    var partToDisplay:Part!
    
    weak var delegate: PartDetailViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var manuLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        imageView.image = partToDisplay.img
        nameLabel.text = partToDisplay.name
        manuLabel.text = partToDisplay.manufacture
    }
    
    @IBAction func addToSelectedButtonTapped(sender: AnyObject) {
        delegate?.add_to_selected(partToDisplay)
        self.performSegueWithIdentifier("DetailUnwindSegue", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
