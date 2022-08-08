//
//  RegistrationRepo.swift
//  Messenger
//
//  Created by Genusys Inc on 7/21/22.
//

import Foundation

protocol AuthRepo{
    func createUser(with email:String,password:String,completion:@escaping (Result<Bool,AuthError>)->Void)
    func signIn(with email:String,password:String,completion:@escaping (Result<String,AuthError>)->Void)
    func signOut(completion:@escaping (Bool)->Void)
    func isUserExsists(with email:String,completion:@escaping(Bool)->Void)
    func insertUser(user: UserModel,completion:@escaping(Bool)->Void)
    func uploadProfilePic(with data:Data,filename:String,completion:@escaping (Result<String,Error>)->Void)
    func downloadURL(with path:String,completion:@escaping (Result<URL,Error>)->Void)
    
}
