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
    case userFetchError
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
    
    //get all users
    
    func getAllUsers( completion : @escaping (Result<[[String:String]],Error>)->Void){
        
        self.database.child("users").observeSingleEvent(of: .value, with: {snapshot in
           
            guard let value = snapshot.value as? [[String:String]] else{
                completion(.failure(DatabaseError.userFetchError))
                return
            }
            completion(.success(value))
        })
        
    }
}

extension DatabaseManager{
    
    func createNewConversation(with otherUserEmail:String,firstMessage:Message,completion:@escaping(Bool)->Void){
        
    }
    func getAllConversations(for email:String,completion:@escaping(Result<String,Error>)->Void){
        
    }
    
    func getMessagesForConvarsation(with id:String,completion:@escaping(Result<String,Error>)->Void){
        
    }
    func sendMessage(to conversation:String,message:Message,completion:@escaping(Bool)->Void){
        
    }
    
}
