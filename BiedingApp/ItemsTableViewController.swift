//
//  ItemsTableViewController.swift
//  BiedingApp
//
//  Created by student on 12/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController, ArticleProtocol {
    
   
    
    let artdao = ArtikelDAO()
    var loggedUser = MemberModel()
    var articleList: [ArticleModel] = [ArticleModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articleList.count
    }
    
    func setLoggedUser(userToLog: MemberModel)
    {
        loggedUser = userToLog
    }
    
   func getArt()
   {
        artdao.getAllArticles(listener: self)
   }
    
    func getAllArticlesCompl(artList: [ArticleModel], error: String?) {
        
        if(error == "")
        {
            
            articleList = artList
            self.tableView.reloadData()
            
            artdao.updateWithBids(listToUpdate: artList, listener: self)
            
        }
    }
    
    func updateArticlesWithBids(articleToUpdate: ArticleModel, error: String?)
     {
       
        if(error == "")
        {
            articleList.first(where: {articleInList in
                return articleInList.getId() == articleToUpdate.getId()
            })?.setBids(bidsToSet: articleToUpdate.getBids())
            
            var r = 0
            var found = false
            for art in articleList
            {
                
                if(art.getId() == articleToUpdate.getId())
                {
                    
                    found = true
                }
                if(!found)
                {
                    r =  r + 1
                }
            }
            let indexPath = IndexPath(item: r, section: 0)
            self.tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.left)
            
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        if(!articleList.isEmpty)
        {
            var currArt = articleList[indexPath.item]
            cell.textLabel?.text = currArt.getDes()
            if(currArt.getBids().isEmpty)
            {
                cell.detailTextLabel?.text = "Min bid = " + String(currArt.getminBid())
            }
            else
            {
                var hoogsteBod:Double = 0
                for b in currArt.bids
                {
                    if(b.getBid() > hoogsteBod)
                    {
                        hoogsteBod = b.getBid()
                    }
                }
                 cell.detailTextLabel?.text = "highest bid = " + String(hoogsteBod)
            }
            
        }
        // Configure the cell...

        return cell
    }
 
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        //aanmaken viewcontroller met bijhorende view
        let vc = self.storyboard?.instantiateViewController(withIdentifier:
            "ArticleDetailVC") as! ArticleDetailViewController
        vc.setUserAndArticle(cUser: self.loggedUser, cArticle: articleList[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }

  

    

}
