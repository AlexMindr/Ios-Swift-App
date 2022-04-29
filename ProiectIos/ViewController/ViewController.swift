//
//  ViewController.swift
//  ProiectIos
//
//  Created by user217581 on 4/27/22.
//

import UIKit

class ViewController: UIViewController {
    
    
   
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    var user : UserModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title="Login"
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        user=ModelManager.getInstance().getUser(username: txtUsername.text!)
       // var users=ModelManager.getInstance().getUser(username: txtUsername.text!)
        let vc = storyboard?.instantiateViewController(identifier:"Home") as! HomeViewController
        vc.currentUser = user
        
        navigationController?.pushViewController(vc, animated: true)
                    
    }
    
    
}
