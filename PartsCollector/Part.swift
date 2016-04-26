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
    var name:String!
    var info:String!
    var price:Int!
    var type:String!
    
    init(partName:String,partInfo:String,partPrice:Int,partType:String){
        self.name = partName
        self.info = partInfo
        self.price = partPrice
        self.type = partType
    }
    
}