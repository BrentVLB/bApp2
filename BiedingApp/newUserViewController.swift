//
//  newUserViewController.swift
//  BiedingApp
//
//  Created by student on 28/11/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import UIKit
import Firebase



class newUserViewController:UIViewController, RegistrationValidationProtocol {
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mailTextField: UITextField!
    
    
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
 

 
    @IBAction func addUser(_ sender: Any) {
      
        if (nameTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            errorLabel.text = "gelieve naam in te vullen"
            return
        }
        
      
    
        if (mailTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            errorLabel.text = "gelieve een mail in te geven"
            return
        }
        
        
        
        if (passTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
            errorLabel.text = "gelieve een wachtwoord in te geven"
            return
        }
        
       let geboorteDatum = birthDatePicker.date
        
    
        let year = Calendar.current.component(.year, from: geboorteDatum)
        
        let now = Date()
        let currentYear = Calendar.current.component(.year, from: now)
        
        if(currentYear-year < 18)
        {
            errorLabel.text = "te jong"
            return
        }
        AddUserVal.validate(name: nameTextField.text!, email: mailTextField.text!, password: passTextField.text!, birthDate: geboorteDatum, listener: self)
        
        
    }
    
    func registrationCompleted(login: Login?, error: String?) {
        if(error == "")
        {
            var lidDao = MemberDAO()
            var lidtoAdd = MemberModel()
            lidtoAdd.setName(newName: nameTextField.text!)
            lidtoAdd.setBirthDate(newBirthDate: birthDatePicker.date)
            lidtoAdd.setUid(newUid: (login?.getUid())!)
            
            lidDao.addNewMember(newLid: lidtoAdd)
            _ = self.navigationController?.popViewController(animated: true)
            
        }
        else
        {
            errorLabel.text = error
        }
    }
}
