//
//  ProfileViewModel.swift
//  Playground
//
//  Created by Ekrem Özkaraca on 18.02.2021.
//

import Foundation
import Firebase
class ProfileViewModel {
    
    var profileuserList : [UserList] = []
    func getUserInfo(){
        let docRef = firestoreDatabase.collection("Usernames").document((Auth.auth().currentUser?.email)!)
        docRef.getDocument { (DocumentSnapshot, Error) in
            if let Error = Error{
                print(Error.localizedDescription)
            }
            else{
                do{
                    let jsonData = try? JSONSerialization.data(withJSONObject:DocumentSnapshot!.data() as Any)
                    let userModel = try JSONDecoder().decode(UserList.self, from: jsonData!)
                    self.profileuserList.append(userModel)
                    print(userModel)
                    
                }
                catch let err
                {
                    print(err)
                }
                
            }
        }
    }
}
