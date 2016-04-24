//
//  Part.swift
//  PartsCollector
//
//  Created by ximinz on 2016-04-23.
//  Copyright © 2016 ximinz. All rights reserved.
//

import Foundation
import UIKit

class Part{
    var name:String?
    var manufacture:String?
    var img:UIImage?
    var type:String?
    
    init(partName:String,partManufacture:String,partImage:UIImage){
        self.name = partName
        self.manufacture = partManufacture
        self.img = partImage
        self.type = ""
    }
    
}