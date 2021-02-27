//
//  PhotoViewController.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 27.01.2021.
//

import UIKit
import Firebase
import SDWebImage

class PhotoViewController: UIViewController {

    let firestoreDatabase = Firestore.firestore()
    var documentRef : DocumentReference? = nil
    var namelabelText = String()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let taskTitles = ["Askıda simit!","Sokak dostum!","Teşekkür ederim!","people","Task Title 1","Task Title 2","Task Title 3","Task Title 4","Task Title 5"]
        let taskTasks = ["Bu gün tanımadığın birinin yüzünü güldürmek ve iyi hissetmek için askıya bir adet simit bırak :)","Sokakta karşılaştığın bir hayvanı sev! İnan çok güzel hissetirecek :)","Bugün en az 3 kişiye Teşekkür et! Bu sen farkında olmasan bile çok iyi gelicek :)","people", "Task 1","Task 2","Task 3","Task 4","Task 5"]
        let user = Auth.auth().currentUser?.email!
        
        nameLabel.text = namelabelText
        print("hey")

        
        let docRef = firestoreDatabase.collection("Usernames").document(user!).collection("Tasks")
        print(docRef)
        for sayi in 0...taskTitles.count{
            let firestorePost = ["Baslık" : taskTitles[sayi], "Görev" : "\(taskTasks[sayi])"] as [String : String]
            docRef.addDocument(data:firestorePost , completion: { (error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ??   "Error" )
                }
                else{
                    print("eklendi")
                }
            })
        }
        
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let name = Auth.auth().currentUser!.email
        let mediafolder = storageRef.child("media")
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
//            let uuid = UUID().uuidString
            let imageRef = mediafolder.child("\(name).jpeg")
            
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Please try again!")
                }
                else{
                    imageRef.downloadURL { (url, error) in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            
                            let profilePic = ["imageURL" : imageURL!] as [String : Any]
                            self.firestoreDatabase.collection("Usernames").document(name!).setData(profilePic, merge: true)
                            
                        }
                    }
                }
            }
        }
        self.performSegue(withIdentifier: "toinfoVC", sender: nil)
    }
    
    @IBAction func photoButtonClicked(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
}
extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func makeAlert(titleInput : String, messageInput : String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
