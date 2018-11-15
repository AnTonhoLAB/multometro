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
    @IBOutlet weak var iconView: UIView! {
        didSet {
            iconView.backgroundColor = fieldsView.backgroundColor
        }
    }
    
    @IBOutlet weak var imageIconButton: UIButton! {
        didSet {
            imageIconButton.imageView?.contentMode = .scaleAspectFill
        }
    }
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        fieldsView.bringSubviewToFront(imageIconButton)
        imagePicker.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideKeyboardWhenTappedAround()
        iconView.circleView()
        imageIconButton.circleView(2)
    }
    
    @IBAction func didTapAddPhoto(_ sender: Any) {
        choosePhoto()
    }
    
    
    
    func choosePhoto() {
        let alertController = UIAlertController(title: nil, message: R.string.localizable.chosePhoto(), preferredStyle: .actionSheet)
        let actionGallery = UIAlertAction(title: R.string.localizable.galery(), style: .default, handler: { [weak self] in
            guard let self = self else { return }
            self.loadImageFromGallery(alertAction: $0) } )
        let actionCamera = UIAlertAction(title: R.string.localizable.camera(), style: .default,handler: { [weak self] in
            guard let self = self else { return }
            self.loadImageFromCamera(alertAction: $0) } )
        let cancel = UIAlertAction(title: R.string.localizable.cancel(), style: .destructive, handler: nil)
        
        alertController.addAction(actionGallery)
        alertController.addAction(actionCamera)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func loadImageFromGallery(alertAction: UIAlertAction) {
        loadImageFrom(sourceType: .savedPhotosAlbum)
    }
   
    
    func loadImageFromCamera(alertAction: UIAlertAction) {
        loadImageFrom(sourceType: .camera)
    }
    
    func loadImageFrom(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.sourceType = sourceType
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension RegisterUserViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  {
            dismiss(animated: true, completion: nil)
            imageIconButton.setImage(image, for: .normal)
        }
        
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
