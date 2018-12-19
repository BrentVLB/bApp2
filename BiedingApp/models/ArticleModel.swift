//
//  ArticleModel.swift
//  BiedingApp
//
//  Created by student on 06/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import Foundation

class ArticleModel{
    var id: String
    var description: String
    var minBid: Double
    var bids :[BidModel]
    
    init() {
        self.id = ""
        self.description = ""
        self.minBid = 0
        self.bids = []
    }
    
    func getId() -> String{
        return id
    }
    func getDes() -> String{
        return description
    }
    func getminBid() -> Double{
        return minBid
    }
    
    func getBids() -> [BidModel] {
        return bids
    }
    
    func setId(newId:String)
    {
        self.id = newId
    }
    func setDesc(newDescr:String)
    {
        self.description = newDescr
    }
    func setMinBid(newBid:Double)
    {
        self.minBid = newBid
    }
    
    func setBids(bidsToSet: [BidModel])
    {
        self.bids = bidsToSet
    }
    
    func addBid(bidToAdd: BidModel)
    {
        self.bids.append(bidToAdd)
    }
    
    
}
