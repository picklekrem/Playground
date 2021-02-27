//
//  ViewController.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 6.01.2021.
//

import UIKit
import Firebase
import Foundation
import SDWebImage
let firestoreDatabase = Firestore.firestore()
var firestoreReference : DocumentReference?


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var taskContainerList : [TaskContainerList] = []
    let decoder = JSONDecoder()
    let maxSize = 3
    var timer : Timer!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks!"
        let currentUser = Auth.auth().currentUser
        getDataFromFirestore()
        
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector:#selector(timedata),userInfo: nil, repeats: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isHidden = true
    }
    
    @objc func timedata() {
        getDataFromFirestore()
        taskSettings()
        
    }
    func taskSettings(){
        print(dataSingleton.sharedCommanInf.taskdid)
        dataSingleton.sharedCommanInf.check = true
        dataSingleton.sharedCommanInf.taskdid.removeAll()
        
//        firestoredatabase.collection("Tasks").document("\(labeltextTwo.text!)").delete()
    }
    func getDataFromFirestore() {
        showSpinner()
        let user = Auth.auth().currentUser
        if user == nil {
            print("user not found")
        }
        else{
            let docRef = firestoreDatabase.collection("Usernames").document((Auth.auth().currentUser?.email)!).collection("Tasks")
            docRef.getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.removeSpinner()
                    for document in querySnapshot!.documents {
    //                    print("\(document.documentID) => \(document.data())")
                        do{
                            let jsonData = try? JSONSerialization.data(withJSONObject:document.data())
                            let taskModel = try self.decoder.decode(TaskContainerList.self, from: jsonData!)
                            self.taskContainerList.append(taskModel)
                        }
                        catch let err
                        {
                            print(err)
                        }
                    }
    //                todo
    //                gelen datayı userdef e kaydet, sonra tableviewda göster.(eski datayı sil)
    //                gelen tarihi user defe kaydet
                    self.taskContainerList.shuffle()
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return maxSize
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.conf()
        cell.myView.layer.cornerRadius = cell.myView.frame.height / 9
        cell.textview.layer.cornerRadius = cell.textview.frame.height / 9
        
        if taskContainerList.count != 0 && indexPath.row <= maxSize {
            cell.labeltextTwo.text = taskContainerList[indexPath.row].Baslık
            cell.textview.text = taskContainerList[indexPath.row].Görev
        }
        return cell
    }
}


class SecondViewController: UIViewController , UITextViewDelegate{
    @IBOutlet weak var ideasView: UIView!
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var labelText: UILabel!
    
    var array = [String] ()
    
    override func viewDidLoad() {
        title = "Ideas!"
        textview.delegate = self
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .none
//        textField.borderStyle = UITextField.BorderStyle.roundedRect
        ideasView.layer.shadowColor = UIColor.gray.cgColor
        ideasView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        ideasView.layer.shadowOpacity = 1.0
        ideasView.layer.masksToBounds = false
        ideasView.layer.cornerRadius = 4
        textview.text = "Tell us the things that makes you happy in your daily life so we can share them with other people!"
        textview.textColor = UIColor.lightGray

//        deneme()
    }
    func textViewDidBeginEditing(_ textview: UITextView) {
        if textview.textColor == UIColor.lightGray {
            textview.text = nil
            textview.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textview: UITextView) {

        if textview.text == "" {

            textview.text = "Tell us the things that makes you happy in your daily life so we can share them with other people!"
            textview.textColor = UIColor.lightGray
        }
    }
    @IBAction func shareButton(_ sender: Any) {
        print(textview.text!)
      
        let firestorePost = ["postComment" : self.textview.text!, "Email: " : Auth.auth().currentUser!.email!] as [String : Any]
        firestoreReference = firestoreDatabase.collection("Posts").addDocument(data:firestorePost , completion: { (error) in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ??   "Error" )
            }
            else{
                self.makeAlert(titleInput: "Teşekkürler :)", messageInput: "Bildiriminiz bize ulaşmıştır. En kısa sürede geri dönüş yapacağız (:")
                self.textview.text = ""
                self.tabBarController?.selectedIndex = 0
            }
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textview.resignFirstResponder()
        return(true)
    }
    func makeAlert(titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

var profileUserInfoList : ProfileViewModel = ProfileViewModel()
class ThirdViewController: UIViewController{

    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        profileUserInfoList.getUserInfo()
        title = "Profile"

        profileView.layer.borderWidth = 5
        profileView.layer.masksToBounds = false
        profileView.layer.borderColor = UIColor.white.cgColor
        profileView.layer.cornerRadius = profileView.frame.height/5
        profileView.clipsToBounds = true
        
        
        print(profileUserInfoList.profileuserList.count)

//        firestoreDatabase.collection("Usernames").document((Auth.auth().currentUser!.email)!).getDocument { (document, err) in
//            if let document = document {
//                if let picture = document.get("imageURL") as? String{
//                    print(picture)
//                    let url = URL(string: picture)!
//                    self.profileView.sd_setImage(with: url)
//                }
//                if let name = document.get("Fullname") as? String{
//                    self.nameLabel.text = name
//                }
//            }
//        }
    }
    
    
    @IBAction func logOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toAuthVC", sender: nil)
        }catch{
            print("error")
        }
    }
}
