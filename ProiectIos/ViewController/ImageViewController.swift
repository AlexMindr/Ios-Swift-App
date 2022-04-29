//
//  ImageViewController.swift
//  ProiectIos
//
//  Created by user217581 on 4/29/22.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var btnBrowse: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     title="Share image"
        btnShare.addTarget(self, action: #selector(presentShareSheet(_:)), for: .touchUpInside)
    }
    
    
    @IBAction func didTapButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate=self
        vc.allowsEditing=true
        present(vc,animated: true)
    }
    
    @objc private func presentShareSheet(_ sender: UIButton){
        guard let imageShare = imageView.image else {
            return
        }
        
        let shareSheetVC = UIActivityViewController(activityItems:[imageShare], applicationActivities: nil)
        shareSheetVC.popoverPresentationController?.sourceView=sender
        shareSheetVC.popoverPresentationController?.sourceRect=sender.frame
        present(shareSheetVC,animated:true)
    }
    
}

extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("\(info)")
        if let imagePicked = info[UIImagePickerController.InfoKey(rawValue:"UIImagePickerControllerEditedImage")] as? UIImage{
            imageView.image=imagePicked
        }
        picker.dismiss(animated: true,completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true,completion: nil)
    }
}
