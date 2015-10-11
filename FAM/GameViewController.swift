//
//  GameViewController.swift
//  FAM
//

//  Copyright (c) 2015 Simon Nilsson. All rights reserved.
//

import UIKit
import Metal
import MetalKit
import GLKit

let MaxBuffers = 3
let ConstantBufferSize = 1024*1024

class GameViewController:UIViewController, MTKViewDelegate {
    
    let device: MTLDevice = MTLCreateSystemDefaultDevice()!
    var commandQueue: MTLCommandQueue! = nil
    var pipelineState: MTLRenderPipelineState! = nil
    var objectToDraw: Cube!
    var projectionMatrix: mat4!
    var lastFrameTimestamp: CFTimeInterval = 0.0
//    var vertexColorBuffer: MTLBuffer! = nil
//    
//    let inflightSemaphore = dispatch_semaphore_create(MaxBuffers)
//    var bufferIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup view properties
        let view = self.view as! MTKView
        view.device = device
        view.delegate = self
        
        loadAssets()
        
    }
    
    func loadAssets() {
        
        projectionMatrix = mat4.makePerspectiveViewAngle(mat4.degreesToRad(85.0), aspectRatio: Float(self.view.bounds.size.width / self.view.bounds.size.height), nearZ: 0.01, farZ: 100.0)
        
        objectToDraw = Cube(device: device)
//        objectToDraw.positionX = 0.0
//        objectToDraw.positionY =  0.0
//        objectToDraw.positionZ = -2.0
//        objectToDraw.rotationZ = Matrix4.degreesToRad(45);
//        objectToDraw.scale = 0.5
        
        let defaultLibrary = device.newDefaultLibrary()
        let fragmentProgram = defaultLibrary!.newFunctionWithName("basic_fragment")
        let vertexProgram = defaultLibrary!.newFunctionWithName("basic_vertex")
        
        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
        pipelineStateDescriptor.vertexFunction = vertexProgram
        pipelineStateDescriptor.fragmentFunction = fragmentProgram
        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .BGRA8Unorm
        
        do {
            pipelineState = try device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor)
        } catch {
            print("Failed to create pipline state, error: ")
        }
        
        commandQueue = device.newCommandQueue()
        
        
//        let view = self.view as! MTKView
//        commandQueue = device.newCommandQueue()
//        commandQueue.label = "main command queue"
        
    }
    
    func update() {
        if lastFrameTimestamp == 0.0
        {
            lastFrameTimestamp = NSDate().timeIntervalSince1970
        }
        
        // 2
        let elapsed:CFTimeInterval = NSDate().timeIntervalSince1970 - lastFrameTimestamp
        lastFrameTimestamp = NSDate().timeIntervalSince1970
        objectToDraw.updateWithDelta(elapsed)
    }
    
    func drawInMTKView(view: MTKView) {
        
        self.update()
        
        
        
        let drawable = view.currentDrawable
        let worldModelMatrix = mat4()
        worldModelMatrix.translate(0.0, y: 0.0, z: -6.0)
        worldModelMatrix.rotateAroundX(mat4.degreesToRad(25), y: 0.0, z: 0.0)
        
        objectToDraw.render(commandQueue, pipelineState: pipelineState, drawable: drawable!, parentModelViewMatrix: worldModelMatrix, projectionMatrix: projectionMatrix ,clearColor: nil)
        
    }
    
    
    func mtkView(view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
}
