//
//  FAModel.swift
//  FAM
//
//  Created by Simon Nilsson on 11/10/15.
//  Copyright © 2015 Simon Nilsson. All rights reserved.
//

import Foundation

class FAModel : FANode {
    
    var mesh: FAMesh?
    var material: FAMaterial?
    
    var device: MTLDevice?
    
    override init() {
        super.init()
    }
    
    init(mesh: FAMesh, device: MTLDevice) {
        super.init()
        self.mesh = mesh
        self.material = FAMaterial(device: device)
    }
    
    func setMesh(mesh: FAMesh) {
        self.mesh = mesh
    }
    
    func setMesh(path: String) {
        self.mesh = FAMesh(path: path, device: device!)
    }
    
    
    
}
