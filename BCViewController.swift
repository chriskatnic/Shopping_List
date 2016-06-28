//  BCViewController.swift
//  barcode scanner
//
//  Created by Christopher Katnic on 7/24/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

// Currently, the add to shopping list button isn't working
// Change the view to the entire screen, make the description sit on another viewcontroller



import UIKit
import AVFoundation


class BCViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, ItemPassBackDelegate {
    
    let session         : AVCaptureSession = AVCaptureSession()
    var previewLayer    : AVCaptureVideoPreviewLayer!
    var highlightView   : UIView = UIView()
    var item            : groceryItem = groceryItem()
    var delegate        : PassBackDelegate?
    
    @IBOutlet weak var barcodeView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set spinner details
        self.spinner.hidesWhenStopped = true
        self.spinner.hidden = true
        
        
        // Allow the view to resize freely
        self.highlightView.autoresizingMask =   UIViewAutoresizing.FlexibleTopMargin |
            UIViewAutoresizing.FlexibleBottomMargin |
            UIViewAutoresizing.FlexibleLeftMargin |
            UIViewAutoresizing.FlexibleRightMargin
        
        // Select the color you want for the completed scan reticle
        self.highlightView.layer.borderColor = UIColor.greenColor().CGColor
        self.highlightView.layer.borderWidth = 3
        
        // Add it to barcode view controller's view as a subview.
        self.barcodeView.addSubview(self.highlightView)
        
        
        // create camera object
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Create a nilable NSError to hand off to the next method.
        // Make sure to use the "var" keyword and not "let"
        var error : NSError? = nil
        
        
        let input : AVCaptureDeviceInput? = AVCaptureDeviceInput.deviceInputWithDevice(device, error: &error) as? AVCaptureDeviceInput
        
        // If our input is not nil then add it to the session, otherwise we're kind of done!
        if input != nil {
            session.addInput(input)
        }
        else {
            // This is fine for a demo, do something real with this in your app. :)
            println(error)
        }
        
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        
        
        // Set the previewLayer to the frame and cordinates of the black area. 
        // Adjust as necessary
        previewLayer = AVCaptureVideoPreviewLayer.layerWithSession(session) as! AVCaptureVideoPreviewLayer
        previewLayer.frame = self.barcodeView.bounds
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.barcodeView.layer.addSublayer(previewLayer)
        
        // Start the scanner. You'll have to end it yourself later.
        session.startRunning()
        
    }
    
    // This is called when we find a known barcode type with the camera.
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        var highlightViewRect = CGRectZero
        
        var barCodeObject : AVMetadataObject!
        
        var detectionString : String!
        
        let barCodeTypes = [AVMetadataObjectTypeUPCECode,
            AVMetadataObjectTypeCode39Code,
            AVMetadataObjectTypeCode39Mod43Code,
            AVMetadataObjectTypeEAN13Code,
            AVMetadataObjectTypeEAN8Code,
            AVMetadataObjectTypeCode93Code,
            AVMetadataObjectTypeCode128Code,
            AVMetadataObjectTypePDF417Code,
            AVMetadataObjectTypeQRCode,
            AVMetadataObjectTypeAztecCode
        ]
        
        
        // The scanner is capable of capturing multiple 2-dimensional barcodes in one scan.
        for metadata in metadataObjects {
            
            for barcodeType in barCodeTypes {
                
                if metadata.type == barcodeType {
                    
                    barCodeObject = self.previewLayer.transformedMetadataObjectForMetadataObject(metadata as! AVMetadataMachineReadableCodeObject)
                    
                    highlightViewRect = barCodeObject.bounds
                    
                    detectionString = (metadata as! AVMetadataMachineReadableCodeObject).stringValue
                    
                    self.session.stopRunning()
                    break
                }
                
            }
        }
        
        // Item was found. Display the green line, create the item that's going to be passed
        // pass it and wait
        self.highlightView.frame = highlightViewRect
        self.barcodeView.bringSubviewToFront(self.highlightView)
        
        
        // Display a loading thing
        spinner.hidden = false
        spinner.startAnimating()
        
        // Get item data
        getData(detectionString)
        
        // Remove loading thing
        spinner.stopAnimating()
        
        
        
        //will segue into new view
        self.performSegueWithIdentifier("itemDescriptionSegue", sender: self)
        
    }
    
    
    
    
    func getData(sku: String) {
        if  (delegate!.itemExistsInList(sku)) {
            item = delegate!.getItemFromListWithSku(sku)
            print("apparently found item")
        } else
        {
            print("apparently did not")
            item.price = "1.99"
        }
        
    }
    
    
    func passBackItem(item: AnyObject) {
        if let g = item as? groceryItem {
            delegate?.passBackItem(g)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if  segue.description == "itemDescriptionSegue" {
            println("ASLKJSDFLAKSJDF")
            if let dvc = segue.destinationViewController as? ItemDescriptionViewController {
                dvc.delegate = self
                dvc.itemCaptured = groceryItem()
                dvc.itemCaptured = groceryItem().copy(dvc.itemCaptured!, right: item)
                
                println("Successfully transferred item")
            }
        }
    
    }
    
}