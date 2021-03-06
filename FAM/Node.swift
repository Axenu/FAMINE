//
//  Node.swift
//  FAM
//
//  Created by Simon Nilsson on 08/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import Foundation
import Metal
import QuartzCore
import GLKit

class Node {
    
    let name: String
    var vertexCount: Int
    var vertexBuffer: MTLBuffer
    var uniformBuffer: MTLBuffer?
    var device: MTLDevice
    
    var positionX:Float = 0.0
    var positionY:Float = 0.0
    var positionZ:Float = 0.0
    
    var rotationX:Float = 0.0
    var rotationY:Float = 0.0
    var rotationZ:Float = 0.0
    var scale:Float     = 1.0
    
    var time:CFTimeInterval = 0.0
    
    init(name: String, vertices: Array<Vertex>, device: MTLDevice){
        var vertexData = Array<Float>()
        for vertex in vertices{
            vertexData += vertex.floatBuffer()
        }
        
        let dataSize = vertexData.count * sizeofValue(vertexData[0])
        vertexBuffer = device.newBufferWithBytes(vertexData, length: dataSize, options: [])
        
        self.name = name
        self.device = device
        vertexCount = vertices.count
        
        uniformBuffer = device.newBufferWithLength(sizeof(Float) * mat4.numberOfElements() * 2, options: [])
    }
    
    func render(commandQueue: MTLCommandQueue, pipelineState: MTLRenderPipelineState, drawable: CAMetalDrawable, parentModelViewMatrix: mat4, projectionMatrix: mat4, clearColor: MTLClearColor?) {
        
        let renderPassDescriptor = MTLRenderPassDescriptor()
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture
        renderPassDescriptor.colorAttachments[0].loadAction = .Clear
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)
        renderPassDescriptor.colorAttachments[0].storeAction = .Store
        
        let commandBuffer = commandQueue.commandBuffer()
        
        let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor)
        renderEncoder.setCullMode(MTLCullMode.Front)
        renderEncoder.setRenderPipelineState(pipelineState)
        renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, atIndex: 0)
        
        let nodeModelMatrix = self.modelMatrix()
        nodeModelMatrix.multiplyLeft(parentModelViewMatrix)
        let bufferPointer = uniformBuffer?.contents()
        memcpy(bufferPointer!, nodeModelMatrix.raw(), sizeof(Float) * mat4.numberOfElements())
        memcpy(bufferPointer! + sizeof(Float)*mat4.numberOfElements(), projectionMatrix.raw(), sizeof(Float)*mat4.numberOfElements())
        renderEncoder.setVertexBuffer(self.uniformBuffer, offset: 0, atIndex: 1)
        
        renderEncoder.drawPrimitives(.Triangle, vertexStart: 0, vertexCount: vertexCount, instanceCount: vertexCount/3)
        renderEncoder.endEncoding()
        
        commandBuffer.presentDrawable(drawable)
        commandBuffer.commit()
    }
    
    func updateWithDelta(delta: CFTimeInterval){
        time += delta
    }
    
    func modelMatrix() -> mat4 {
        let matrix = mat4()
        matrix.translate(positionX, y: positionY, z: positionZ)
        matrix.rotateAroundX(rotationX, y: rotationY, z: rotationZ)
        matrix.scale(scale, y: scale, z: scale)
        return matrix
    }
    
}