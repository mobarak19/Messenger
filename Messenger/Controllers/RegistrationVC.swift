//
//  RegistrationVC.swift
//  Messenger
//
//  Created by Genusys Inc on 7/20/22.
//

import UIKit
import JGProgressHUD

class RegistrationVC: UIViewController {

    let spinner = JGProgressHUD(style: .dark)

    private var logoImg:UIImageView  = {
        let img = UIImageView(image: UIImage(systemName: "person.circle"))
        img.contentMode = .scaleAspectFit
        img.tintColor = .gray
        img.layer.masksToBounds = true
        img.layer.borderWidth = 2
        img.layer.borderColor = UIColor.lightGray.cgColor
        
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
    
    let authVM = AuthVM()
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
        
        emailField.text = "mobarak@gmail.com"
        firstNameField.text = "Mobarak"
        lastNameField.text = "Hossen"
        passwordField.text = "123456"
        confirmPasswordField.text = "123456"
        
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
       presentPhotoActionSheet()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        
        logoImg.frame = CGRect(x: (scrollView.width - size)/2 , y: 30, width: size, height: size)
        
        logoImg.layer.cornerRadius = size/2
        
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
        
        spinner.show(in: view)
        authVM.isUserExsists(with: email) { [weak self] response in
            if response{
                DispatchQueue.main.async {
                    self?.spinner.dismiss(animated: true)

                }
                print("User already exists, please log in")
                self?.userRegistrationErrorAlert(messege: "User already exists, please log in")
            }else{
                let user = UserModel(firstName: firstName, lastName: lastName, email: email)
                self?.insertUserIntoDatabase(with: user,password: password)
            }
        }
        
    }
    
    func insertUserIntoDatabase(with user:UserModel,password:String){
        
        
        authVM.createUser(with: user.email, password: password) {[weak self] response in
            switch response{
                
            case .success(let success):
                
                self?.authVM.insertUser(with: user, completion: { status in
               
                    if status {
                        print("User inserted success fully")
                        self?.uploadProfilePicture(user: user)

                    }else{
                        DispatchQueue.main.async {
                            self?.spinner.dismiss(animated: true)

                        }
                        print("Could not insert user")

                    }
                })
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.spinner.dismiss(animated: true)
                }
                print(error)
            }
        }

    }
    
    func uploadProfilePicture(user:UserModel){
        let image = logoImg.image
        guard let image = image, let imageData = image.pngData() else {
            return
        }

        self.authVM.uploadProfilePic(with: imageData, filename: user.profilePicureUrl) { result in
            switch result{
            case .success(let urlString):
                print(urlString)
                MessengerDefaults.shared.profilePicture = urlString
                MessengerDefaults.shared.userEmail = user.email

            case .failure(let error):
                print(error)
            }
        }
        
        self.navigationController?.dismiss(animated: true)

    }
    
    
    func userRegistrationErrorAlert(messege:String = "Please enter all informartion to create a new account."){
        let alert  = UIAlertController(title: "Woops", message: messege, preferredStyle: .alert)
        
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


extension RegistrationVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
        
        let actionsheet = UIAlertController(title: "Profile Picture", message: "How would you like to select a picture", preferredStyle: .actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionsheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: {[weak self]  _ in
            self?.presentCamera()

            print("Take a photo")
        }))
        actionsheet.addAction(UIAlertAction(title: "Chose Photo", style: .default, handler: {[weak self] _ in
            self?.presentPhotoLibrary()
            print("Chose a photo")
        }))

        self.present(actionsheet, animated: true)
        
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoLibrary(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        self.logoImg.image = selectedImage

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
