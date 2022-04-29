//
//  FriendsViewController.swift
//  ProiectIos
//
//  Created by user217581 on 4/28/22.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var tblFriends: UITableView!
    var friends = [FriendModel]()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title="All Friends"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        friends = ModelManager.getInstance().getAllfriends()
            tblFriends.reloadData()
        }

}
extension FriendsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count;
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "FriendCell",for:indexPath) as! FriendTableViewCell
        cell.lblName.text = friends[indexPath.row].name
        cell.lblEmail.text = friends[indexPath.row].email
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(onClickEdit(_:)), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(onClickDelete(_:)), for: .touchUpInside)
        
        return cell;
    }
    
    @objc func onClickEdit(_ sender: UIButton){
           let vc = storyboard?.instantiateViewController(identifier:"AddFriend") as! AddFriendViewController
           vc.friendModel = friends[sender.tag]
           vc.headerTitle = "Update"
           
           navigationController?.pushViewController(vc, animated: true)
       }
       
       @objc func onClickDelete(_ sender: UIButton){
           let isDeleted = ModelManager.getInstance().deleteFriend(friend:friends[sender.tag])
           friends.remove(at: sender.tag)
           tblFriends.reloadData()
           print("isDeleted :- \(isDeleted)")
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
}
