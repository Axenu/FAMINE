//
//  vec3.swift
//  FAM
//
//  Created by Simon Nilsson on 09/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import GameKit

func * (left: vec3, right: vec3) -> vec3 {
    return vec3(vec: GLKVector3Multiply(left.vector, right.vector));
}

class vec3 {
    
    var vector: GLKVector3 = GLKVector3Make(0.0, 0.0, 0.0)
    var x: Float {
        get {
            return vector.x
        }
        set(x) {
            vector.v.0 = x
        }
    }
    var y: Float {
        get {
            return vector.x
        }
        set(y) {
            vector.v.1 = y
        }
    }
    var z: Float {
        get {
            return vector.x
        }
        set(z) {
            vector.v.2 = z
        }
    }
    
    init(vec: GLKVector3) {
        self.vector = vec
    }
    
    init() {
        
    }
    
}
