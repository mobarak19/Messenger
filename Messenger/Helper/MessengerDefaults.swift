
import Foundation
import FirebaseAuth

class MessengerDefaults{
    
    static let shared  = MessengerDefaults()
    
    enum MessengerDefaultsKeys:String{
        
        case kUserEmail = "kUserEmail"
        case kProfilePicUrl = "kProfilePicUrl"
        case kUserName = "kUserName"

    }
    
    var profilePicture : String{
        get{UserDefaults.standard.string(forKey: MessengerDefaultsKeys.kProfilePicUrl.rawValue) ?? ""}
        set{UserDefaults.standard.set(newValue,forKey: MessengerDefaultsKeys.kProfilePicUrl.rawValue)}
    }
    
    
    var userEmail : String{
        get{UserDefaults.standard.string(forKey: MessengerDefaultsKeys.kUserEmail.rawValue) ?? ""}
        set{UserDefaults.standard.set(newValue,forKey: MessengerDefaultsKeys.kUserEmail.rawValue)}
    }
    
    var userName : String{
        get{UserDefaults.standard.string(forKey: MessengerDefaultsKeys.kUserName.rawValue) ?? ""}
        set{UserDefaults.standard.set(newValue,forKey: MessengerDefaultsKeys.kUserName.rawValue)}
    }
    
    var isLoggedIn : Bool = FirebaseAuth.Auth.auth().currentUser != nil
}
