//
//  SearchRoomViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 24/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import AVFoundation

class SearchRoomViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    @IBOutlet weak var btCancel: UIButton!
    @IBOutlet weak var vwFocous: UIView!
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var delegate: RegisterForNewGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        
        vwFocous.backgroundColor = .clear
        vwFocous.layer.borderWidth = 2
        vwFocous.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor

        view.layer.addSublayer(previewLayer)
        view.addSubview(vwFocous)
        view.bringSubviewToFront(btCancel)
        
        captureSession.startRunning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil

    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    
    }
    
    func found(code: String) {
        print(code)
        
        RoomRequester.enterRoom(roomId: code) {[weak self] (res) in
            guard let self = self else { return }
            switch res {
            case .success(let room):
                self.delegate.added(new: room)
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self.alertSimpleMessage(message: error.localizedDescription, action: { action in
                    self.captureSession.startRunning()
                })
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
