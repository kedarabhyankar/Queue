//
//  ResetPasswordViewController.swift
//  Queue
//
//  Created by Kedar Abhyankar on 6/25/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit
import FirebaseAuth
import BRYXBanner

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var resetPasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSubmit(_ sender: Any) {
        resetPasswordField.resignFirstResponder()
        let email = resetPasswordField.text
        var banner: Banner = Banner();
        Auth.auth().sendPasswordReset(withEmail: email ?? "") { (error) in
            let e = AuthErrorCode(rawValue: error!._code)
            
            if e != nil {
                switch (e){
                    case .invalidEmail:
                        banner = Banner(title: "Invalid Email!", subtitle: "Your email is in an incorrect format.", image: nil, backgroundColor: EmailSignUpViewController.init().ui_red, didTapBlock: nil)
                    case .missingEmail:
                        banner = Banner(title: "Missing Email!", subtitle: "Make sure you input something for an email address!", image: nil, backgroundColor: EmailSignUpViewController.init().ui_red, didTapBlock: nil)
                    default:
                        banner = Banner(title: "Error!", subtitle: "Something went wrong! Try again.", image: nil, backgroundColor: EmailSignUpViewController.init().ui_yellow, didTapBlock: nil)
                }
            } else {
                banner = Banner(title: "Success!", subtitle: "A reset link was sent to the specified email, if it was a valid address.", image: nil, backgroundColor: EmailSignUpViewController.init().ui_green, didTapBlock: nil)
            }
            
            banner.show(nil, duration: 2);
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
