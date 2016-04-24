//
//  NewPartViewController.swift
//  PartsCollector
//
//  Created by ximinz on 2016-04-23.
//  Copyright © 2016 ximinz. All rights reserved.
//

import UIKit

protocol NewPartViewControllerDelegate:class{
    func add_part_to_collector(part:Part)
}

class NewPartViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    weak var delegate:NewPartViewControllerDelegate?
    
    @IBOutlet weak var typePickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var manuTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var partToAdd:Part?
    var mediaType:UIImagePickerControllerSourceType = .PhotoLibrary
    let imagePickerViewController = UIImagePickerController()
    let types = ["1","2","3","4","5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新部件"
        let confirmbutton = UIBarButtonItem(title: "确认", style:.Done, target: self, action: #selector(self.confirmTapped))
        self.navigationItem.rightBarButtonItem = confirmbutton
        self.imagePickerViewController.delegate = self
        self.imagePickerViewController.sourceType = self.mediaType
        self.typePickerView.delegate = self
        self.typePickerView.dataSource = self
        self.presentViewController(self.imagePickerViewController, animated: true, completion: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewPartViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        self.view.endEditing(true)
    }
    
    
    //Image picked or added
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.partToAdd = Part(partName: "name", partManufacture: "manu", partImage: image)
        imageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.performSegueWithIdentifier("ConfirmAddPart", sender: self)
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.types.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.types[row]
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func confirmTapped(){
        partToAdd?.name = nameTextField.text
        partToAdd?.manufacture = manuTextField.text
        delegate?.add_part_to_collector(partToAdd!)
        self.performSegueWithIdentifier("ConfirmAddPart", sender: self)
    }
    
    
    

}
