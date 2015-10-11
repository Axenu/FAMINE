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
    var activeScene: FAScene!
    
    var commandQueue: MTLCommandQueue! = nil
    var pipelineState: MTLRenderPipelineState! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup view properties
        let view = self.view as! MTKView
        view.device = device
        view.delegate = self
        
        setScene(setInitialScene())
    }
    
    func setScene(newScene: FAScene) {
        activeScene = newScene
        activeScene.setDevice(device)
        activeScene.setWidth(Int(self.view.frame.width))
        activeScene.setHeight(Int(self.view.frame.height))
        //TODO set callback for scene
        //call scene init
        activeScene.onInit()
    }
    
    func setInitialScene() -> FAScene {
        return GameScene()
    }
    
    func drawInMTKView(view: MTKView) {
        //fps
        if lastFrameTimestamp == 0.0
        {
            lastFrameTimestamp = NSDate().timeIntervalSince1970
        }
        let elapsed:CFTimeInterval = NSDate().timeIntervalSince1970 - lastFrameTimestamp
        lastFrameTimestamp = NSDate().timeIntervalSince1970
        activeScene.onUpdate(Float(elapsed))
        //clear buffers?
//        let drawable = view.currentDrawable
        
        activeScene.onRender(view.currentDrawable!)
    }
    
    func mtkView(view: MTKView, drawableSizeWillChange size: CGSize) {
    }
    
}