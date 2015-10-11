//
//  vec3.swift
//  FAM
//
//  Created by Simon Nilsson on 09/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import GameKit

//func * (left: vec3, right: vec3) -> vec3 {
//    return vec3(left.x*left.y, left.y*right.y);
//}

class vec3 {
    
//    var vector: GLKVector3 = GLKVector3Make(0.0, 0.0, 0.0)
//    var x: Float {
//        get {
//            return vector.x
//        }
//        set(x) {
//            vector.v.0 = x
//        }
//    }
//    var y: Float {
//        get {
//            return vector.x
//        }
//        set(y) {
//            vector.v.1 = y
//        }
//    }
//    var z: Float {
//        get {
//            return vector.x
//        }
//        set(z) {
//            vector.v.2 = z
//        }
//    }
    
    init(x: Float, y: Float, z: Float) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init() {
        
    }
    
    var x:Float = 0.0
    var y:Float = 0.0
    var z:Float = 0.0
    
}
