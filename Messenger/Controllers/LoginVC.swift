//
//  LoginVC.swift
//  Messenger
//
//  Created by Genusys Inc on 7/20/22.
//

import UIKit
import JGProgressHUD

class LoginVC: UIViewController {
    let spinner = JGProgressHUD(style: .dark)

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
        field.returnKeyType = .done
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
    
    private let loginBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Log In", for: .normal)
        btn.backgroundColor = .link
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return btn
    }()
    let authVM  = AuthVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Log In"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTappedRegister))
        view.addSubview(scrollView)
        scrollView.addSubview(logoImg)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginBtn)

        emailField.delegate = self
        passwordField.delegate = self
        
        emailField.text = "mobarak@gmail.com"
        passwordField.text = "123456"
        
        loginBtn.addTarget(self, action: #selector(didTappedLoggedIn), for: .touchUpInside)

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        
        logoImg.frame = CGRect(x: (scrollView.width - size)/2 , y: 30, width: size, height: size)
        
        emailField.frame = CGRect(x: 30 , y:logoImg.bottom + 10, width: scrollView.width - 60, height: 52)
        
        passwordField.frame = CGRect(x: 30 , y:emailField.bottom + 10, width: scrollView.width - 60, height: 52)
        
        loginBtn.frame = CGRect(x: 30 , y:passwordField.bottom + 10, width: scrollView.width - 60, height: 52)

    }
    
    @objc func didTappedLoggedIn(){
        
        emailField.resignFirstResponder()
        
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty,!password.isEmpty, password.count>=6 else{
            userLoginErrorAlert()
            return
        }
        spinner.show(in: view)
        //firebaase login
        authVM.signIn(with: email, password: password) { [weak self]result in
            DispatchQueue.main.async {
                self?.spinner.dismiss(animated: true)

            }
            switch result{
            case .success(let email):
                MessengerDefaults.shared.profilePicture = "urlString"
                MessengerDefaults.shared.userEmail = email
                self?.navigationController?.dismiss(animated: true)
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func userLoginErrorAlert(){
        let alert  = UIAlertController(title: "Woops", message: "Please enter all informartion to log in.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        self.present(alert, animated: true)
    }
    
    @objc func didTappedRegister(){
        
        let vc = RegistrationVC()
        vc.title = "Create Account"
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }

}


extension LoginVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            didTappedLoggedIn()
        }
        return true
    }
}
