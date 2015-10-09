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
    
}