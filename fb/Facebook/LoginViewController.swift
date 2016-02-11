//
//  LoginViewController.swift
//  Facebook
//
//  Created by Charlie Yuan on 2/10/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var fieldParentView: UIView!
    @IBOutlet weak var labelParentView: UIView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var fieldParentViewInitialY: CGFloat!
    var labelParentViewInitialY: CGFloat!
    var logoInitialY: CGFloat!

    let fieldParentViewOffset: CGFloat! = -50.0
    let labelParentViewOffset: CGFloat! = -210.0
    let logoOffset: CGFloat! = -10.0

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        fieldParentViewInitialY = fieldParentView.frame.origin.y
        labelParentViewInitialY = labelParentView.frame.origin.y
        logoInitialY = logo.frame.origin.y
        self.spinner.stopAnimating()
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        fieldParentView.frame.origin.y = fieldParentViewInitialY + fieldParentViewOffset
        labelParentView.frame.origin.y = labelParentViewInitialY + labelParentViewOffset
        logo.frame.origin.y = logoInitialY + logoOffset
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        fieldParentView.frame.origin.y = fieldParentViewInitialY
        labelParentView.frame.origin.y = labelParentViewInitialY
        logo.frame.origin.y = logoInitialY
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
        
    }
    
    func checkPassword() {
        self.spinner.stopAnimating()
        if (email.text == "admin" && password.text == "password") {
            self.performSegueWithIdentifier("loggedInSegue", sender: nil)
        } else {
            self.loginBtn.selected = false
        }
    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func onLoginClick(sender: AnyObject) {
        self.spinner.startAnimating()
        delay(2) {
            self.checkPassword()
        }
        
    }
}
