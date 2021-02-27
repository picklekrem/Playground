//
//  Singleton.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 16.01.2021.
//

import Foundation
import Firebase
class firebaseSing {
    static let sharedData = firebaseSing ()

    

    public init() {
        getDataFromFirestore()
    }
    
}
