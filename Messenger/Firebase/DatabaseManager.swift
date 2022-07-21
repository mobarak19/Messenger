//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Genusys Inc on 7/21/22.
//

import Foundation
import FirebaseDatabase

enum DatabaseError:Error{

    case insertError
}

class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference().child(Constants.APP_DATABASE_NAME)
    
    
}


//Account Management

extension DatabaseManager{
    
    ///check if a user exsits
    
    func ifUserExist(email:String,completion:@escaping(Bool)->Void){
        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value is String else{
                completion(false)
                return
            }
            completion(true)
        }
        
    }
    
    ///insert User into database
    func insertUser(user: UserModel,completion:@escaping(Bool)->Void){
        do{
            database.child(user.email).setValue([
                "first_name":user.firstName,
                "last_name":user.lastName
            ])
            completion(true)
        }catch{
            completion(false)
        }

    }

}
