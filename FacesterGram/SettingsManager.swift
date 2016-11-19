//
//  SettingsManager.swift
//  FacesterGram
//
//  Created by Ana Ma on 10/27/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation

enum UserGender: String {
    case male, female, both
}

enum UserNationality: String {
    case AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IR, NL, NZ, TR, US
    case all = ""
    static func allNatEnums() -> [UserNationality] {
        return [AU, BR, CA, CH, DE, DK, ES, FI, FR, GB, IE, IR, NL, NZ, TR, US]
    }
}



enum UserField: String {
    case gender, name, location, email, login, id, picture, nat, none
    
    static func allFieldEnums() -> [UserField] {
        return [gender, name, location, email, login, id, picture, nat]
    }
}

class SettingsManager: SliderCellDelegate, SegmentedCellDelegate, SwitchCellDelegate {
    
    static let manager: SettingsManager = SettingsManager()
    
    var results: Int
    var gender: UserGender
    //var nationality: UserNationality
    //var excluded: UserField
    var nationality: [UserNationality]
    var included: [UserField]
    
    var minResults: Int = 1
    var maxResults: Int = 200
    
    private init() {
        self.results = 1
        self.gender = .both
        self.nationality = UserNationality.allNatEnums()
        self.included = UserField.allFieldEnums()
    }
    
//    init (results: Int ,gender: UserGender, nationality: UserNationality, excluded: UserField, minResults: Int, maxResults: Int ){
//        self.results = results
//        self.gender = gender
//        self.nationality = nationality
//        self.excluded = excluded
//        self.minResults = minResults
//        self.maxResults = maxResults
//    }
    
    //save what you put in last in the setting
    //what is setting manager is going to update
    
    
    // SwitchCellDicts
    var userNationalitySwitchStatus: [UserNationality : Bool] = [
        UserNationality.AU : true, UserNationality.BR: true,
        UserNationality.CA : true, UserNationality.CH : true,
        UserNationality.DE : true, UserNationality.DK : true,
        UserNationality.ES : true, UserNationality.FI : true,
        UserNationality.FR : true, UserNationality.GB : true,
        UserNationality.IE : true, UserNationality.IR : true,
        UserNationality.NL : true, UserNationality.NZ : true,
        UserNationality.TR : true, UserNationality.US : true
    ]
    var userFieldsSwitchStatus: [UserField : Bool] = [
        UserField.gender : true, UserField.name : true,
        UserField.location : true, UserField.email : true,
        UserField.login : true, UserField.id : true,
        UserField.picture : true, UserField.nat : true
    ]
    
    // We need to ensure a specified order
    var sortedNationalityKeys: [String] {
        return userNationalitySwitchStatus.keys.map{ $0.rawValue }.sorted(by: >)
    }
    var sortedFieldKeys: [String] {
        return userFieldsSwitchStatus.keys.map { $0.rawValue }.sorted(by: >)
    }
    
    func updateNumberOfResults(_ results: Int){
        if results < 1 { self.results = 1 }
        else if results > 200 { self.results = 200 }
        else {
            self.results = results
        }
    }
    
    func updateGenderResults(_ results: Int) {
        switch results {
        case 0 :
            self.gender = .both
        case 1:
            self.gender = .male
        case 2:
            self.gender = .female
        default:
            self.gender = .both
        }
    }
    
    // MARK: - Helpers
    func validNationalities() -> [UserNationality] {
        return validValues(self.userNationalitySwitchStatus)
    }
    
    func validValues<T: Hashable>(_ dict: [T : Bool]) -> [T] {
        var returnValues: [T] = []
        for (key, value) in dict {
            if value == true {
                returnValues.append(key)
            }
        }
        return returnValues
    }

    
    // MARK: - Slider Cell Delegate
    func sliderDidChange(_ value: Int) {
        self.updateNumberOfResults(value)
    }
    
    //Mark: - Segmented Cell Delegate
    func segmentValueChanged(_ value: Int){
        self.updateGenderResults(value)
    }
    
    // MARK: - Switch Cell Delegate
    func selectionDidChange(option: String, value: Bool) {
        
        // we maintain two internal dictionaries corresponding to our nationalities and fields
        // We do a nil-check to see if we can create the enum using the String option passed
        if let userNationality = UserNationality(rawValue: option) {
            self.userNationalitySwitchStatus[userNationality] = value
        }
        
        if let userField = UserField(rawValue: option) {
            self.userFieldsSwitchStatus[userField] = value
        }
    }
    
}
