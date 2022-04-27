//
//  ModelManager.swift
//  ProiectIos
//
//  Created by user217581 on 4/27/22.
//

import Foundation
import  UIKit

var shareInstance = ModelManager()

class ModelManager{
    
    var database : FMDatabase? = nil
    
    static func getInstance() -> ModelManager{
        if shareInstance.database == nil{
            shareInstance.database = FMDatabase(path: Util.share.getPath(dbName: "SqliteDB.db"))
        }
        return shareInstance
    }
    
    
    
    func SaveData(FriendModel : FriendModel) -> Bool{
        shareInstance.database?.open()
        let isSave = shareInstance.database?.executeUpdate("INSERT INTO Friends (name, email) VALUES(?,?)", withArgumentsIn: [FriendModel.name, FriendModel.email])
        shareInstance.database?.close()
        return isSave!
    }
    
    
    
    func getAllfriends() -> [FriendModel]{
        shareInstance.database?.open()
        //FMResultSet  :  Used to hold result of SQL query on FMDatabase object.
        let resultSet : FMResultSet! = try! shareInstance.database?.executeQuery("SELECT * FROM friends", values: nil)
        var allfriends = [FriendModel]()
        
        if resultSet != nil{
            while resultSet.next() {
                let FriendModel = FriendModel(friendId: resultSet.string(forColumn: "id")!, friendName: resultSet.string(forColumn: "name")!, friendEmail: resultSet.string(forColumn: "email")!)
                allfriends.append(FriendModel)
            }
        }
        shareInstance.database?.close()
        return allfriends
    }
    
    

    func updateFriend(friend: FriendModel) -> Bool{
        shareInstance.database?.open()
        
        let isUpdated = shareInstance.database?.executeUpdate("UPDATE friends SET name=?, email=? WHERE id=? ", withArgumentsIn: [friend.name,friend.email, friend.id])
        
        shareInstance.database?.close()
        return isUpdated!
    }
    
    
   
    func deleteFriend(friend: FriendModel) -> Bool{
        shareInstance.database?.open()
        let isDeleted = (shareInstance.database?.executeUpdate("DELETE FROM friends WHERE name=?", withArgumentsIn: [friend.name]))
        shareInstance.database?.close()
        return isDeleted!
    }
}
