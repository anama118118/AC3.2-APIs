//
//  APIRequestManager.swift
//  FacesterGram
//
//  Created by Louis Tur on 10/21/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal class APIRequestManager {
    // 1. manager instance
    static let manager: APIRequestManager = APIRequestManager()
    // 2. private in it
    private init (){}
    //3. function, remeber the @escaping thing cause objective C and some stuff. That data can escape the scope of the function
    //Use a callback closure to handle the returned Data
    func getRandomUserData(completion: @escaping ((Data?)->Void)) {
        //Send a request to the random user API endpoint
        guard let url: URL = URL(string: "https://randomuser.me/api/?results=\(SettingsManager.manager.results)&gender=\(SettingsManager.manager.gender)") else {return}
        //4.session
        let session = URLSession.init(configuration: .default)
        session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            //5. error handling
            //Do some basic error checking
            if error != nil {
                print("There's an error!!!! ***************** \(error)")
            }
            //Get the data out
            guard let validData = data else {
                return
            }
            //Do something with the data
            completion(validData)
            //6. callback
            }.resume()
    }
    
    func getDataFromURLEndpoint (endpoint: String, completion: @escaping ((Data?)->Void)) {
        let url: URL = URL(string: endpoint)!
        
        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountered in API request: \(error?.localizedDescription)")
            }
            
            if data != nil {
                print("Data returned in response")
                completion(data)
            }
            
            }.resume()
    }
    
    func getRandom(user:Int = SettingsManager.manager.results, gender: UserGender, nationality: UserNationality = .all , completion: @escaping ((Data?) -> Void)) {
        //use the questionmark to debug less
        let newURL: URL = URL(string: "https://randomuser.me/api/?results=\(user))&gender=\(gender.rawValue)&nat=\(nationality.rawValue)")!
        print(newURL)
        
        let session: URLSession = URLSession(configuration: .default)
        session.dataTask(with: newURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("Error encountered in API requestion: \(error?.localizedDescription)")
            }
            if data != nil {
                print("Data returned in response")
                completion(data)
            }
            }.resume()
    }
    
    func makeUserDictionary(from user: User) -> [String: String] {
        var oneUser = [String:String]()
        oneUser["username"] = user.username
        oneUser["lastName"] = user.lastName
        oneUser["firstName"] = user.firstName
        oneUser["id"] = user.id
        oneUser["thumbnailURL"] = user.thumbnailURL
        oneUser["emailAddress"] = user.emailAddress
        oneUser["city"] = user.city
        oneUser["state"] = user.state
        return oneUser
    }
    
    func deleteDefaultSettings() {
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "user")
    }
    
    func saveUsersSettings(users array:[User], forKey key:String){
        let defaults = UserDefaults.standard
        var defaultDict = [[String: String]]()
        
        for user in array{
            let c = self.makeUserDictionary(from: user)
            defaultDict.append(c)
        }
        print(defaultDict)
        defaults.set(defaultDict, forKey: key)
        print(defaults.dictionaryRepresentation())
    }
    
    func loadUsersSettings() -> [User] {
        let defaults = UserDefaults.standard
        var appendUsers = [User]()
        if let defaultsUsers = defaults.value(forKey: "user") as? [[String:String]] {
            for user in defaultsUsers {
                guard let username = user["username"],
                    let lastName = user["lastName"],
                    let firstName = user["firstName"],
                    let id = user["id"],
                    let thumbnailURL = user["thumbnailURL"],
                    let emailAddress = user["emailAddress"],
                    let city = user["city"],
                    let state = user["state"] else { return appendUsers }
                appendUsers.append(User(firstName: firstName, lastName: lastName, city: city, state: state, username: username, emailAddress: emailAddress, id: id, thumbnailURL: thumbnailURL))
            }
        }
    return appendUsers
    }
}
