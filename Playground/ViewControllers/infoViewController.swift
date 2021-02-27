//
//  infoViewController.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 28.01.2021.
//

import UIKit

class infoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toTaskVC", sender: nil)
    }

}
