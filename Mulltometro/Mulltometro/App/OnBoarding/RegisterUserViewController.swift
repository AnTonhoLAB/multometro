//
//  RegisterViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 10/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift

class RegisterUserViewController: UIViewController {
    
    @IBOutlet weak var constraintToBot: NSLayoutConstraint!
    @IBOutlet weak var fieldsView: UIView!   
    @IBOutlet private weak var vwFields: UIView! {
        didSet {
            vwFields.roundedCornerColor(radius: roundRadius)
        }
    }
    @IBOutlet weak var nameTextField: UITextField! {
        didSet {
            nameTextField.roundedCornerColor(radius: roundRadius)
        }
    }
    @IBOutlet weak var btSkip: UIButton! {
        didSet {
            btSkip.roundedCornerColor(radius: roundRadius)
        }
    }
    @IBOutlet weak var btSave: UIButton! {
        didSet {
            btSave.roundedCornerColor(radius: roundRadius)
        }
    }
    
    private let roundRadius: CGFloat = 8.0
    private let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        fieldsView.bringSubviewToFront(imageIconButton)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideKeyboardWhenTappedAround()
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//        iconView.circleView()
//        imageIconButton.circleView(2)
    }
        
    @IBAction func didTapSkip(_ sender: Any) {
        openApp()
    }
    
    @IBAction func didTapSaveUser(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterPhoto", sender: nil)
//       saveUser()
    }
    
    
    func openApp() {
        self.dismissLoader()
        guard let window = UIApplication.shared.keyWindow else { return }
        let mainStoryboard: UIStoryboard = R.storyboard.main()
        guard let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: R.string.strings.mainIdentifier()) as? UITabBarController else { return }
        window.rootViewController = tabBarController
        
        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: {
            window.rootViewController = tabBarController
        }, completion: nil)
    }
    
    
}

// MARK: - Keyboard

extension RegisterUserViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        let sizeToKeyboard = view.frame.maxY - fieldsView.frame.maxY
        if let keyboardSize = (sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyBoardheight = keyboardSize.height
            UIView.animate(withDuration: 0.8) { [weak self] in
                guard let self = self else { return }
                let constant = (sizeToKeyboard - keyBoardheight)
                self.constraintToBot.constant = Swift.abs(constant) + 40
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.8) { [weak self] in
            guard let self = self else { return }
            self.constraintToBot.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
