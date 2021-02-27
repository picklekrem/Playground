//
//  TableViewCell.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 6.01.2021.
//

import UIKit
import Firebase
import Foundation
class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var labeltextTwo: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    var number = Int()
    var imageset = true
    override func awakeFromNib() {
        super.awakeFromNib()
        textview.isEditable = false
  
        if dataSingleton.sharedCommanInf.check == false {
            imageset = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func conf() {
        
        let backgroundView = UIView()
//        myView.backgroundColor = .green
        backgroundView.backgroundColor = .none
        selectedBackgroundView = backgroundView
        myView.layer.shadowColor = UIColor.gray.cgColor
        myView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        myView.layer.shadowOpacity = 1.0
        myView.layer.masksToBounds = false
        myView.layer.cornerRadius = 2.0
    }

    @IBAction func buttonClicked(_ sender: Any) {
        
//        print("i clicked")
        print(labeltextTwo.text!)
        if imageset == true{
            buttonOutlet.setImage(UIImage(named: "tikon"), for: UIControl.State.normal)
            dataSingleton.sharedCommanInf.taskdid.append(labeltextTwo.text!)
            imageset = false
            
        }else{
            buttonOutlet.setImage(UIImage(named: "tikoff"), for: UIControl.State.normal)
            dataSingleton.sharedCommanInf.taskdid.removeLast()
            imageset = true
        }
    }
}
