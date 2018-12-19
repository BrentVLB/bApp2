//
//  Login.swift
//  BiedingApp
//
//  Created by student on 05/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import Foundation

class Login{
    var userMail:String
    var pass:String
    var uid:String
    
    init() {
        self.userMail = ""
        self.pass = ""
        self.uid = ""
    }
    
    
    func setMail(newMail:String){
        userMail = newMail
    }
    
    func setPass(newPass:String){
        pass = newPass
    }
    
    func setUid(newUid:String){
        uid = newUid
    }
    
    func getMail() -> String {
        return userMail
    }
    
    func getPass() -> String {
        return pass
    }
    
    func getUid() -> String {
        return uid
    }
}
