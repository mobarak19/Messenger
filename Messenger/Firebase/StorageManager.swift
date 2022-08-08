//
//  StorageManager.swift
//  Messenger
//
//  Created by Genusys Inc on 8/8/22.
//

import Foundation
import FirebaseStorage

class StorageManager{
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference().child(Constants.APP_DATABASE_NAME)
    
    func uploadProfilePicture(with data:Data,filename:String,completion:@escaping (Result<String,Error>)->Void){
        storage.child("images/\(filename)").putData(data, metadata: nil) { metadata, error in
            guard error == nil else{
                print("Failed to upload profilepic")
                completion(.failure(StorageError.failedToUpload))
                return
            }
            self.storage.child("images/\(filename)").downloadURL(completion: {url,_ in
                guard let url = url else{
                    print("Failed to download url")
                    completion(.failure(StorageError.failedToDownloadUrl))
                    return
                }
                
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            })
            
        }
         
    }
    
    
    func downloadURL(for path:String,completion:@escaping(Result<URL,Error>)->Void){
        
        self.storage.child(path).downloadURL(completion: {url,_ in
            
            guard let url = url else{
                print("Failed to download url")
                completion(.failure(StorageError.failedToDownloadUrl))
                return
            }

            completion(.success(url))
        })
    }
 
    
}
