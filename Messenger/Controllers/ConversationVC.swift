


import UIKit
import FirebaseAuth
class ConversationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        try! FirebaseAuth.Auth.auth().signOut()
        observeLoginStatus()
        
    }

    func observeLoginStatus(){
     // try! FirebaseAuth.Auth.auth().signOut()
        if FirebaseAuth.Auth.auth().currentUser == nil{
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false)
        }

    }

}

