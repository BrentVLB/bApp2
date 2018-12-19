//
//  ArtikelDAO.swift
//  BiedingApp
//
//  Created by student on 12/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import Foundation
import Firebase
class ArtikelDAO{
    
    let db: Firestore
    
    var listArtBids: [BidModel] = []
    
    init()
    {
        db = Firestore.firestore()
    }
    
    func getAllArticles(listener: ArticleProtocol)
    {
        var articleList: [ArticleModel] = []
        
        db.collection("artikels").getDocuments()
            { (querySnapshot, err) in
                if let err = err
                {
                   listener.getAllArticlesCompl(artList: articleList, error: err.localizedDescription)
                    
                }
                else
                {
                    for doc in querySnapshot!.documents
                    {
                        var tempArt = ArticleModel()
                        
                        
                        
                        tempArt.setDesc(newDescr: doc.data()["description"] as! String)
                        tempArt.setId(newId: doc.documentID)
                        
                        var minB: Double
                        let b:CFNumber = doc.data()["minBid"] as! CFNumber
                        var bidFloat :Float = 0
                        if CFNumberGetValue(b, CFNumberType.floatType,&bidFloat ) {
                            minB = Double(bidFloat) } else {
                            minB = 0 }
                        tempArt.setMinBid(newBid: minB)
                        
                    self.db.collection("artikels").document(doc.documentID).collection("bids").getDocuments(){(querySnapshot, erro) in
                            if let erro = erro
                            {
                                print("hier geen bids")
                            }
                            else
                            {
                                for b in querySnapshot!.documents
                                {
                                    var tempBid = BidModel()
                                    tempBid.setId(newId: b.documentID)
                                    tempBid.setDate(newD: b.data()["date"] as! Date)
                                    tempBid.setMemberId(newM: b.data()["memberId"] as! String)
                                    
                                    var bidA:Double
                                    let num:CFNumber = b.data()["bidAmount"] as! CFNumber
                                    var bidFloat :Float = 0
                                    if CFNumberGetValue(num, CFNumberType.floatType,&bidFloat ) {
                                        bidA = Double(bidFloat) } else {
                                        bidA = 0 }
                                    tempBid.setBidAmount(newB: bidA)
                                    //tempArt.addBid(bidToAdd: tempBid)
                                    listener.updateArticlesWithBids(artToUpdate: tempArt, bidToAdd: tempBid)
                                }
                            }
                        }
                       articleList.append(tempArt)
                    }
                    listener.getAllArticlesCompl(artList: articleList, error: "")
                }
                
        }
    }
    
    func getArticleById()
    {
        
    }
    
    
}

protocol ArticleProtocol{
    func getAllArticlesCompl(artList: [ArticleModel], error: String?)
    func updateArticlesWithBids(artToUpdate: ArticleModel, bidToAdd: BidModel)
}
