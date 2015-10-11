//
//  FACamera.swift
//  FAM
//
//  Created by Simon Nilsson on 09/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//


class FACamera : FANode {
    
    var fieldOfView:Float = 0.0
    var aspectRatio:Float = 0.0
    var nearPlane:Float = 0.0
    var farPlane:Float = 0.0
    var width:Float = 0.0
    var height:Float = 0.0
//    var perspective = false
    
    var viewMatrix = mat4()
    var projectionMatrix = mat4()
    var viewProjectionMatrix = mat4()
    
//    override init() {
//        super.init()
//    }
    
    init(fov: Float, aspect: Float, near: Float, far: Float) {
        super.init()
        self.fieldOfView = fov
        self.aspectRatio = aspect
        self.nearPlane = near
        self.farPlane = far
//        self.perspective = true
        self.initProjection()
    }
    
    init(fov: Float, width: Float, height: Float, near: Float, far: Float) {
        super.init()
        self.width = width
        self.height = height
        self.nearPlane = near
        self.farPlane = far
        self.fieldOfView = fov
        self.aspectRatio = width/height
//        self.perspective = false
        self.initProjection()
    }
    
    func initProjection() {
        projectionMatrix = mat4(perspectiveAngle: fieldOfView, aspectRatio: aspectRatio, nearPlane: nearPlane, farPlane: farPlane)
    }
    
    func useView() {
        viewMatrix = mat4()
        viewMatrix.rotate(rotation)
        viewMatrix.translate(position)
        viewProjectionMatrix = projectionMatrix * viewMatrix
    }
    
}
