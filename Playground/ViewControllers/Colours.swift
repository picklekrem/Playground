//
//  Colours.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 11.01.2021.
//

import UIKit

extension UIColor {
    
    static func rgb (r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        
        return UIColor(red: r/25, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let bacgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
}
