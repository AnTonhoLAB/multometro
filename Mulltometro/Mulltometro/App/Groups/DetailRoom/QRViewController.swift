//
//  QRViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 24/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {
    
    @IBOutlet var QRView: UIImageView!
    @IBOutlet weak var btClose: UIButton! {
        didSet {
            btClose.roundedCornerColor(radius: 15)
            btClose.tintColor = .redSystem
        }
    }
    
    var QRString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRView()
    }
    
    func setupQRView() {

        let midX = self.view.frame.midX
        let midY = self.view.frame.midY
        let frame = self.view.frame
        let viewPositionX = midX - midX / 1.5
        let viewPositionY = midY - midY / 2
        
        QRView.frame = CGRect(x: viewPositionX, y: viewPositionY, width: frame.width / 1.5, height: frame.height / 2)

        QRView.alpha = 0
        QRView.image = generateQRCode()
        let blurEffectView = blur()
        
        blurEffectView.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.QRView.alpha = 1.0
            blurEffectView.alpha = 1.0
        })
        
        self.view.addSubview(blurEffectView)
        self.view.addSubview(QRView)
        
        guard let superview = blurEffectView.superview else { return }
        superview.bringSubviewToFront(btClose)
    }
    
    func generateQRCode() -> UIImage? {
        let data = QRString.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    func blur() -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style:.dark)
        
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
