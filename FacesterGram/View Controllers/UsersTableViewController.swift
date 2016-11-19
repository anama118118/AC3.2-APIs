//
//  UsersTableViewController.swift
//  FacesterGram
//
//  Created by Louis Tur on 10/21/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    // Describe what these three keywords indicate about UserTableViewCellIdentifier
    private static let UserTableViewCellIdentifier: String = "UserTableViewCellIdentifier"
    
    internal var userObjects = [User]()
    //let url = "https://randomuser.me/api/"
    
    //    let APIRequestManger = APIRequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.loadUsers()
        userObjects = APIRequestManager.manager.loadUsersSettings()
        
        self.refreshControl?.addTarget(self, action: #selector(refreshRequested(_:)), for: .valueChanged)
    }
    
    func loadUsers() {
        APIRequestManager.manager.getRandomUserData { (data: Data?) in
            if data != nil {
                if let users = User.users(from: data!) {
                    print("We've got users! \(users)")
                    dump(users)
                    self.userObjects = users
                    APIRequestManager.manager.saveUsersSettings(users: self.userObjects, forKey: "user")
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            self.refreshControl?.endRefreshing()
        }
        
        let defaults = UserDefaults.standard
        print(defaults.dictionaryRepresentation())
        
        //        APIRequestManager.manager.getRandomUserData(endpoint: url ) { (data: Data?) in
        //                dump(data)
        //            self.userObject = User.users(from: data!)!
        //            print("USERS ARRAY: \(self.userObject)")
        //            DispatchQueue.main.async {
        //                self.tableView.reloadData()
        //            }
        //        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewController.UserTableViewCellIdentifier, for: indexPath)
        cell.textLabel?.text = "\(userObjects[indexPath.row].firstName) \(userObjects[indexPath.row].lastName)"
        cell.detailTextLabel?.text = userObjects[indexPath.row].username
        
        APIRequestManager.manager.getDataFromURLEndpoint(endpoint: userObjects[indexPath.row].thumbnailURL) { (data: Data?) in
            DispatchQueue.main.async {
                if let data = data {
                    cell.imageView?.image = UIImage(data: data)
                    cell.setNeedsLayout()
                }
            }
        }
        // Configure the cell...
        return cell
    }
    
    func refreshRequested(_ sender: UIRefreshControl) {
        self.loadUsers()
    }
    
}
