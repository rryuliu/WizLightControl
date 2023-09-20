//
//  LightControler.swift
//  LightControl
//
//  Created by rryu on 2023/1/12.
//

import Foundation
import Socket
import Dispatch

class LightControler {
    var s: Socket!
//    var ip: String
//    
//    init(ip: String) {
//        self.ip = ip
//    }
    
    //    //参数控制
    //    func clampValue(value:Int, min:Int , max:Int) {
    //        if value < min {
    //            var value = min
    //        }
    //        if value > max {
    //            var value = max
    //        }
    //    }
    
    // 发送信息
//    {"method":"getPilot","params":{}}
    
    func messageSend(ip:String, sendMessage: String) {
        let message = sendMessage
        var readData:Data = message.data(using: .utf8)!
        do {
            s = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            let addr = Socket.createAddress(for: ip, on: 38899)!
            try s.write(from: message, to: addr)
            _ = try s.readDatagram(into: &readData)
            let resp = String(data: readData, encoding: .utf8)!
            print(resp)
        } catch let error {
            print(error)
        }
    }
    
    func checkLightState(ip: String) -> Bool {
        let message = """
            {"method":"getPilot","params":{}}
        """
        var readData:Data = message.data(using: .utf8)!
        let lightState:Bool = false
        
        do {
            s = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            let addr = Socket.createAddress(for: ip, on: 38899)!
            try s.write(from: message, to: addr)
            _ = try s.readDatagram(into: &readData)
            let resp = String(data: readData, encoding: .utf8)!
            print(resp)
        } catch let error {
            print(error)
        }
        return lightState
    }
    
    
    // 开灯
    func turnOn(ip: String) {
        let message = """
        {
            "method":"setPilot",
            "params":{
                "state":true
            }
        }
    """
        do {
            s = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            let addr = Socket.createAddress(for: ip, on: 38899)!
            try s.write(from: message, to: addr)
        } catch let error {
            print(error)
        }
        
    }
    
    // 关灯
    func turnOff(ip: String) {
        let message = """
        {
            "method":"setPilot",
            "params":{
                "state":false
            }
        }
    """
        do {
            s = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            let addr = Socket.createAddress(for: ip, on: 38899)!
            try s.write(from: message, to: addr)
        } catch let error {
            print(error)
        }
    }    
    
    // 改变场景
    func setScene(ip: String,scene: Int) {
        let message = """
        {"method": "setPilot", "params": {"sceneID": \(scene), "state": true}}
    """
        do {
            s = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            let addr = Socket.createAddress(for: ip, on: 38899)!
            try s.write(from: message, to: addr)
        } catch let error {
            print(error)
        }
    }
    
    // 调节色温
    func setTemp(ip: String, temp: Double = 4400) {
        let message = """
        {"method": "setPilot", "params": {"temp": \(temp)}}
    """
        do {
            s = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            let addr = Socket.createAddress(for: ip, on: 38899)!
            try s.write(from: message, to: addr)
        } catch let error {
            print(error)
        }
    }
    
    // 调节亮度
    func setBrightess(ip: String, brightness: Double = 100) {
        let message = """
        {"method": "setPilot", "params": {"dimming": \(brightness), "state": true}}
    """
        do {
            s = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            let addr = Socket.createAddress(for: ip, on: 38899)!
            try s.write(from: message, to: addr)
        } catch let error {
            print(error)
        }
    }
    
    // 调节速度
    func setSpeed(ip: String, speed: Double = 100) {
        let message = """
        {"method": "setPilot", "params": {"speed": \(speed)}}
    """
        do {
            s = try Socket.create(family: .inet, type: .datagram, proto: .udp)
            let addr = Socket.createAddress(for: ip, on: 38899)!
            try s.write(from: message, to: addr)
        } catch let error {
            print(error)
        }
    }
    
}
