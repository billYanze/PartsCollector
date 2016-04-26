//
//  File.swift
//  PartsCollector
//
//  Created by ximinz on 2016-04-23.
//  Copyright © 2016 ximinz. All rights reserved.
//

import Foundation
import UIKit

func getDocumentsURL() -> NSURL {
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    return documentsURL
}

func fileInDocumentsDirectory(filename: String) -> String {
    
    let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
    return fileURL.path!
    
}

class PartCollector{
    var parts = [Part]()
    var partsSelected = [Part]()
    var infoDictionary = NSMutableDictionary()
    var selectedInfoDictionary = NSMutableDictionary()
    init(){
        load_parts()
    }
    func get_size()->Int{
        return parts.count
    }
    
    func get_selected_size()->Int{
        return partsSelected.count
    }
    
    func add_part(PartName name:String,PartInfo info:String,PartPrice price:Int,PartType type:String,PartImage image:UIImage)->Void{
        let newPart = Part(partName: name,partInfo: info,partPrice: price,partType: type)
        save_image_using_name(image,name: name)
        parts.append(newPart)
        update_partList_in_disk(false)
    }
    
    
    func save_image_using_name(image:UIImage,name:String){
        let imagePath = fileInDocumentsDirectory(name)
        let success = saveImage(image, path: imagePath)
        if(!success){
            print("error")
        }
    }
    
    func get_part_by_index(index:Int)->Part{
        return parts[index]
    }
    
    func get_image_by_part(part:Part)->UIImage?{
        let img = UIImage(contentsOfFile: fileInDocumentsDirectory(part.name))
        return img
    }
    
    func update_partList_in_disk(is_selected_list:Bool){
        infoDictionary.removeAllObjects()
        if is_selected_list{
            for part in partsSelected{
                let key = part.name
                let value = NSArray(array:[part.info,part.price,part.type])
                infoDictionary.setObject(value, forKey: key)
            }
        }
        if is_selected_list{
            for part in parts{
                let key = part.name
                let value = NSArray(array:[part.info,part.price,part.type])
                infoDictionary.setObject(value, forKey: key)
            }
        }
        if is_selected_list{
            infoDictionary.writeToFile(fileInDocumentsDirectory("info"), atomically: true)
        }
        else{
            infoDictionary.writeToFile(fileInDocumentsDirectory("info_selected"), atomically: true)
        }
    }
    
    func select_a_part(part:Part){
        partsSelected.append(part)
        update_partList_in_disk(true)
    }
    
    func deselect_a_part(partUnselected:Part){
        partsSelected.removeAtIndex(partsSelected.indexOf({$0.name == partUnselected.name})!)
    }
    
    func get_selected_parts()->[Part]{
        return partsSelected
    }
    
    func load_parts()->Void{
        
        if let info = NSMutableDictionary(contentsOfFile: fileInDocumentsDirectory("info")){
            for element in info{
                let name = element.key as! String
                let values = element.value as! NSArray
                let part = Part(partName: name, partInfo: values[0] as! String, partPrice: values[1] as! Int, partType: values[2] as! String)
                self.parts.append(part)
            }
        }
        
        if let info = NSMutableDictionary(contentsOfFile: fileInDocumentsDirectory("info_selected")){
            for element in info{
                let name = element.key as! String
                let values = element.value as! NSArray
                let part = Part(partName: name, partInfo: values[0] as! String, partPrice: values[1] as! Int, partType: values[2] as! String)
                self.partsSelected.append(part)
            }
        }
        
    }
    
    //save image helper
    func saveImage (image: UIImage, path: String ) -> Bool{
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = pngImageData!.writeToFile(path, atomically: true)
        return result
        
    }
    
}
