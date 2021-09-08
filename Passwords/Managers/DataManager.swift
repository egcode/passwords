//
//  DataManager.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import Foundation

@objcMembers public class DataManager: NSObject {
    
    public static let shared = DataManager()
    
    override init() {
        super.init()
    }
    
//    private func fakeData() {
//        for i in 1...5 {
//            if let s = self.sites.first, let l = s.locations.first, let d = l.devices.first {
//                // SITE
//                let newSite = Site(data: s.data)
//
//                // LOCATION
//                let newLocation = Location(data: l.data)
//                newLocation.name = "Location  \(String(format: "%03d", i))"
//
//                // DEVICE
//                let newDevice = Device(data: d.data)
//                newDevice.name = "Camera  \(String(format: "%03d", i))"
//                newLocation.devices.append(newDevice)
//
//
//                newSite.locations.append(newLocation)
//                self.sites.append(newSite)
//            }
//        }
//    }
    
    
}
