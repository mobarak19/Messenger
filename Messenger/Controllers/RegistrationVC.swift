//
//  RegistrationVC.swift
//  Messenger
//
//  Created by Genusys Inc on 7/20/22.
//

import UIKit

class RegistrationVC: UIViewController {
    
    private var logoImg:UIImageView  = {
        let img = UIImageView(image: UIImage(systemName: "person"))
        img.contentMode = .scaleAspectFit
        img.tintColor = .gray
        return img
    }()
    
    private let scrollView:UIScrollView = {
        let scrollView  = UIScrollView()
        return scrollView
    }()
    
    private let firstNameField:UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let lastNameField:UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
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
    
    private let confirmPasswordField:UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Confirm Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.isSecureTextEntry = true
        return field
    }()
    
    private let registerBtn:UIButton = {
        let btn = UIButton()
        btn.setTitle("Register", for: .normal)
        btn.backgroundColor = .link
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(logoImg)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        
        scrollView.addSubview(emailField)
        
        scrollView.addSubview(passwordField)
        scrollView.addSubview(confirmPasswordField)
        
        scrollView.addSubview(registerBtn)
        
        emailField.delegate = self
        passwordField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self
        
        confirmPasswordField.delegate = self
        registerBtn.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        let tapped = UITapGestureRecognizer(target: self, action: #selector(onTappedImage))
        tapped.numberOfTapsRequired = 1
        tapped.numberOfTouchesRequired = 1
        logoImg.isUserInteractionEnabled = true
        logoImg.addGestureRecognizer(tapped)
        
    }
    
   @objc  func onTappedImage(){
        print("onTappedImage")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        
        logoImg.frame = CGRect(x: (scrollView.width - size)/2 , y: 30, width: size, height: size)
        
        firstNameField.frame = CGRect(x: 30 , y:logoImg.bottom + 10, width: scrollView.width - 60, height: 52)
        lastNameField.frame = CGRect(x: 30 , y:firstNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        
        emailField.frame = CGRect(x: 30 , y:lastNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        
        passwordField.frame = CGRect(x: 30 , y:emailField.bottom + 10, width: scrollView.width - 60, height: 52)
        
        confirmPasswordField.frame = CGRect(x: 30 , y:passwordField.bottom + 10, width: scrollView.width - 60, height: 52)
        
        registerBtn.frame = CGRect(x: 30 , y:confirmPasswordField.bottom + 10, width: scrollView.width - 60, height: 52)
        
        
    }
    
    
    @objc  func registerUser(){
        
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
        
        guard let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              let confirmPass = confirmPasswordField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count>=6,
              password==confirmPass else{
            
            userRegistrationErrorAlert()
            
            return
        }
        
        //firebase register user
        
    }
    
    func userRegistrationErrorAlert(){
        let alert  = UIAlertController(title: "Woops", message: "Please enter all informartion to create a new account.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        self.present(alert, animated: true)
    }
}

extension RegistrationVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameField{
            
            lastNameField.becomeFirstResponder()
            
        }else if textField == lastNameField{
            
            emailField.becomeFirstResponder()
            
        }else if textField == emailField{
            
            passwordField.becomeFirstResponder()
            
        }else if textField == passwordField{
            
            confirmPasswordField.becomeFirstResponder()
            
        }else if textField == confirmPasswordField{
            
            registerUser()
        }
        return true
    }
}
