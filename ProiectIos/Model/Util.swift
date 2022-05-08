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
//       func getPath(dbName: String) -> String{
//           let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//           let fileUrl = documentDirectory.appendingPathComponent(dbName)
//           //let databaseInMainBundleURL = Bundle.main.resourceURL?.appendingPathComponent("SqliteDB.db")
//             //print("DB Path :- \(fileUrl.path)")
//             //print("!!!Path :- \(documentDirectory.path)")
//           //print("DB Path :- \(databaseInMainBundleURL)")
//           return fileUrl.path
          
//       }
     func getPath(dbName: String) -> String{
          
          let documentDirectory = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
          let fileUrl = documentDirectory.appendingPathComponent("SqliteDB.db")
          return fileUrl.path
          
      }
      
     
    
    func copyDatabaseIfNeeded() {
        // Move database file from bundle to documents folder

        let fileManager = FileManager.default

        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let finalDatabaseURL = documentsUrl.appendingPathComponent("SqliteDB.db")

        do {
            if !fileManager.fileExists(atPath: finalDatabaseURL.path) {
                print("DB does not exist in documents folder")

                if let dbFilePath = Bundle.main.path(forResource: "SqliteDB", ofType: "db") {
                    try fileManager.copyItem(atPath: dbFilePath, toPath: finalDatabaseURL.path)
                } else {
                    print("Uh oh - .db is not in the app bundle")
                }
            } else {
                print("Database file found at path: \(finalDatabaseURL.path)")
            }
        } catch {
            print("Unable to copy .db: \(error)")
        }
    }
    
    
}
