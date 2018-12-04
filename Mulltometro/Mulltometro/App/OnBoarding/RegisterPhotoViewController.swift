//
//  RegisterPhotoViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 04/12/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class RegisterPhotoViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var fieldsView: UIView! {
        didSet {
            fieldsView.roundedCornerColor(radius: roundRadius)
        }
    }
    @IBOutlet private weak var iconView: UIView! {
        didSet {
            iconView.backgroundColor = fieldsView.backgroundColor
        }
    }
    @IBOutlet private weak var imageIconButton: UIButton! {
        didSet {
            imageIconButton.imageView?.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var btSkip: UIButton! {
        didSet {
            btSkip.roundedCornerColor(radius: roundRadius)
        }
    }
    @IBOutlet weak var btNext: UIButton! {
        didSet {
            btNext.roundedCornerColor(radius: roundRadius)
        }
    }
    
    private let roundRadius: CGFloat = 8.0
    private let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        iconView.circleView()
        imageIconButton.circleView(2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    @IBAction func didTapAddPhoto(_ sender: Any) {
        choosePhoto()
    }
    
    @IBAction func didTapSkip(_ sender: Any) {
      
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterName", sender: nil)
//        //       saveUser()
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
    
    func saveUser() {
//        let m = MulltometroUser()
//        m.name = nameTextField.text
//        showLoader()
//        UserRequester.createUser(with: m, and: (self.imageIconButton.imageView?.image)!) { [weak self] in
//            guard let self = self else { return }
//            switch($0) {
//            case .success(let user):
//                let maUser = user
//                print(maUser.photoURL)
//                let userToSave = user.toCDObject()
//                CDManager.saveThis(userToSave)
//                self.openApp()
//            case .errorOnImage(let responseError), .errorOnUser(let responseError), .error(let responseError):
//                self.alertSimpleWarning(title: "ERROR", message: responseError.localizedDescription, action: nil)
//                self.dismissLoader()
//            }
//        }
    }

}

extension RegisterPhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func RegisterPhotoViewController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  {
            dismiss(animated: true, completion: nil)
            imageIconButton.setImage(image, for: .normal)
        }
        
    }
}
