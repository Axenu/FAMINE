//
//  FANode.swift
//  FAM
//
//  Created by Simon Nilsson on 09/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//



class FANode {
    
    var position: vec3 = vec3()
    var rotation: vec3 = vec3()
    var scale: vec3 = vec3()
    var modelMatrix: mat4 = mat4()
    
    func setX(x: Float) {
        position.x = x
    }
    
    func setY(y: Float) {
        position.y = y
    }
    
    func setZ(z: Float) {
        position.z = z
    }
    func setPosition(x: Float, y: Float, z: Float) {
        position.x = x
        position.y = y
        position.z = z
    }
    func setPosition(vec: vec3) {
        position = vec
    }
    func moveX(x: Float) {
        position.x += x
    }
    func moveY(y: Float) {
        position.y += y
    }
    func moveZ(z: Float) {
        position.z += z
    }
    func move(vec: vec3) {
        position.x += vec.x
        position.y += vec.y
        position.z += vec.z
    }
    func setScale(s: Float) {
        scale.x = s
        scale.y = s
        scale.z = s
    }
    func setScale(vec: vec3) {
        scale = vec
    }
    func setScale(x: Float, y: Float, z: Float) {
        scale.x = x
        scale.y = y
        scale.z = z
    }
    
    func update(dt: Float) {
        print("node update!")
        
        onUpdate(dt)
    }
    
    func onUpdate(dt: Float) {
        //to be overwritten
    }
    
    func render() {
        onRender()
    }
    
    func onRender() {
        //to be overwritten
    }
    
}
