//
//  AddUserVal.swift
//  BiedingApp
//
//  Created by student on 05/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import Foundation
import Firebase


class AddUserVal {
    
    static func validate(name: String, email:String, password: String, birthDate:Date, listener: RegistrationValidationProtocol){
        
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            var log = Login()
            
            if let erM = error?.localizedDescription
            {
                listener.registrationCompleted(login: log, error: erM)
                
            }
            else
            {
                log.setMail(newMail: (user?.user.email)!)
                log.setPass(newPass: password)
                log.setUid(newUid: (user?.user.uid)!)
                listener.registrationCompleted(login: log, error: "")
            }
        }
        
        
        
        
        
        
        
        
    }
    
}

protocol RegistrationValidationProtocol {
    
    func registrationCompleted(login:Login?, error: String?)
    
}
