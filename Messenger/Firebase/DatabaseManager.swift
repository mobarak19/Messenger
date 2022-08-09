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
        database.child("auth").child(email.makeFirebaseDatabaseKey()).observeSingleEvent(of: .value) { snapshot in
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
            database.child("auth").child(user.email.makeFirebaseDatabaseKey()).setValue([
                "first_name":user.firstName,
                "last_name":user.lastName
            ],withCompletionBlock: { error, _ in
                guard error == nil else{
                    completion(false)

                    return
                }
                
                self.database.child("users").observeSingleEvent(of: .value, with: { snapeshop in
                   
                    if var usersCollection = snapeshop.value as?[[String:String]]{
                        
                        // append to user dictionary
                        
                        let newCollection = [
                                                "name":user.firstName + " " + user.lastName,
                                                "email": user.email.makeFirebaseDatabaseKey()
                                            ]
                        usersCollection.append(newCollection)
                        
                        self.database.child("users").setValue(usersCollection,withCompletionBlock: {error, _ in
                           
                            guard error == nil else{
                                
                                completion(false)
                                
                                return
                            }
                            completion(true)
                        })
                        
                    }else{
                        
                        // create users collection
                        
                        let newCollection:[[String:String]] = [
                            
                            [
                                "name":user.firstName + " " + user.lastName,
                                "email": user.email.makeFirebaseDatabaseKey()
                            ]
                        ]
                        self.database.child("users").setValue(newCollection,withCompletionBlock: {error, _ in
                            guard error == nil else{
                                completion(false)
                                return
                            }
                            completion(true)
                        })
                    }
                })
            })
        }catch{
            completion(false)
        }

    }

}
