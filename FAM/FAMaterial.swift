//
//  FAMaterial.swift
//  FAM
//
//  Created by Simon Nilsson on 11/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import Foundation

class FAMaterial {
    
    var pipelineState: MTLRenderPipelineState!
    
    init(device: MTLDevice) {
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
    }
    
}