//
//  rootViewController.swift
//  BiedingApp
//
//  Created by student on 28/11/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import UIKit
import Firebase


class rootViewController: UIViewController, LoginValidationProtocol, memberProtocol {
    
    
    
    
    
    
    let v = 1
    
    @IBOutlet weak var mailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToAddUser(_ sender: Any) {
        var secondVC = self.storyboard?.instantiateViewController(withIdentifier: "addUser") as! newUserViewController
         
        self.navigationController?.show(secondVC, sender: self)     }
    
    
    @IBAction func signInUser(_ sender: Any) {
        
        guard let uName = mailTextField.text else {
            return
        }
        
        guard let pass = passwordTextField.text else {
            return
        }
        
        LogUserVal.valLogin(mail: uName, pass: pass, listener: self)
        
    }
    
    func loginCompleted(login: Login?, error: String?) {
        if(error == "")
        {
           
            var lidDAO = MemberDAO()
            var lidToSearch = MemberModel()
            lidToSearch.setUid(newUid: (login?.getUid())!)
            lidDAO.getMember(membertoGet: lidToSearch,listener: self)
            
        }
        else
        {
            errorLabel.text = error
        }
        
    }
    
    func getMemberCompleted(member: MemberModel, error: String?) {
        if(error == "")
        {
            errorLabel.text = ""
            var itemVC = self.storyboard?.instantiateViewController(withIdentifier: "itemVC") as! ItemsTableViewController
            itemVC.setLoggedUser(userToLog: member)
            itemVC.getArt()
           
            
        self.navigationController?.show(itemVC, sender: self)
            
        }
            
    
        else
        {
            errorLabel.text = error
        }
    }
}
