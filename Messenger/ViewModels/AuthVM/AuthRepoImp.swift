//
//  RegistrationRepoImp.swift
//  Messenger
//
//  Created by Genusys Inc on 7/21/22.
//

import Foundation

class AuthRepoImp:AuthRepo{
    static let shared = AuthRepoImp()
    private var auth : AuthManager?
    private var db : DatabaseManager?

    init(){
        self.auth = AuthManager.shared
        self.db = DatabaseManager.shared
    }
    
    func createUser(with email: String, password: String, completion: @escaping (Result<Bool, AuthError>) -> Void) {
        
        self.auth?.createUser(with: email, password: password, completion: completion)
    }
    
    func signIn(with email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        
        self.auth?.signIn(with: email, password: password, completion: completion)
    }
    func signOut(completion: @escaping (Bool) -> Void) {
        
        self.auth?.signOut(completion: completion)
    }
    func isUserExsists(with email:String,completion:@escaping(Bool)->Void){
        self.db?.ifUserExist(email: email, completion: completion)
    }
    func insertUser(user: UserModel,completion:@escaping(Bool)->Void){
        self.db?.insertUser(user: user, completion: completion)

    }
}
