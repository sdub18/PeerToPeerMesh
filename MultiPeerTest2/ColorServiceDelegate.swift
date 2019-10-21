//
//  ColorServiceDelegate.swift
//  MultiPeerTest2
//
//  Created by Sam DuBois on 10/19/19.
//  Copyright © 2019 SamDuBois. All rights reserved.
//

import Foundation

protocol ColorServiceDelegate {
    
    func connectedDevicesChanged(manager : ColorService, connectedDevices: [String])
    func colorChanged(manager : ColorService, colorString: String)
    
}
