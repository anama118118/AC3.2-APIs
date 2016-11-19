//
//  User.swift
//  FacesterGram
//
//  Created by Louis Tur on 10/21/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

internal enum UserModelParseError: Error {
    case results, name, location, login, id, picture
    case email(json: AnyObject)
}

internal struct User {
    internal let firstName: String
    internal let lastName: String
    internal let city: String
    internal let state: String
    internal let username: String
    internal let emailAddress: String
    internal let id: String
    internal let thumbnailURL: String
    
    static func users(from data: Data) -> [User]? {
        var usersToReturn: [User]? = []
        
        do {
            // 1. Attempt to serialize data
            let jsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            // 2. begin parsing to our array of user data objects
            guard let response: [String : AnyObject] = jsonData as? [String : AnyObject],
                let results: [AnyObject] = response["results"] as? [AnyObject] else {
                    throw UserModelParseError.results
            }
            
            // 3. Iterrate over each element
            for userResult in results {
                print("userResult: \(userResult)")
                
                // 4. parse out name
                guard
                    let name: [String : String] = userResult["name"] as? [String : String],
                    let first: String = name["first"],
                    let last: String = name["last"]
                    else { throw UserModelParseError.name }
                
                // 5. parse out location
                // ** There will be some problems here: doing [String : String] will occasionally fail since some of the fields are interpreted as Int
                // ** Switch to [String : AnyObject] followed by further type casting **
                guard
                    let location: [String : AnyObject] = userResult["location"] as? [String : AnyObject],
                    let city: String = location["city"] as? String,
                    let state: String = location["state"] as? String
                    else { throw UserModelParseError.location }
                
                // 6. parse out user name
                guard
                    let login: [String : String] = userResult["login"] as? [String : String],
                    let username: String = login["username"]
                    else { throw UserModelParseError.login }
                
                // 7. parse out id
                // ** There will be another problem here: depending on nationality, idValue will be nill **
                // ** Good place to handle errors gracefully **
                // ** Options here include making the id optional, or generating a random one, or accepting that this will always return nil
                guard
                    let id: [String : AnyObject] = userResult["id"] as? [String : AnyObject]//,
                    //let idValue: String = id["value"] ?? "N/A"
                    else { throw UserModelParseError.id }
                
                // 8. parse out image URLs
                guard
                    let pictures: [String : String] = userResult["picture"] as? [String : String],
                    let thumbnail: String = pictures["thumbnail"]
                    else { throw UserModelParseError.picture }
                
                // 9. the rest
                guard let email: String = userResult["email"] as? String else { throw UserModelParseError.email(json: userResult)}
                
                let validUser: User = User(firstName: first,
                                           lastName: last,
                                           city: city,
                                           state: state,
                                           username: username,
                                           emailAddress: email,
                                           id: (id["value"] as? String) ?? "N/A",
                                           thumbnailURL: thumbnail)
                
                usersToReturn?.append(validUser)
            }
            
            return usersToReturn
        }
        catch UserModelParseError.results {
            print("Could Not Locate Result Key")
        }
        catch let UserModelParseError.email(json) {
            print("Could Not Locate Email Key \(json)")
        }
        
        catch UserModelParseError.location {
            print("Could Not Locate Location Key")
        }
            
        catch UserModelParseError.name {
            print("Could Not Locate Name Key")
        }
            
        catch {
            print("Error encountered with JSONSerialization: \(error)")
        }
        return nil
    }
    
}

//internal struct User {
//    internal let firstName: String //
//    internal let lastName: String //
//    internal let city: String
//    internal let state: String
//    internal let username: String //
//    internal let emailAddress: String
//    //internal let id: String //because it's optional
//    internal let thumbnailURL: String
//    
//    static func users(from data: Data) -> [User]? {
//        do{
//            let userJsonData: Any = try JSONSerialization.jsonObject(with: data, options: [])
//            
//            guard let userCasted : [String: AnyObject] = userJsonData as? [String: AnyObject]
//                else {
//                    print("There was an error casting to [String:AnyObject] (userCasted) \(userJsonData)")
//                    throw UserModelParseError.results
//            }
//            //print("Users Created \(userCasted)")
//            
//            guard let info: [AnyObject] = userCasted["results"] as? [AnyObject] else {
//                print("There was an error casting to [AnyObject] (info) \(userCasted)")
//                return nil
//            }
//            //print("Users Created \(info)")
//            
//            var user: [User] = []
//            for dict in info{
//                guard let name = dict["name"] as? [String:String],
//                    let firstName = name["first"],
//                    let lastName = name["last"] else {
//                    print("There was an error casting to [String:String] (firstName, lastName) \(dict)")
//                    return nil
//                }
//                //print("lastName and firstName Created \(firstName) \(lastName)")
//                
//                guard let login = dict["login"] as? [String: String],
//                    let userName = login["username"] else {
//                    print("There was an error casting to [String:String] (login) \(dict)")
//                        return nil
//                }
//                //print("userName \(userName)")
//                
//                guard let location = dict["location"] as? [String: Any],
//                    let city = location["city"] as? String,
//                    let state = location["state"] as? String else {
//                        print("There was an error casting [String:Any](location) \(dict)")
//                        return nil
//                }
//                //print("city: \(city), state: \(state)")
//                
//                guard let picture = dict["picture"] as? [String: String],
//                    let thumbnailURL = picture["thumbnail"] else {
//                        print("There was an error casting [String: String] (picture) \(dict)")
//                        return nil
//                }
//                //print("Thumbnail: \(thumbnailURL)")
//                
//                guard let email = dict["email"] as? String else {
//                    print("There was an error casting String (email) \(dict)")
//                    return nil
//                }
//                //print("eamil: \(email)")
//                
//                user.append(User(firstName: firstName, lastName: lastName, city: city, state: state, username: userName, emailAddress: email, thumbnailURL: thumbnailURL))
//            }
//            return user
//        } catch {
//            print(error)
//        }
//        return nil
//    }
//}
/*
 {
 "results": [
 {
 "gender": "female",
 "name": {
 "title": "mrs",
 "first": "feride",
 "last": "van fessem"
 },
 "location": {
 "street": "6266 stadsbuitengracht",
 "city": "putten",
 "state": "noord-holland",
 "postcode": 43818
 },
 "email": "feride.vanfessem@example.com",
 "login": {
 "username": "tinyostrich538",
 "password": "evolutio",
 "salt": "9k46oRa1",
 "md5": "05620fb96f4c2c08d3e8d44e2ebf1bdc",
 "sha1": "c8f98f7985c5b3d37037799e72618124a6b4abf8",
 "sha256": "1b294907173b7d459d096b163c2527b70baf98652a0fcbe772e6496be2c921e8"
 },
 "dob": "1971-11-24 03:12:32",
 "registered": "2012-06-22 02:19:42",
 "phone": "(649)-458-9614",
 "cell": "(162)-375-4346",
 "id": {
 "name": "BSN",
 "value": "68365325"
 },
 "picture": {
 "large": "https://randomuser.me/api/portraits/women/36.jpg",
 "medium": "https://randomuser.me/api/portraits/med/women/36.jpg",
 "thumbnail": "https://randomuser.me/api/portraits/thumb/women/36.jpg"
 },
 "nat": "NL"
 }
 ],
 "info": {
 "seed": "7b9b6ddfb32463ac",
 "results": 1,
 "page": 1,
 "version": "1.1"
 }
 }
 */
