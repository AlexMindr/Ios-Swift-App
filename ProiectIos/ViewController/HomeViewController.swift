//
//  HomeViewController.swift
//  ProiectIos
//
//  Created by user217581 on 4/29/22.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var btnFriends: UIButton!
    var currentUser:UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        title="Home"
        lblUser.text=currentUser?.name
    }
    

    @IBAction func btnLogout(_ sender: UIButton) {
        navigationController?.popViewController( animated: true)
    }


    @IBAction func touchDown(_ sender: UIButton) {
        sender.pulsate()
    }
    
    @IBAction func touchUpIns(_ sender: UIButton) {
        sender.flash()
    }
    @IBAction func touchDownRep(_ sender: UIButton) {
        sender.shake()
    }

}
extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: "pulse")
    }
  
      func flash() {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
          flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 3
        
        layer.add(flash, forKey: nil)
    }
    
  
    func shake() {
        
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: "position")
    }
}

