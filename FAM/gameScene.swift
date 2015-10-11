//
//  gameScene.swift
//  FAM
//
//  Created by Simon Nilsson on 11/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import Foundation

class GameScene : FAScene {
    
    var model: FAMesh!
//    var projectionMatrix: Matrix4?
    
    //initial setup
    override func setup() {
        let bundle = NSBundle.mainBundle()
        let pathNav = bundle.pathForResource("tree", ofType: "fa")
        model = FAMesh(path: pathNav!, device: device)
        let m = FAModel(mesh: model, device: device)
        self.addChild(m)
        
//        let defaultLibrary = device.newDefaultLibrary()
//        let fragmentProgram = defaultLibrary!.newFunctionWithName("basic_fragment")
//        let vertexProgram = defaultLibrary!.newFunctionWithName("basic_vertex")
//        
//        let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
//        pipelineStateDescriptor.vertexFunction = vertexProgram
//        pipelineStateDescriptor.fragmentFunction = fragmentProgram
//        pipelineStateDescriptor.colorAttachments[0].pixelFormat = .BGRA8Unorm
//        
//        do {
//            pipelineState = try device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor)
//        } catch {
//            print("Failed to create pipline state, error: ")
//        }
        
//        commandQueue = device.newCommandQueue()
//        uniformBuffer = device.newBufferWithLength(sizeof(Float) * Matrix4.numberOfElements() * 2, options: [])
        
        projectionMatrix = Matrix4.makePerspectiveViewAngle(Matrix4.degreesToRad(85.0), aspectRatio: Float(self.width / self.height), nearZ: 0.01, farZ: 100.0)
        print("init")
    }
    
//    override func onRender(drawable: CAMetalDrawable) {
//        let renderPassDescriptor = MTLRenderPassDescriptor()
//        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
//        renderPassDescriptor.colorAttachments[0].loadAction = .Clear
//        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)
//        renderPassDescriptor.colorAttachments[0].storeAction = .Store
//        let commandBuffer = commandQueue.commandBuffer()
//        
//        let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
//        renderEncoder.setCullMode(MTLCullMode.Front)
//        renderEncoder.setRenderPipelineState(pipelineState)
//        renderEncoder.setVertexBuffer(model.vertexBuffer, offset: 0, atIndex: 0)
////        
//        let nodeModelMatrix = Matrix4()
//        nodeModelMatrix.translate(0, y: 0, z: -10)
//        //        nodeModelMatrix.multiplyLeft(parentModelViewMatrix)
//        let bufferPointer = uniformBuffer?.contents()
//        memcpy(bufferPointer!, nodeModelMatrix.raw(), sizeof(Float) * Matrix4.numberOfElements())
//        memcpy(bufferPointer! + sizeof(Float)*Matrix4.numberOfElements(), projectionMatrix!.raw(), sizeof(Float)*Matrix4.numberOfElements())
//        renderEncoder.setVertexBuffer(self.uniformBuffer, offset: 0, atIndex: 1)
//        
//        renderEncoder.drawPrimitives(.Triangle, vertexStart: 0, vertexCount: model.vertexCount)
//        renderEncoder.endEncoding()
//        //
//        commandBuffer.presentDrawable(drawable)
//        commandBuffer.commit()
//    }
    
}