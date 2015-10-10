//
//  vec2.swift
//  FAM
//
//  Created by Simon Nilsson on 09/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import GameKit

func * (left: vec2, right: vec2) -> vec2 {
    return vec2(vec: GLKVector2Multiply(left.vector, right.vector));
}

class vec2 {
    
    var vector: GLKVector2 = GLKVector2Make(0.0, 0.0)
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
    
    init(vec: GLKVector2) {
        self.vector = vec
    }
    
    init() {
        
    }
    
}