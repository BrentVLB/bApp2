//
//  ArticleDetailViewController.swift
//  BiedingApp
//
//  Created by student on 20/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController, BidProtocol {
   
    

    
    var currentUser = MemberModel()
    var currentArticle = ArticleModel()
    var hoogsteBod: Double = 0
    
    @IBOutlet weak var labelGreeting: UILabel!
    
    @IBOutlet weak var labelMinBod: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelHoogsteBod: UILabel!
    
    @IBOutlet weak var stepperBids: UIStepper!
    @IBOutlet weak var labelCurrentBod: UILabel!
    @IBOutlet weak var buttonPlaatsBod: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonPlaatsBod.layer.borderColor = UIColor.blue.cgColor
        buttonPlaatsBod.layer.borderWidth = 1
        labelGreeting.text = "Hallo " + currentUser.getName()
        labelDescription.text  = currentArticle.getDes()
        labelMinBod.text = "Minimumbod: " + String(currentArticle.getminBid())
        
        if(hoogsteBod == -1)
        {
            labelHoogsteBod.text = "Nog geen biedingen"
        }
        else
        {
            labelHoogsteBod.text = String(hoogsteBod)
            
        }
        labelCurrentBod.text = String(hoogsteBod)
        var bDAO = BidDAO()
        bDAO.getBidsforArticle(artToListen: currentArticle, listener: self)
    }
    

    func setUserAndArticle(cUser: MemberModel, cArticle: ArticleModel)
    {
        self.currentUser = cUser
        self.currentArticle = cArticle
        setHighestBid()
    }
    
    func setHighestBid()
    {
        hoogsteBod = 0
        if(currentArticle.bids.isEmpty)
        {
            hoogsteBod = -1
        }
        else
        {
            for b in currentArticle.bids
            {
                if(b.getBid() > hoogsteBod)
                {
                    hoogsteBod = b.getBid()
                }
            }
            
        }
        
        
    }
    
    func getRealtimeBidsCompl(art: ArticleModel, error: String?) {
        if(error == "")
        {
            self.currentArticle = art
            setHighestBid()
            if(hoogsteBod == -1)
            {
                labelHoogsteBod.text = "Nog geen biedingen"
            }
            else
            {
                labelHoogsteBod.text = String(hoogsteBod)
                
            }
            labelCurrentBod.text = String(hoogsteBod)
            
        }
    }

}
