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
    var registListeners: [ListenerRegistration]
    var bidListeners: [ListenerRegistration]
    var listArtBids: [BidModel] = []
    
    init()
    {
        db = Firestore.firestore()
        registListeners = [ListenerRegistration]()
        bidListeners = [ListenerRegistration]()
    }
    
    func getAllArticles(listener: ArticleProtocol)
    {
        var articleList: [ArticleModel] = []
        
        let listenerReg: ListenerRegistration =  db.collection("artikels").addSnapshotListener
            { (querySnapshot, err) in
                if let err = err
                {
                   listener.getAllArticlesCompl(artList: articleList, error: err.localizedDescription)
                    
                }
                else
                {
                    articleList = []
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
                        
                    
                       articleList.append(tempArt)
                        print(articleList.count)
                    }
                    listener.getAllArticlesCompl(artList: articleList, error: "")
                }
                
        }
        registListeners.append(listenerReg)
    }
    
    
    func updateWithBids(listToUpdate: [ArticleModel], listener: ArticleProtocol)
    {
       for artikel in listToUpdate
       {
        let bidListener: ListenerRegistration = db.collection("artikels").document(artikel.getId()).collection("bids").addSnapshotListener{(querySnapshot, erro) in
            if let erro = erro
            {
                let emptyArt = ArticleModel()
                listener.updateArticlesWithBids(articleToUpdate: emptyArt, error: erro.localizedDescription)
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
                    artikel.addBid(bidToAdd: tempBid)
                    
                }
                listener.updateArticlesWithBids(articleToUpdate: artikel, error: "")
                //per artikel apart updaten
            }
        }
        bidListeners.append(bidListener)
        }

    }
    
  func removeListeners()
    {
        registListeners.forEach({registListener in registListener.remove()})
    }
    
    func removeBidLiseners()
    {
        bidListeners.forEach({bidListener in bidListener.remove()})
    }
    
    
}

protocol ArticleProtocol{
    func getAllArticlesCompl(artList: [ArticleModel], error: String?)
    func updateArticlesWithBids(articleToUpdate: ArticleModel, error: String?)
}
