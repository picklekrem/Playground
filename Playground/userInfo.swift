//
//  userInfo.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 30.01.2021.
//

import Foundation
import Firebase


class userInfos {
    let firestoreDatabase = Firestore.firestore()
    var documentRef : DocumentReference? = nil
    let taskTitles = ["dog","cats","humans","people"]
    let taskTasks = ["dog","cats","humans","people"]


    var name = "ekrem"
    let user = Auth.auth().currentUser?.email!
    let docRef = firestoreDatabase.collection("Usernames").document(user!).collection("Tasks")
    for sayi in 0...3{
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
