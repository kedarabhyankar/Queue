//
//  EmailSignInViewController.swift
//  Queue
//
//  Created by Kedar Abhyankar on 6/21/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit
import BRYXBanner
import FirebaseAuth

class EmailSignInViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(leftSwipe)
        
        passwordField.isSecureTextEntry = true
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
        switch swipe.direction.rawValue {
            case 1:
                view.window!.layer.add(swipebackTransitionBuilder(), forKey: kCATransition)
                present(modalPresenter(storyboard: "Main", vc: "login"), animated: true)
            default:
                break
        }
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        emailAddressField.resignFirstResponder()
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
                authBanner.show(nil, duration: 2)
            } else {
                authBanner = Banner(title: "Success!", subtitle: "Signing you in now...", image: nil, backgroundColor: EmailSignUpViewController.init().ui_green, didTapBlock: nil)
                authBanner.show(nil, duration: 2.0)
                UserDefaults.standard.set(true, forKey: "loggedIn")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    self.performHomeScreenFlow()
                }
            }
        }
    }
    
    func performHomeScreenFlow(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "homeTabBar")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    func swipebackTransitionBuilder() -> CATransition {
        let transitionAnimation = CATransition()
        transitionAnimation.duration = 0.5
        transitionAnimation.type = CATransitionType.push
        transitionAnimation.subtype = CATransitionSubtype.fromLeft
        transitionAnimation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        return transitionAnimation
    }
    
    func modalPresenter(storyboard: String, vc: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: vc)
        vc.modalPresentationStyle = .fullScreen
        return vc
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
