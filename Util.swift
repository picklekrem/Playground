//
//  Util.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 15.01.2021.
//


import UIKit
fileprivate var aView : UIView?
extension UIViewController {
    func showSpinner(){
       aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
    }
    func removeSpinner(){
        aView?.removeFromSuperview()
        aView = nil
    }
}
