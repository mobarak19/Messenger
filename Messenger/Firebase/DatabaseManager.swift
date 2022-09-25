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
        database.child(FBCollectionName.AUTH).child(email.makeFirebaseDatabaseKey()).observeSingleEvent(of: .value) { snapshot in
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
            database.child(FBCollectionName.AUTH).child(user.email.makeFirebaseDatabaseKey()).setValue([
                "first_name":user.firstName,
                "last_name":user.lastName
            ],withCompletionBlock: { error, _ in
                guard error == nil else{
                    completion(false)

                    return
                }
                self.database.child(FBCollectionName.USERS).observeSingleEvent(of: .value, with: { snapeshop in
                    if var usersCollection = snapeshop.value as?[[String:String]]{
                                                
                        let newCollection = [
                                                "name":user.firstName + " " + user.lastName,
                                                "email": user.email.makeFirebaseDatabaseKey()
                                            ]
                        usersCollection.append(newCollection)
                        
                        self.database.child(FBCollectionName.USERS).setValue(usersCollection,withCompletionBlock: {error, _ in
                           
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
                        self.database.child(FBCollectionName.USERS).setValue(newCollection,withCompletionBlock: {error, _ in
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
        
        self.database.child(FBCollectionName.USERS).observeSingleEvent(of: .value, with: {snapshot in
           
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
        let currentEmail = MessengerDefaults.shared.userEmail
        guard !currentEmail.isEmpty else{
            return
        }
        let safeEmail = currentEmail.makeFirebaseDatabaseKey()
        let ref = database.child(FBCollectionName.AUTH).child(safeEmail)
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard var userNode = snapshot.value as? [String:Any] else {
                completion(false)
                return
            }
            let sendDate = firstMessage.sentDate.formatted(date: .complete, time: .complete)
            
            var message = ""
            
            switch firstMessage.kind{
            case .text(let messageText):
                message = messageText
            case .attributedText(_):
                break
            case .photo(_):
                break
            case .video(_):
                break
            case .location(_):
                break
            case .emoji(_):
                break
            case .audio(_):
                break
            case .contact(_):
                break
            case .linkPreview(_):
                break
            case .custom(_):
                break
            }
            
            let newConversation:[String:Any] = [
                "id":"conversation_\(firstMessage.messageId)",
                "other_user_email":otherUserEmail,
                "latest_message":[
                    "date":sendDate,
                    "message":message,
                    "is_read":false
                ]
            ]
            
            if var conversations = userNode[FBCollectionName.CONVERSATIONS] as? [[String:Any]]{
                // conversation array exists for current user
                // append new conversation
                
                
                conversations.append(newConversation)
                
                userNode[FBCollectionName.CONVERSATIONS] = conversations
                
                ref.setValue(userNode) { error, _ in
                    guard error == nil else {
                       completion(false)
                        return
                    }
                    completion(true)
                }
            }else{
                
                // no conversation found
                // create new one
                
                userNode[FBCollectionName.CONVERSATIONS] = [
                    newConversation
                ]
                ref.setValue(userNode) { error, _ in
                    guard error == nil else {
                       completion(false)
                        return
                    }
                    completion(true)
                }
            }
            
        }
        
        
    }
    func getAllConversations(for email:String,completion:@escaping(Result<String,Error>)->Void){
        
    }
    
    func getMessagesForConvarsation(with id:String,completion:@escaping(Result<String,Error>)->Void){
        
    }
    func sendMessage(to conversation:String,message:Message,completion:@escaping(Bool)->Void){
        
    }
    
}
