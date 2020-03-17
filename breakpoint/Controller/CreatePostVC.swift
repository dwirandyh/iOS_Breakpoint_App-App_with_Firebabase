//
//  CreatePostVC.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 17/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    
    @IBOutlet weak var profilImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sendPost(_ sender: Any) {
        if textField.text != nil && textField.text != "Say something here..." {
            sendButton.isEnabled = true
            DataService.instance.uploadPost(withMessage: textField.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
                if isComplete {
                    self.sendButton.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendButton.isEnabled = true
                    print("There was an error")
                }
            }
        }
    }
}

extension CreatePostVC : UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
