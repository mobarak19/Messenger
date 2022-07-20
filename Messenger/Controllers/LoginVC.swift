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
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
        
    private let passwordField:UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Log In"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTappedRegister))
        view.addSubview(scrollView)
        scrollView.addSubview(logoImg)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        
        logoImg.frame = CGRect(x: (scrollView.width - size)/2 , y: 30, width: size, height: size)
        
        emailField.frame = CGRect(x: 30 , y:logoImg.bottom + 10, width: scrollView.width - 60, height: 52)
        passwordField.frame = CGRect(x: 30 , y:emailField.bottom + 10, width: scrollView.width - 60, height: 52)

    }
    
    @objc func didTappedRegister(){
        
        let vc = RegistrationVC()
        vc.title = "Create Account"
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }

}
