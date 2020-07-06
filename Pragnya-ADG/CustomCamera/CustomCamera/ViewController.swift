//
//  ViewController.swift
//  CustomCamera
//
//  Created by Pragnya Deshpande on 03/03/20.
//  Copyright © 2020 PragnyaDesh. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

let CaptureSession = AVCaptureSession()
var PreviewLayer: CALayer!

var CaptureDevice: AVCaptureDevice!
var TakePhoto  = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PrepareCamera()
    }


    func PrepareCamera(){
        CaptureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        if let AvailabeDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back).devices.first{
            CaptureDevice = AvailabeDevices
            BeginSession()
        }
        
    }

    func BeginSession(){
        do {
            
           let CaptureDeviceInput = try AVCaptureDeviceInput(device: CaptureDevice)
            CaptureSession.addInput(CaptureDeviceInput)
           }catch{
            print(error.localizedDescription)
        }
        
        let PreviewLayer = AVCaptureVideoPreviewLayer(session:CaptureSession)
            self.PreviewLayer = PreviewLayer
            self.view.layer.addSublayer(self.PreviewLayer)
            self.PreviewLayer.frame = self.view.layer.frame
            CaptureSession.startRunning()
            
            let DataOutput = AVCaptureVideoDataOutput()
            DataOutput.videoSettings = [((kCVPixelBufferPixelFormatTypeKey as NSString) as String):NSNumber(value: kCVPixelFormatType_32BGRA)]
            
            DataOutput.alwaysDiscardsLateVideoFrames = true
            
            if CaptureSession.canAddOutput(DataOutput){
                CaptureSession.addOutput(DataOutput)
            }
             
            CaptureSession.commitConfiguration()
            
        let queue = DispatchQueue(label: "com.pragnya.CaptureQueue")
        DataOutput.setSampleBufferDelegate(self, queue: queue)
        
    }
    
    @IBAction func TakePhoto(_ sender: Any) {
        TakePhoto = true
        
        
    }

func captureOuput(_ captureOutput:AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!){
    if TakePhoto {
        TakePhoto = false
        
        if let Image = self.getImageFromSampleBuffer(buffer: sampleBuffer){
            
            let PhotoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as! PhotoViewController
            
            PhotoVC.TakenPhoto = Image
            
            DispatchQueue.main.async {
                self.present(PhotoVC, animated: true, completion: {
                    self.StopCaptureSession()
                })
                
            }
        }
        
    }
    
}
   func getImageFromSampleBuffer(buffer: CMSampleBuffer) -> UIImage?
   {
   if let pixelBuffer = CMSampleBufferGetDataBuffer(buffer){
       let ciImage = CIImage(cvPixelBuffer: pixelBuffer as! CVPixelBuffer)
       let context = CIContext()
       
       let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer as! CVPixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer as! CVPixelBuffer))
       if let image = context.createCGImage(ciImage, from: imageRect){
           return UIImage(cgImage: image, scale: UIScreen.main.scale, orientation: .right)
       }
    
    }
        return nil
}
    func StopCaptureSession (){
        self.CaptureSession.stopRunning()
        
        if let Inputs = CaptureSession.inputs as? [AVCaptureDeviceInput]{
            for input in Inputs{
                self.CaptureSession.removeInput(input)
            }
        }
        
    }
    
}

