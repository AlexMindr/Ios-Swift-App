//
//  ViewController.swift
//  ProiectIos
//
//  Created by user217581 on 4/27/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tblFriends: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title="Home"
        
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "FriendCell",for:indexPath) as! FriendTableViewCell
        return cell;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90;
    }
}

