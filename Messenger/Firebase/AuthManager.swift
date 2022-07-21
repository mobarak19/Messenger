//
//  AuthManager.swift
//  Messenger
//
//  Created by Genusys Inc on 7/21/22.
//

import Foundation
import FirebaseAuth

enum AuthError:Error{
    case errorCreatingUser
    case signOutError
}


class AuthManager{
    static let shared = AuthManager()
    
    func createUser(with email:String,password:String,completion: @escaping (Result<Bool,AuthError>)->Void){
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error == nil{
                completion(.success(true))
            }else{
                completion(.failure(.errorCreatingUser))
            }
            
        }
    }
    
    func signIn(with email:String,password:String,completion: @escaping (Result<String,AuthError>)->Void){
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            if error == nil{
                completion(.success(result?.user.email ?? ""))
            }else{
                completion(.failure(.errorCreatingUser))
            }
            
        }
    }
    func signOut(completion:@escaping (Bool)->Void){
        do{
            
           try! FirebaseAuth.Auth.auth().signOut()
            completion(true)
            
        }catch{
            completion(false)
            
        }
    }
    
}
