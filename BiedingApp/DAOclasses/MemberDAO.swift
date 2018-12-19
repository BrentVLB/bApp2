//
//  MemberDAO.swift
//  BiedingApp
//
//  Created by student on 06/12/2018.
//  Copyright © 2018 labiOS. All rights reserved.
//

import Foundation
import Firebase

class MemberDAO {
    
    
    init(){
        
    }
    
    func addNewMember(newLid: MemberModel)
    {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("leden").addDocument(data: [
            "name": newLid.name ,
            "birthDate": newLid.birthDate,
            "uid": newLid.uid
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
    
    func getAllMembers() {
        let db = Firestore.firestore()
        db.collection("leden").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
    }
    
    func getMember (membertoGet: MemberModel, listener: memberProtocol){
        let db = Firestore.firestore()
        db.collection("leden").whereField("uid", isEqualTo: membertoGet.getUid()).getDocuments(){(QuerySnapshot, err) in
            if let err = err{
                listener.getMemberCompleted(member: membertoGet, error: err.localizedDescription)
            }
            else{
                var doc = QuerySnapshot!.documents[0]
                membertoGet.setName(newName: doc.data()["name"] as! String)
                membertoGet.setId(newId: doc.documentID)
                membertoGet.setBirthDate(newBirthDate: doc.data()["birthDate"] as! Date)
                listener.getMemberCompleted(member: membertoGet, error: "")
            }
        }
        
     
    }
    
    
    
}

protocol memberProtocol {
    func getMemberCompleted(member: MemberModel, error:String?)
}

