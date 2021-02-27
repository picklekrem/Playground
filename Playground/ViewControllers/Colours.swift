//
//  Colours.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 11.01.2021.
//

import UIKit

extension UIColor {
    
    static func rgb (r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let bacgroundColor = UIColor.rgb(r: 227, g: 253, b: 253)
    static let pulsatingfillcolor = UIColor.rgb(r: 166, g: 227, b: 233)
    static let outlinestroke = UIColor.rgb(r: 113, g: 201, b: 206)
    static let trackstorecolor = UIColor.rgb(r: 203, g: 241, b: 245)

}
