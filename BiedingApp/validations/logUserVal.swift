//
//  logUserVal.swift
//  BiedingApp
//
//  Created by student on 05/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import Foundation
import Firebase

class LogUserVal {
    static func valLogin(mail:String, pass:String, listener: LoginValidationProtocol){
        
        Auth.auth().signIn(withEmail: mail, password: pass) { (user, error) in
            var log = Login()
            if let erM = error?.localizedDescription{
               
                listener.loginCompleted(login: log, error: erM)
            }
            else
            {
                log.setMail(newMail: (user?.user.email)!)
                log.setUid(newUid: (user?.user.uid)!)
                listener.loginCompleted(login: log, error: "")
            }
            
        }
        
    }
}

protocol LoginValidationProtocol {
    func loginCompleted(login:Login?, error:String?)
}
