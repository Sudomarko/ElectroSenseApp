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
import HealthKit

class CoreBluetoothWrap: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var title = "CoreBluetoothWrap";
    var powered_on: Bool;
    var scanning: Bool;
    var connected: Bool;
    private var central_manager: CBCentralManager!;
    private var peripheral: CBPeripheral!;
    private var characteristic: CBCharacteristic!;
    var service: CBUUID;
    var message: String;
    var data_val_string = [String] ();
    var data_val_int = [Double] ();
    var heart_rate = StoreHealthData();
    
    
    required override init()
    {
        powered_on = false;
        scanning = false;
        connected = false;
        service = CBUUID(string: "FFE0");
        message = "";
        let heartRateQuantityType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let allTypes = Set([HKObjectType.workoutType(),
                              heartRateQuantityType
            ])
        heart_rate.requestAuthorization(toShare: nil, read: allTypes) { (result, error) in
            if let error = error {
                // deal with the error
                print(error)
                return
            }
            guard result else {
                // deal with the failed request
                return
            }
        }
        super.init();
        
    }
    
    let completion_block: (Bool, (any Error)?) -> Void = {
        (success, error) -> Void in
            if !success {
                abort()
            }
    }
    
    func set_manager() {
        self.central_manager = CBCentralManager.init(delegate: self, queue: DispatchQueue(label: "BT_queue"));
    }
    
    func set_service(insert_val : String) {
        service = CBUUID(string: insert_val);
    }
    
    func scanForItems() {
        central_manager.scanForPeripherals(withServices: [service], options: nil);
        print("scanning for items");
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var consoleLog = ""

        switch central.state {
              case .poweredOff:
                  consoleLog = "BLE is powered off"
              case .poweredOn:
                  consoleLog = "BLE is poweredOn"
                  self.scanForItems();
              case .resetting:
                  consoleLog = "BLE is resetting"
              case .unauthorized:
                  consoleLog = "BLE is unauthorized"
              case .unknown:
                  consoleLog = "BLE is unknown"
              case .unsupported:
                  consoleLog = "BLE is unsupported"
              default:
                  consoleLog = "default"
        }
        print(consoleLog)
        return;
        
    }
    
    func centralManager(_ centralManager: CBCentralManager,
                            didConnect peripheral: CBPeripheral) {
        print("connected");
      // Stop scanning once we've connected
      centralManager.stopScan()

      // Configure a delegate for the peripheral
      peripheral.delegate = self

      // Scan for the chat characteristic we'll use to communicate
      peripheral.discoverServices([service])
    }
    
    func centralManager(_ centralManager: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {

      // Perform any checks on `advertisementData` to confirm this is the correct device
      print("discovered device");
      // Attempt to connect to this device
      centralManager.connect(peripheral, options: nil)

      // Retain the peripheral
      self.peripheral = peripheral
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("discovered peripheral: ", peripheral);
        
      // If an error occurred, disconnect so we can try again from the start
      if let error = error {
        print("Unable to discover services: \(error.localizedDescription)")
        
        return
      }

      // Specify the characteristic we want
      let characteristic = CBUUID(string: "FFE1")

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
      self.message = String(decoding: data, as: UTF8.self)
        
      self.data_val_string = message.components(separatedBy: ",")
        
      self.data_val_int = data_val_string.map {(Double($0.replacingOccurrences(of:"\r\n", with: "")) ?? 0)!}
        
      print(data_val_int);
        
      self.heart_rate.saveHeartRate(heartRate: data_val_int[0], completion: completion_block);
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?){
        print("discovered service: ", service);
        guard let characteristics = service.characteristics else {
            print("no characteristics");
            return
        }
        for characteristic in characteristics {
            print("discovered characteristic: ", characteristic)
            self.peripheral.setNotifyValue(true, for: characteristic)
        }
    }
    
    func get_message()->String {
        return String(message);
    }
    
    
}

class StoreHealthData: HKHealthStore {
    @Published var title = "StoreHealthData";
    var heartRateStore = HKHealthStore();
    
    
    func saveHeartRate(date: Date = Date(), heartRate heartRateValue: Double, completion completionBlock: @escaping (Bool, Error?) -> Void) {
        let unit = HKUnit.count().unitDivided(by: HKUnit.minute())
        let quantity = HKQuantity(unit: unit, doubleValue: heartRateValue)
        let type = HKQuantityType.quantityType(forIdentifier: .heartRate)!

        let heartRateSample = HKQuantitySample(type: type, quantity: quantity, start: date, end: date)

        self.heartRateStore.save(heartRateSample) { (success, error) -> Void in
            if !success {
                print("An error occured saving the HR sample \(heartRateSample). In your app, try to handle this gracefully. The error was: \(error).")
            }
            completionBlock(success, error)
        }
    }

}
