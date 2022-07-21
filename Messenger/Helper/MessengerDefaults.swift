
import Foundation
import FirebaseAuth

class MessengerDefaults{
    
    static let shared  = MessengerDefaults()
    
    enum MessengerDefaultsKeys:String{
        
        case kIsLoggedIn = "kIsLoggedIn"
        
    }
    
//    var isLoggedIn : Bool{
//        get{UserDefaults.standard.bool(forKey: MessengerDefaultsKeys.kIsLoggedIn.rawValue)}
//        set{UserDefaults.standard.set(newValue,forKey: MessengerDefaultsKeys.kIsLoggedIn.rawValue)}
//    }
    
    var isLoggedIn : Bool = FirebaseAuth.Auth.auth().currentUser != nil
}
