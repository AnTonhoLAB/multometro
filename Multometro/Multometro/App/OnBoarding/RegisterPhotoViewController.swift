//
//  RegisterPhotoViewController.swift
//  Multometro
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
        self.performSegue(withIdentifier: "toRegisterName", sender: nil)
    }
    
    @IBAction func didTapNext(_ sender: Any) {
        saveImage()
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
    
    func saveImage() {

        guard let imageView = imageIconButton.imageView, let image = imageView.image else { return }
        
        if image == UIImage(named: "addImage") {
            performSegue(withIdentifier: "toRegisterName", sender: nil)
        } else {
            showLoader()
            UserRequester.uploadUser(image: image) { [weak self] res in
                guard let self = self else { return }
                switch res {
                case .success(_):
                    self.performSegue(withIdentifier: "toRegisterName", sender: nil)
                case .failure(_):
                    self.alertSimpleMessage(message: "TODO")
                }
            }
        }
    }
    func skipToName() {
        performSegue(withIdentifier: "toRegisterName", sender: nil)
    }
}

extension RegisterPhotoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func RegisterPhotoViewController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        changeImageInIcon(info: info)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        changeImageInIcon(info: info)
    }
    
    func changeImageInIcon(info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  {
            dismiss(animated: true, completion: nil)
            imageIconButton.setImage(image, for: .normal)
        }
    }
}
