//
//  Vertex.swift
//  FAM
//
//  Created by Simon Nilsson on 08/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

struct Vertex {
    
    var x,y,z: Float     // position data
    var r,g,b,a: Float   // color data
    
    func floatBuffer() -> [Float] {
        return [x,y,z,r,g,b,a]
    }
    
};
