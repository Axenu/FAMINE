//
//  mat4.swift
//  FAM
//
//  Created by Simon Nilsson on 09/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import GameKit

func * (left: mat4, right: mat4) -> mat4 {
    return mat4(mat: GLKMatrix4Multiply(left.matrix, right.matrix));
}

class mat4 {
    
    var matrix: GLKMatrix4 = GLKMatrix4()
    
    init(mat: GLKMatrix4) {
        self.matrix = mat
    }
    
    init() {
        
    }
    
    init(fov: Float, aspect: Float, near: Float, far: Float) {
        matrix = GLKMatrix4MakePerspective(fov, aspect, near, far);
    }
    
    func rotate(angle: Float, axis: vec3) {
        matrix = GLKMatrix4Rotate(matrix, angle, axis.x, axis.y, axis.z)
    }
    func rotate(angle: vec3) {
        matrix = GLKMatrix4Rotate(matrix, angle.x, 1, 0, 0)
        matrix = GLKMatrix4Rotate(matrix, angle.y, 0, 1, 0)
        matrix = GLKMatrix4Rotate(matrix, angle.z, 0, 0, 1)
    }
    func translate(vec: vec3) {
        matrix = GLKMatrix4Translate(matrix, vec.x, vec.y, vec.z)
    }
    func makePerspective(fov: Float, aspect: Float, near: Float, far: Float) {
        matrix = GLKMatrix4MakePerspective(fov, aspect, near, far);
    }
    
}