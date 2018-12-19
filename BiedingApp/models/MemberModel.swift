//
//  MemberModel.swift
//  BiedingApp
//
//  Created by student on 06/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import Foundation

class MemberModel{
    var id: String
    var name: String
    var birthDate: Date
    var uid: String
    
    init()
    {
        self.id = ""
        self.name = ""
        self.birthDate = Date()
        self.uid = ""
    }
    
    func getId() -> String {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getBirthDate() -> Date {
        return birthDate
    }
    
    func getUid() -> String {
        return uid
    }
    
    func setId(newId: String) {
        self.id = newId
    }
    
    func setName(newName: String) {
        self.name = newName
    }
    
    func setBirthDate(newBirthDate: Date) {
        self.birthDate = newBirthDate
    }
    
    func setUid(newUid: String) {
        self.uid = newUid
    }
}
