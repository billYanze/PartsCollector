//
//  TypeCollector.swift
//  PartsCollector
//
//  Created by ximinz on 2016-04-25.
//  Copyright © 2016 ximinz. All rights reserved.
//

import Foundation

class TypeCollector{
    var types:[String]!
    
    init(types:[String]){
        self.types = types
    }
    
    func add_a_type(type:String){
        types.append(type)
    }
    
    func get_types()->[String]{
        return types
    }
    
}