//
//  mat4.swift
//  FAM
//
//  Created by Simon Nilsson on 12/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import GLKit

func * (left: mat4, right: mat4) -> mat4 {
    left.multiplyLeft(right)
    return left
}

extension mat4 {
    
    func translate(vec: vec3) {
        self.translate(vec.x, y: vec.y, z: vec.z)
//        self.glkMatrix = GLKMatrix4Translate(self.glkMatrix, vec.x, vec.y, vec.z);
    }
    
    func rotate(vec: vec3) {
        self.rotateAroundX(vec.x, y: vec.y, z: vec.z)
    }
    
}
