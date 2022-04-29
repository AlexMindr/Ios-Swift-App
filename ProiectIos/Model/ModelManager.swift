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
    
    
    func getUser(username:String) -> UserModel{
        shareInstance.database?.open()
        
//        let resultSet : FMResultSet! = try! shareInstance.database?.executeQuery("SELECT id,name FROM Users WHERE username='adi' ", values:[username])
//
//        print("\(resultSet.string(forColumn: "id"))")
//        var currentUser:UserModel
//        if resultSet != nil{
//           // currentUser = UserModel(userid: resultSet.string(forColumn: "id")!, userName: resultSet.string(forColumn: "name")!)
//            currentUser = UserModel(userid: "", userName:  "Guest")
//        }
//        else {
//            currentUser = UserModel(userid: "", userName:  "Guest")
//        }
//        shareInstance.database?.close()
//        return currentUser
        
        let resultSet : FMResultSet! = try! shareInstance.database?.executeQuery("SELECT * FROM Users where username=?", values: [username])
        var user = [UserModel]()
        
        if resultSet != nil{
            while resultSet.next() {
                let UserModel = UserModel(userid: resultSet.string(forColumn: "id")!, userName: resultSet.string(forColumn: "name")!)
                user.append(UserModel)
            }
            
        }
       
        shareInstance.database?.close()
        if user.isEmpty {
            let UserModel=UserModel(userid: "", userName:  "Guest")
            return UserModel
        }
        else {
            return user[0]
        }
        
        
        
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
        let resultSet : FMResultSet! = try! shareInstance.database?.executeQuery("SELECT * FROM Friends", values: nil)
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
        
        let isUpdated = shareInstance.database?.executeUpdate("UPDATE Friends SET name=?, email=? WHERE id=? ", withArgumentsIn: [friend.name,friend.email, friend.id])
        
        shareInstance.database?.close()
        return isUpdated!
    }
    
    
   
    func deleteFriend(friend: FriendModel) -> Bool{
        shareInstance.database?.open()
        let isDeleted = (shareInstance.database?.executeUpdate("DELETE FROM Friends WHERE name=?", withArgumentsIn: [friend.name]))
        shareInstance.database?.close()
        return isDeleted!
    }
}
