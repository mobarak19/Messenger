

import Foundation

class AuthVM{
    
    private var repo:AuthRepoImp?
    
    init() {
        
        self.repo = AuthRepoImp.shared
    }
    
    func createUser(with email:String,password:String,completion:@escaping (Result<Bool,AuthError>)->Void){
        self.repo?.createUser(with: email, password: password, completion: completion)
    }
    
    func signIn(with email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        
        self.repo?.signIn(with: email, password: password, completion: completion)
    }
    
    func signOut(completion:@escaping (Bool)->Void){
        self.repo?.signOut(completion: completion)
    }
    
    func isUserExsists(with email:String, completion:@escaping (Bool)->Void){
        self.repo?.isUserExsists(with: email, completion: completion)
    }
    
    func insertUser(with user:UserModel, completion:@escaping (Bool)->Void){
        self.repo?.insertUser(user: user, completion: completion)
    }
    func uploadProfilePic(with data:Data,filename:String,completion:@escaping (Result<String,Error>)->Void){
        self.repo?.uploadProfilePic(with: data, filename: filename, completion: completion)
    }
    func downloadURL(with path:String,completion:@escaping (Result<URL,Error>)->Void){
        self.repo?.downloadURL(with: path, completion: completion)
    }

}
