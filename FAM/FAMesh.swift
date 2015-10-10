//
//  FAMesh.swift
//  FAM
//
//  Created by Simon Nilsson on 09/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import Foundation

class FAMesh {
    
    var vertexCount: Int = 0
    var vertexBuffer: MTLBuffer?
    var uniformBuffer: MTLBuffer?
    var device: MTLDevice
    
    var hasNormal = false
    var hasColor = false
    var hasUV = false
    
    init(device: MTLDevice) {
        
//        var vertexData = Array<Float>()
//        for vertex in vertices {
//            vertexData += vertex.floatBuffer()
//        }
//        
//        let dataSize = vertexData.count * sizeofValue(vertexData[0])
//        vertexBuffer = device.newBufferWithBytes(vertexData, length: dataSize, options: [])
        
        self.device = device
//        vertexCount = vertices.count
//        
//        uniformBuffer = device.newBufferWithLength(sizeof(Float) * Matrix4.numberOfElements() * 2, options: [])
    }
    
    init(path: String, device: MTLDevice) {
        
        self.device = device
        
        loadModel(path)
        
    }
    
    func loadModel(path: String) {
        if let aStreamReader = StreamReader(path: path) {
            
            var vertexArray = [vec3]()
            var normalArray = [vec3]()
            var UVArray = [vec2]()
            var colorArray = [Int]()
            var materialArray = [vec3]()
            var vertices = [Float]()
            var indices = [UInt]()
            
            while let line = aStreamReader.nextLine() {
                
                var count = 0
                if (line == "v") {
                    count = Int(aStreamReader.nextLine()!)!
                    let vec = vec3()
                    for (var i = 0; i < count; i++) {
                        vec.x = Float(aStreamReader.nextLine()!)!
                        vec.y = Float(aStreamReader.nextLine()!)!
                        vec.z = Float(aStreamReader.nextLine()!)!
                        vertexArray.append(vec)
                    }
                } else if (line == "n") {
                    hasNormal = true
                    count = Int(aStreamReader.nextLine()!)!
                    let vec = vec3()
                    for (var i = 0; i < count; i++) {
                        vec.x = Float(aStreamReader.nextLine()!)!
                        vec.y = Float(aStreamReader.nextLine()!)!
                        vec.z = Float(aStreamReader.nextLine()!)!
                        normalArray.append(vec)
                    }
                } else if (line == "c") {
                    hasColor = true
                    count = Int(aStreamReader.nextLine()!)!
                    var index = 0
                    for (var i = 0; i < count; i++) {
                        index = Int(aStreamReader.nextLine()!)!
                        colorArray.append(index)
                    }
                } else if (line == "m") {
                    count = Int(aStreamReader.nextLine()!)!
                    let vec = vec3()
                    for (var i = 0; i < count; i++) {
                        vec.x = Float(aStreamReader.nextLine()!)!
                        vec.y = Float(aStreamReader.nextLine()!)!
                        vec.z = Float(aStreamReader.nextLine()!)!
                        materialArray.append(vec)
                    }
                } else if (line == "uv") {
                    count = Int(aStreamReader.nextLine()!)!
                    let vec = vec2()
                    for (var i = 0; i < count; i++) {
                        vec.x = Float(aStreamReader.nextLine()!)!
                        vec.y = Float(aStreamReader.nextLine()!)!
                        UVArray.append(vec)
                    }
                } else if (line == "i") {
                    count = Int(aStreamReader.nextLine()!)!
                    for (var i: UInt = 0; Int(i) < count*3; i++) {
                        indices.append(i)
                    }
                    var face = 0
                    var v1, v2, v3, n, uv1, uv2, uv3:Int
                    n = 0
                    uv1 = 0
                    uv2 = 0
                    uv3 = 0
//                    hasNormal = false
                    for (var i = 0; i < count; i++) {
                        v1 = Int(aStreamReader.nextLine()!)!
                        v2 = Int(aStreamReader.nextLine()!)!
                        v3 = Int(aStreamReader.nextLine()!)!
                        if (hasNormal) {
                            n = Int(aStreamReader.nextLine()!)!
                        }
                        if (hasColor) {
                            face = colorArray[0]
                        }
                        if (hasUV) {
                            uv1 = Int(aStreamReader.nextLine()!)!
                            uv2 = Int(aStreamReader.nextLine()!)!
                            uv3 = Int(aStreamReader.nextLine()!)!
                        }
                        vertices.append(vertexArray[v1].x)
                        vertices.append(vertexArray[v1].y)
                        vertices.append(vertexArray[v1].z)
//                        if (hasNormal) {
//                            vertices.append(normalArray[n].x)
//                            vertices.append(normalArray[n].y)
//                            vertices.append(normalArray[n].z)
//                        }
                        if (hasColor) {
                            vertices.append(materialArray[face].x)
                            vertices.append(materialArray[face].y)
                            vertices.append(materialArray[face].z)
                        }
                        if (hasUV) {
                            vertices.append(UVArray[uv1].x)
                            vertices.append(UVArray[uv1].y)
                        }
                        
                        vertices.append(vertexArray[v2].x)
                        vertices.append(vertexArray[v2].y)
                        vertices.append(vertexArray[v2].z)
//                        if (hasNormal) {
//                            vertices.append(normalArray[n].x)
//                            vertices.append(normalArray[n].y)
//                            vertices.append(normalArray[n].z)
//                        }
                        if (hasColor) {
                            vertices.append(materialArray[face].x)
                            vertices.append(materialArray[face].y)
                            vertices.append(materialArray[face].z)
                        }
                        if (hasUV) {
                            vertices.append(UVArray[uv2].x)
                            vertices.append(UVArray[uv2].y)
                        }
                        
                        vertices.append(vertexArray[v3].x)
                        vertices.append(vertexArray[v3].y)
                        vertices.append(vertexArray[v3].z)
//                        if (hasNormal) {
//                            vertices.append(normalArray[n].x)
//                            vertices.append(normalArray[n].y)
//                            vertices.append(normalArray[n].z)
//                        }
                        if (hasColor) {
                            vertices.append(materialArray[face].x)
                            vertices.append(materialArray[face].y)
                            vertices.append(materialArray[face].z)
                        }
                        if (hasUV) {
                            vertices.append(UVArray[uv3].x)
                            vertices.append(UVArray[uv3].y)
                        }
                    }
                } else {
                    print("unknown character: \(line)")
                }
                
            }
            
            vertexCount = indices.count
            
            //setup metal buffers
            
            let dataSize = vertices.count * sizeofValue(vertices[0])
            vertexBuffer = device.newBufferWithBytes(vertices, length: dataSize, options: [])
            
//            uniformBuffer = device.newBufferWithLength(sizeof(Float) * Matrix4.numberOfElements() * 2, options: [])
            
            //close file
            aStreamReader.close()
        }
    }
}
