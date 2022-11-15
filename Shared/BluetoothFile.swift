//
//  BluetoothFile.swift
//  ElectroSense
//
//  Created by Marko Vukasinovic on 11/15/22.
//

import Foundation
import CoreBluetooth
import os
import SwiftUI

class CoreBluetoothWrap: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var powered_on: Bool;
    var scanning: Bool;
    var connected: Bool;
    var central_manager: CBCentralManager;
    var service: CBUUID;
    var message: String;
    
    override init()
    {
        powered_on = false;
        scanning = false;
        connected = false;
        service = CBUUID(string: "9f37e282-60b6-42b1-a02f-7341da5e2eba");
        central_manager = CBCentralManager(delegate: nil, queue:nil);
        message = "";
        super.init();
    }
    
    func set_manager() {
        self.central_manager = CBCentralManager(delegate: self, queue:nil);
    }
    
    func set_service(insert_val : String) {
        service = CBUUID(string: insert_val);
    }
    
    func scanForItems() {
        central_manager.scanForPeripherals(withServices: [service], options: nil);
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        guard central.state == .poweredOn else { return }
        // Start scanning for peripherals
    }
    
    func centralManager(_ centralManager: CBCentralManager,
                            didConnect peripheral: CBPeripheral) {
      // Stop scanning once we've connected
      centralManager.stopScan()

      // Configure a delegate for the peripheral
      peripheral.delegate = self

      // Scan for the chat characteristic we'll use to communicate
      let service = CBUUID(string: "9f37e282-60b6-42b1-a02f-7341da5e2eba")
      peripheral.discoverServices([service])
    }
    
    func centralManager(_ centralManager: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {

      // Perform any checks on `advertisementData` to confirm this is the correct device

      // Attempt to connect to this device
      centralManager.connect(peripheral, options: nil)

      // Retain the peripheral
      // self.peripheral = peripheral
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
      // If an error occurred, disconnect so we can try again from the start
      if let error = error {
        print("Unable to discover services: \(error.localizedDescription)")
        
        return
      }

      // Specify the characteristic we want
        let characteristic = CBUUID(string: "890aa912-c414-440d-88a2-c7f66179589b")

      // It's possible there may be more than one service,
      // so loop through each one to discover the one that we want
      peripheral.services?.forEach { service in
        peripheral.discoverCharacteristics([characteristic], for: service)
      }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
      // Perform any error handling if one occurred
      if let error = error {
        print("Characteristic value update failed: \(error.localizedDescription)")
        return
      }

      // Retrieve the data from the characteristic
      guard let data = characteristic.value else { return }

      // Decode/Parse the data here
      message = String(decoding: data, as: UTF8.self)
    }

}

