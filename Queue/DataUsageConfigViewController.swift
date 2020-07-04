//
//  DataUsageConfigViewController.swift
//  Queue
//
//  Created by Kedar Abhyankar on 7/2/20.
//  Copyright © 2020 Kedar Abhyankar. All rights reserved.
//

import UIKit

class DataUsageConfigViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(leftSwipe)

        // Do any additional setup after loading the view.
    }
    
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer){
        switch swipe.direction.rawValue {
            case 1:
                view.window!.layer.add(swipebackTransitionBuilder(), forKey: kCATransition)
                present(modalPresenter(storyboard: "Main", vc: "settings"), animated: true)
            default:
                break
        }
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
