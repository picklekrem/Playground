//
//  TableViewCell.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 6.01.2021.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var labeltext: UILabel!
    @IBOutlet weak var labeltextTwo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
        print("i clicked")
    }
}
