//
//  PinkViewController.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 8.01.2021.
//

import UIKit

class PinkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "pink view cont"
        print("here i go")
        
        
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("here i off")
    } 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
