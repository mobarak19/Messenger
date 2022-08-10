//
//  UserModel.swift
//  Messenger
//
//  Created by Genusys Inc on 7/21/22.
//

import Foundation
import MessageKit

struct Message:MessageType{
    
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
}

struct Sender:SenderType{
    
    var photoUrl : String
    var senderId: String
    
    var displayName: String
    
    
}

struct UserModel:Codable{
    let firstName:String
    let lastName:String
    let email:String
    var profilePicureUrl:String {
        return "\(email.makeFirebaseDatabaseKey())\(Constants.PROFILE_PICTURE_POSTFIX)"
    }
}
