//
//  FAScene.swift
//  FAM
//
//  Created by Simon Nilsson on 09/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import Foundation

class FAScene {
    
    var device: MTLDevice = MTLCreateSystemDefaultDevice()!
    var rootNode: FANode!
    var model: FAMesh!
    var node: Node!
    var camera: FACamera!
    
    var commandQueue: MTLCommandQueue! = nil
    var pipelineState: MTLRenderPipelineState! = nil
    
    var uniformBuffer: MTLBuffer?
    
    var projectionMatrix: Matrix4?
    
    var width = 0
    var height = 0
    
    func onInit() {
        let bundle = NSBundle.mainBundle()
        let pathNav = bundle.pathForResource("tree", ofType: "fa")
        model = FAMesh(path: pathNav!, device: device)
        
        let A = Vertex(x: -1.0, y:   1.0, z:   1.0, r:  1.0, g:  0.0, b:  0.0)
        let B = Vertex(x: -1.0, y:  -1.0, z:   1.0, r:  0.0, g:  1.0, b:  0.0)
        let C = Vertex(x:  1.0, y:  -1.0, z:   1.0, r:  0.0, g:  0.0, b:  1.0)
        let D = Vertex(x:  1.0, y:   1.0, z:   1.0, r:  0.1, g:  0.6, b:  0.4)
        
        let Q = Vertex(x: -1.0, y:   1.0, z:  -1.0, r:  1.0, g:  0.0, b:  0.0)
        let R = Vertex(x:  1.0, y:   1.0, z:  -1.0, r:  0.0, g:  1.0, b:  0.0)
        let S = Vertex(x: -1.0, y:  -1.0, z:  -1.0, r:  0.0, g:  0.0, b:  1.0)
        let T = Vertex(x:  1.0, y:  -1.0, z:  -1.0, r:  0.1, g:  0.6, b:  0.4)
        
        let verticesArray:Array<Vertex> = [
            A,B,C ,A,C,D,   //Front
            R,T,S ,Q,R,S,   //Back
            
            Q,S,B ,Q,B,A,   //Left
            D,C,T ,D,T,R,   //Right
            
            Q,A,D ,Q,D,R,   //Top
            B,S,T ,B,T,C    //Bot
        ]
        
        
        node = Node(name: "test", vertices: verticesArray, device: device)
        node.scale = 0.5
        node.rotationZ = Matrix4.degreesToRad(45);
        node.positionZ = -2
        
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
        uniformBuffer = device.newBufferWithLength(sizeof(Float) * Matrix4.numberOfElements() * 2, options: [])
        
         projectionMatrix = Matrix4.makePerspectiveViewAngle(Matrix4.degreesToRad(85.0), aspectRatio: Float(self.width / self.height), nearZ: 0.01, farZ: 100.0)
        print("init")
    }
    
    func onUpdate(dt: Float) {
//        print("update scene")
    }
    
    func onRender(drawable: CAMetalDrawable) {
        
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .Clear
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        renderPassDescriptor.colorAttachments[0].storeAction = .Store
        let commandBuffer = commandQueue.commandBuffer()
        
        let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
        renderEncoder.setCullMode(MTLCullMode.Front)
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(node.vertexBuffer, offset: 0, atIndex: 0)

        let nodeModelMatrix = Matrix4()
        nodeModelMatrix.translate(0, y: 0, z: -2)
//        nodeModelMatrix.multiplyLeft(parentModelViewMatrix)
        let bufferPointer = uniformBuffer?.contents()
        memcpy(bufferPointer!, nodeModelMatrix.raw(), sizeof(Float) * Matrix4.numberOfElements())
        memcpy(bufferPointer! + sizeof(Float)*Matrix4.numberOfElements(), projectionMatrix!.raw(), sizeof(Float)*Matrix4.numberOfElements())
        renderEncoder.setVertexBuffer(self.uniformBuffer, offset: 0, atIndex: 1)
        
        renderEncoder.drawPrimitives(.Triangle, vertexStart: 0, vertexCount: node.vertexCount, instanceCount: node.vertexCount/3)
        renderEncoder.endEncoding()
//
        commandBuffer.presentDrawable(drawable)
        commandBuffer.commit()
        
//        print("render secen")
    }
    
    func setDevice(device: MTLDevice) {
        self.device = device
    }
    
    func setWidth(width: Int) {
        self.width = width
    }
    func setHeight(height: Int) {
        self.height = height
    }
    
}