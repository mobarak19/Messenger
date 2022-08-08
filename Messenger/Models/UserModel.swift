//
//  UserModel.swift
//  Messenger
//
//  Created by Genusys Inc on 7/21/22.
//

import Foundation

struct UserModel:Codable{
    let firstName:String
    let lastName:String
    let email:String
    var profilePicureUrl:String {
        return "\(email.makeFirebaseDatabaseKey())\(Constants.PROFILE_PICTURE_POSTFIX)"
    }
}
