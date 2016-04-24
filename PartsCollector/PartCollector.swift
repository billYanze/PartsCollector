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
    var index = 0
    var infoDictionary=NSMutableDictionary()
    var selectedInfoDictionary=NSMutableDictionary()
    func get_size()->Int{
        return parts.count
    }
    
    func add_part(newPart:Part)->Void{
        self.parts.append(newPart)
        save_part(newPart)
    }
    
    func save_part(part:Part)->Void{
        if let partImg = part.img{
            let imagePath = fileInDocumentsDirectory(String(index))
            let success = saveImage(partImg,path: imagePath)
            if(!success){
                print("error")
            }
            let key = String(index)
            let value = NSArray(array:[part.name!,part.manufacture!,part.type!])
            infoDictionary.setObject(value, forKey: key)
            index+=1
        }
        //print(infoDictionary)
        infoDictionary.writeToFile(fileInDocumentsDirectory("info"), atomically: true)
    }
    
    func load_parts()->Void{
        
        if let info = NSMutableDictionary(contentsOfFile: fileInDocumentsDirectory("info")){
            self.infoDictionary = info
            //print("info is \(info)")
            for element in info{
                let key = element.key as! String
                let value = element.value as! NSArray
                let img = UIImage(contentsOfFile: fileInDocumentsDirectory(key))
                let part = Part(partName: value[0] as! String, partManufacture: value[1] as! String, partImage: img!)
                part.type = (value[2] as! String)
                self.parts.append(part)
                index += 1
            }
        }
        
        if let info = NSMutableDictionary(contentsOfFile: fileInDocumentsDirectory("SelectedInfo")){
            self.selectedInfoDictionary = info
            //print("info is \(info)")
            for element in info{
                let key = element.key as! String
                let part = self.parts[Int(key)!]
                self.partsSelected.append(part)
            }
        }
        
    }
    
    func save_selected_info(){
        for part in partsSelected{
            let key = String(index)
            let value = NSArray(array:[part.name!,part.manufacture!,part.type!])
            selectedInfoDictionary.setObject(value, forKey: key)
        }
        selectedInfoDictionary.writeToFile(fileInDocumentsDirectory("SelectedInfo"), atomically: true)
    }
    
    func get_part(index:Int)->Part{
        return parts[index]
    }
    
    func select_part(selected_part:Part){
        //print("adding to selected\n")
        self.partsSelected.append(selected_part)
        self.save_selected_info()
    }
    
    func get_selected_parts()->[Part]{
        return self.partsSelected
    }
    
    //save image helper
    func saveImage (image: UIImage, path: String ) -> Bool{
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = pngImageData!.writeToFile(path, atomically: true)
        return result
        
    }
    
}
