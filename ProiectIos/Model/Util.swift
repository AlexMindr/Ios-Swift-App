//
//  Util.swift
//  ProiectIos
//
//  Created by user217581 on 4/27/22.
//

import Foundation
import UIKit

class Util{
    static let share=Util()
 
    //MARK:- Getting path of our Database
      func getPath(dbName: String) -> String{
          let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
          let fileUrl = documentDirectory.appendingPathComponent(dbName)
          //print("DB Path :- \(fileUrl.path)")
          //print("!!!Path :- \(documentDirectory.path)")
          return fileUrl.path
      }
      
      //MARK:- Create path if it doesn't exists
      func copyDatabase(dbName: String){
          let dbPath = getPath(dbName: "SqliteDB.db")
          let fileManager = FileManager.default
          
          if !fileManager.fileExists(atPath: dbPath){
              let bundle = Bundle.main.resourceURL
              let file = bundle?.appendingPathComponent(dbName)
              
              do{
                  try fileManager.copyItem(atPath: file!.path, toPath: dbPath)
              }
              catch let err{
                  print(err.localizedDescription)
              }
          }
      }
    
}
