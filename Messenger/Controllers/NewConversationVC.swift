//
//  NewConversationVC.swift
//  Messenger
//
//  Created by Genusys Inc on 7/20/22.
//

import UIKit
import JGProgressHUD

class NewConversationVC: UIViewController {

    var completion:(([String:String])->Void)?
    
    private let spinner = JGProgressHUD(style: .dark)
    
    private var users = [[String:String]]()
    
    private var results = [[String:String]]()

    private var hasFetched = false
    
    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for users..."
        return searchBar
    }()
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    } ()
    
    private let noResultLbl :  UILabel = {
        let lbl = UILabel()
        lbl.text = "No Results"
        lbl.textColor = .gray
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 21, weight: .medium)
        lbl.isHidden = true
        return lbl
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchBar.delegate = self
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissSelf))
        
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.becomeFirstResponder()
    }
    
    @objc func dismissSelf(){
        dismiss(animated: true,completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        noResultLbl.frame = view.bounds
    }

}

extension NewConversationVC:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,!text.replacingOccurrences(of: " ", with: "").isEmpty else{
            return
        }
        searchBar.resignFirstResponder()
        results.removeAll()
        spinner.show(in: view)
        self.searchUsers(query:text)
    }
    func searchUsers(query:String){
        //check if array has firebase results
        if hasFetched{
            //if it does:filter
            filterUsers(with: query)
        }else{
            //if not, fetch then filter

            DatabaseManager.shared.getAllUsers { result in
                self.spinner.dismiss(animated: true)
                switch result{
                case .success(let userCollection):
                    print(userCollection)
                    self.users = userCollection
                    self.hasFetched = true

                    self.filterUsers(with: query)
                    
                case .failure(let error):
                    print("error",error.localizedDescription)
                }
            }
        }
        
        //update the UI: either show results or show no results label
    }
    func filterUsers(with term:String){
        
        guard hasFetched else {
            return
        }
        let filteredResults = self.users.filter ({
            guard let name = $0["name"]?.lowercased() else{
                return false
            }
            return name.hasPrefix(term.lowercased())
        })
        self.results = filteredResults
        updateUI()
    }
    
    func updateUI(){
        if results.isEmpty{
            self.tableView.isHidden = true
            self.noResultLbl.isHidden = false
        }else{
            self.noResultLbl.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}


extension NewConversationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results[indexPath.row]["name"]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let targetUser = results[indexPath.row]
        
        dismiss(animated: true,completion: { [weak self] in
            
            self?.completion?(targetUser)
        
        })

    }
    
    
}
