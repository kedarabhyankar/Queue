//
//  EmailSignInViewController.swift
//  Noted
//
//  Created by Kedar Abhyankar on 6/21/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit
import BRYXBanner
import FirebaseAuth

class EmailSignInViewController: UIViewController {

    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        passwordField.isSecureTextEntry = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        
        let emailAddress = emailAddressField.text ?? ""
        let password = passwordField.text ?? ""
        var authBanner:Banner = Banner();
        Auth.auth().signIn(withEmail: emailAddress, password: password) {authResult,error in
            
            if error != nil {
                let e = AuthErrorCode(rawValue: error!._code)
                
                switch (e){
                case .missingEmail:
                    authBanner = Banner(title: "Missing email!", subtitle: "You need to enter an email address!", image: nil, backgroundColor: EmailSignUpViewController.init().ui_red, didTapBlock: nil)
                case .invalidEmail:
                    authBanner = Banner(title: "Invalid email!", subtitle: "Something is wrong with your email. Try again.", image: nil, backgroundColor: EmailSignUpViewController.init().ui_red, didTapBlock: nil)
                case .wrongPassword:
                    authBanner = Banner(title: "Wrong Password!", subtitle: "Your password is incorrect. Try again.", image: nil, backgroundColor: EmailSignUpViewController.init().ui_red, didTapBlock: nil)
                default:
                    authBanner = Banner(title: "Error!", subtitle: "An unknown error occurred!", image:nil, backgroundColor: EmailSignUpViewController.init().ui_red, didTapBlock: nil)
                }
            } else {
                authBanner = Banner(title: "Success!", subtitle: "Signing you in now...", image: nil, backgroundColor: EmailSignUpViewController.init().ui_green, didTapBlock: nil)
                LoginViewController.init().performHomeScreenFlow()
            }
    
            authBanner.show(nil, duration: 2.0)
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
