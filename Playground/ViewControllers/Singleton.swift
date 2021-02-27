//
//  Singleton.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 16.01.2021.
//

import Foundation

class dataSingleton {
    static let sharedCommanInf = dataSingleton()
    
    
    var howManyTimesDid = Int()
    var otherNumber = Float()
    var taskdid = [String] ()
    var check = false
    
    
    private init () {
        
    }
}
