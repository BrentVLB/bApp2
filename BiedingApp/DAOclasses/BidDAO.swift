//
//  BidDAO.swift
//  BiedingApp
//
//  Created by student on 20/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import Foundation
import Firebase

class BidDAO
{
    let db: Firestore
    var bidListeners: [ListenerRegistration]
    
    
    init()
    {
        db = Firestore.firestore()
        bidListeners = [ListenerRegistration]()
    }
    
    func getBidsforArticle(artToListen: ArticleModel, listener: BidProtocol)
    {
        let bidListener: ListenerRegistration = db.collection("artikels").document(artToListen.getId()).collection("bids").addSnapshotListener{(querySnapshot,error) in
            if let err = error
            {
                let emptyArt = ArticleModel()
                listener.getRealtimeBidsCompl(art: emptyArt, error: err.localizedDescription)
            }
            else
            {
                artToListen.setBids(bidsToSet: [])
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
                    artToListen.addBid(bidToAdd: tempBid)
                    
                }
                listener.getRealtimeBidsCompl(art: artToListen, error: "")
            }
        }
        bidListeners.append(bidListener)
    }
    
    
    func addBidToArticle(articleToUpdate: ArticleModel, bidToAdd: BidModel, listener: BidProtocol)
    {
      
        var ref: DocumentReference? = nil
        ref = db.collection("artikels").document(articleToUpdate.getId()).collection("bids").addDocument(data: [
            "date": bidToAdd.getDate(),
            "memberId":bidToAdd.getMemberId(),
            "bidAmount":bidToAdd.getBid()
        ]) { err in
            if let err = err {
                listener.bidAddCompleted(error: err.localizedDescription)
            } else {
               listener.bidAddCompleted(error: "Joepie")
            }
        }    }
}

protocol BidProtocol{
    func getRealtimeBidsCompl(art: ArticleModel, error: String?)
    func bidAddCompleted(error: String?)
}
