//
//  NewConversationVC.swift
//  Messenger
//
//  Created by Genusys Inc on 7/20/22.
//

import UIKit
import JGProgressHUD

class NewConversationVC: UIViewController {

    private let spinner = JGProgressHUD(style: .dark)
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
        dismiss(animated: true)
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
        spinner.show(in: view)
        self.searchUsers(query:text)
    }
    func searchUsers(query:String){
        //check if array has firebase results
        //if it does:filter
        //if not, fetch then filter
        //update the UI: either show results or show no results label
    }
}


extension NewConversationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello world"
        return cell
    }
    
    
}
