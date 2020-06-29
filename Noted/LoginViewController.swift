//
//  LoginViewController.swift
//  Noted
//
//  Created by Kedar Abhyankar on 6/21/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit
import AuthenticationServices
import CryptoKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var signInWithEmailButton: UIButton? = nil
    @IBOutlet weak var resetPass: UIButton? = nil
    @IBOutlet weak var signUpWithEmailButton : UIButton? = nil
    var siwaButton : ASAuthorizationAppleIDButton? = nil
    fileprivate var currentNonce: String? = nil
    
    func presentationAnchor(for controller: ASAuthorizationController) ->  ASPresentationAnchor {
        return self.view.window!
    }
    
    /**
     This function is used to watch the traitCollectionDidChange environment, which will change the Sign In With Apple Button (SIWA) from dark to light when appropriate.
     */
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let hasUIStyleChanged = traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
        if(hasUIStyleChanged){
            switch traitCollection.userInterfaceStyle {
                case .dark:
                    siwaButton = ASAuthorizationAppleIDButton(type: .default, style: .white)
                    siwaButton?.translatesAutoresizingMaskIntoConstraints = false
                default:
                    siwaButton = ASAuthorizationAppleIDButton(type: .default, style: .black)
                    siwaButton?.translatesAutoresizingMaskIntoConstraints = false
                    
            }
        }
        self.view.addSubview((siwaButton)!);
        siwaButton!.addTarget(self, action: #selector(onSignInWithApple), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(traitCollection.userInterfaceStyle == .light){
            siwaButton = ASAuthorizationAppleIDButton(type: .default, style: .black)
        } else {
            siwaButton = ASAuthorizationAppleIDButton(type: .default, style: .white)
        }
        siwaButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview((siwaButton)!)
        constrainSiwaButton()
        siwaButton!.addTarget(self, action: #selector(onSignInWithApple), for: .touchUpInside)
    }
    
    @IBAction func onSignInWithEmail(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "emailSignInScreen") as EmailSignInViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onSignUpWithEmail(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "emailSignUpScreen") as EmailSignUpViewController
        present(vc, animated: true, completion: nil)
    }
    
    
    @available(iOS 13, *)
    @objc
    func onSignInWithApple(){
        let nonce = randomNonceString()
        currentNonce = nonce;
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @IBAction func onResetPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "resetPassword") as ResetPasswordViewController
        present(vc, animated: true, completion: nil)
    }
    
    func constrainSiwaButton(){
        siwaButton!.constraints.forEach{ (constraint) in
            if(constraint.firstAttribute == .height){
                constraint.isActive = false
            }
        }
        if(signUpWithEmailButton != nil){
            NSLayoutConstraint.activate([siwaButton!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 44), siwaButton!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -44),
                                         siwaButton!.bottomAnchor.constraint(equalTo:signUpWithEmailButton!.topAnchor, constant: -20),
                                         siwaButton!.heightAnchor.constraint(equalToConstant: 50)])
            //constrain email button to same dimensions as SIWA button
            NSLayoutConstraint.activate([
                signInWithEmailButton!.bottomAnchor.constraint(equalTo: siwaButton!.topAnchor, constant: -20),
                signInWithEmailButton!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                signInWithEmailButton!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 44),
                signInWithEmailButton!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -44)
            ])
            signInWithEmailButton!.layer.cornerRadius = siwaButton!.cornerRadius
        }
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        return hashString
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            UserDefaults.standard.set(appleIDCredential.user, forKey: "appleAuthorizedUserIdKey")
            
            guard let nonce = self.currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            // Retrieve Apple identity token
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Failed to fetch identity token")
                return
            }
            // Convert Apple identity token to string
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Failed to decode identity token")
                return
            }
            
            // Initialize a Firebase credential using secure nonce and Apple identity token
            let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com",
                                                              idToken: idTokenString,
                                                              rawNonce: nonce)
            // Sign in with Firebase
            Auth.auth().signIn(with: firebaseCredential) { (authResult, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                let db = Firestore.firestore()
                var ref: DocumentReference? = nil
                ref = db.collection("users").addDocument(data: [
                    "signInFlow": "Sign In with Apple",
                    "firstName": appleIDCredential.fullName?.givenName ?? "first name error!",
                    "lastName": appleIDCredential.fullName?.familyName ?? "last name error!",
                    "email":appleIDCredential.email ?? "email error"
                ]){ err in
                    if let err = err {
                        print("Error adding document: \(err)")
                        
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        self.performHomeScreenFlow()
                    }
                }
            }
        }
    }
    
    
    func performHomeScreenFlow(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "homeTabBar")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
