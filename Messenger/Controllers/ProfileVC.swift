

import UIKit
import JGProgressHUD
class ProfileVC: UIViewController {
    let spinner = JGProgressHUD(style: .light)

    @IBOutlet var tableView:UITableView!
    var data:[String] = ["Log Out"]
    
    let authVM = AuthVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableHeaderView = createHeaderView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    func createHeaderView()->UIView?{
        
        let email = MessengerDefaults.shared.userEmail
        guard !email.isEmpty else{
            return nil
        }
        let fileName = email.makeFirebaseDatabaseKey() + Constants.PROFILE_PICTURE_POSTFIX
        let path = "/images/" + fileName
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 250))
        headerView.backgroundColor = .systemBackground
        
        let imageView = UIImageView(frame: CGRect(x: (headerView.width-150)/2, y: 50, width: 150, height: 150))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        imageView.layer.cornerRadius = imageView.width/2
        imageView.layer.masksToBounds = true
        headerView.addSubview(imageView)
        spinner.show(in: headerView)
        
        self.authVM.downloadURL(with: path) { result in
            switch result{
            case .success(let urlString):
                self.downloadImage(imageView:imageView,url:urlString)
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.spinner.dismiss(animated: true)
                }
            }
        }
        return headerView
    }
    
    func downloadImage(imageView:UIImageView,url:URL){
        
        URLSession.shared.dataTask(with: url,completionHandler: { data, _, error in
           
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    self.spinner.dismiss(animated: true)
                }
                return
            }
            DispatchQueue.main.async {
                self.spinner.dismiss(animated: true)

                let image = UIImage(data: data)
                imageView.image = image
            }
            
        }).resume()
    }
}

extension ProfileVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.signOutAction()
        
    }
    
    func signOutAction(){
        
        let alert  = UIAlertController(title: "Are you sure to", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: {[weak self] _ in
            
            self?.authVM.signOut { success in
                
                if success{
                    let vc = LoginVC()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self?.present(nav, animated: true)
                }else{
                    print("Could not log out")
                }
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        self.present(alert, animated: true)
        
    }
    
}
