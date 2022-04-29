//
//  AddFriendViewController.swift
//  ProiectIos
//
//  Created by user217581 on 4/27/22.
//

import UIKit

class AddFriendViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var buttonAdd: UIButton!
    
    
    var friendModel : FriendModel?
    var headerTitle = ""
    
    override func viewDidLoad() {
           super.viewDidLoad()
           if headerTitle != ""{
               self.title = "\(headerTitle) Friend"
               txtName.text = friendModel?.name
               txtEmail.text = friendModel?.email
               buttonAdd.setTitle(headerTitle.uppercased(),for:.normal)
           }
       }
    //buttonAdd.addTarget(self, action: #selector(onClickRedirect(_:)), for: .touchUpInside)
  
    @IBAction func onClickAdd(_ sender: UIButton) {
        if headerTitle != ""{
                    let friend = FriendModel(friendId: friendModel!.id, friendName: txtName.text!, friendEmail:txtEmail.text!)
                    let isUpdate = ModelManager.getInstance().updateFriend(friend: friend)
                    print("isUpdate :- \(isUpdate)")
                }
                else{
                    let friend = FriendModel(friendId: "", friendName: txtName.text!, friendEmail: txtEmail.text!)
                    let isSave = ModelManager.getInstance().SaveData(FriendModel: friend)
                    print("isSave :- \(isSave)")
                }
        onClickRedirect()
    }
    @objc func onClickRedirect(){
           navigationController?.popViewController( animated: true)
       }
}
