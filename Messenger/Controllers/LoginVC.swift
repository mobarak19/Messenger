//
//  LoginVC.swift
//  Messenger
//
//  Created by Genusys Inc on 7/20/22.
//

import UIKit

class LoginVC: UIViewController {

    private var logoImg:UIImageView  = {
        let img = UIImageView(image: UIImage(named: "messenger"))
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let scrollView:UIScrollView = {
        let scrollView  = UIScrollView()
        return scrollView
    }()
    private let emailField:UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        return field
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Log In"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTappedRegister))
        view.addSubview(logoImg)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.width/3
        logoImg.frame = CGRect(x: (view.width - size)/2 , y: 80, width: size, height: size)
    }
    
    @objc func didTappedRegister(){
        let vc = RegistrationVC()
      
        vc.title = "Create Account"
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }

}
