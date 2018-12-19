//
//  BidModel.swift
//  BiedingApp
//
//  Created by student on 06/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import Foundation

class BidModel{
    var id: String
    var bid: Double
    var date: Date
    var memberId: String
    
    init(){
        self.id = ""
        self.bid = 0
        self.date = Date()
        self.memberId = ""
    }
    
    func setId(newId:String)
    {
        self.id = newId
    }
    
    func setDate(newD: Date)
    {
        self.date = newD
    }
    
    func setBidAmount(newB: Double)
    {
        self.bid = newB
    }
    
    func setMemberId(newM: String)
    {
        self.memberId = newM
    }
    
    func getId() -> String {
      return id
    }
    
    func getBid() -> Double {
        return bid
    }
    
    func getDate() -> Date {
        return date
    }
    func getMemberId() -> String {
        return memberId
    }
}
