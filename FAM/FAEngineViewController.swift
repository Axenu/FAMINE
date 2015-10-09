//
//  FAEngineViewController.swift
//  FAM
//
//  Created by Simon Nilsson on 09/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import UIKit
import Metal
import MetalKit

class FAEngineViewController:UIViewController, MTKViewDelegate {
    
    let device: MTLDevice = MTLCreateSystemDefaultDevice()!
    var lastFrameTimestamp: CFTimeInterval = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup view properties
        let view = self.view as! MTKView
        view.device = device
        view.delegate = self
        
        
    }
    
    func drawInMTKView(view: MTKView) {
        //fps
        if lastFrameTimestamp == 0.0
        {
            lastFrameTimestamp = NSDate().timeIntervalSince1970
        }
        let elapsed:CFTimeInterval = NSDate().timeIntervalSince1970 - lastFrameTimestamp
        lastFrameTimestamp = NSDate().timeIntervalSince1970
    }
    
    func mtkView(view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
}