


import UIKit
import FirebaseAuth
class ConversationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observeLoginStatus()
        
    }

    func observeLoginStatus(){
        if FirebaseAuth.Auth.auth().currentUser == nil{
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false)
        }

    }

}

