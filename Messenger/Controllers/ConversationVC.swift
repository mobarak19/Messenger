


import UIKit

class ConversationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !MessengerDefaults.shared.isLoggedIn{
            let vc = LoginVC()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: false)
        }
    }


}

