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

class CoreBluetoothWrap: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
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
//    @State public var heart_rate = StoreHealthData();
    public var to_print = 0.0 {didSet {
        objectWillChange.send()
    }}
    public var to_printEKG = 0.0 {didSet {
        objectWillChange.send()
    }}
    public var ready = false {didSet {
        objectWillChange.send()
    }};
    
    
    
    required override init()
    {
        powered_on = false;
        scanning = false;
        connected = false;
        service = CBUUID(string: "FFE0");
        message = "";
        ready = false;
        let heartRateQuantityType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        let allTypes = Set([HKObjectType.workoutType(),heartRateQuantityType])
        super.init();
//        heart_rate.requestAuthorization(toShare: nil, read: allTypes) { (result, error) in
//            if let error = error {
//                // deal with the error
//                print(error)
//                return
//            }
//            guard result else {
//                // deal with the failed request
//                return
//            }
//        }
    }
    
    let completion_block: (Bool, Error?) -> Void = {
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
        print(service);
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        var consoleLog = "Howdy buddy"

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
        
      //self.heart_rate.requestStoreAuth();
        
      to_print = data_val_int[0];
      if (data_val_int.count > 1) {
          to_printEKG = data_val_int[1];
      }
      print("message");
      print(message)
      //print(to_print);
        
      //self.heart_rate.saveHeartRate(heartRate: data_val_int[0], completion: completion_block);
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?){
        print("discovered service: ", service);
        guard let characteristics = service.characteristics else {
            print("no characteristics");
            return
        }
        for characteristic in characteristics {
            self.peripheral.setNotifyValue(true, for: characteristic)
            self.characteristic = characteristic
            print("discovered characteristic: ", characteristic)
            print("READYY");
            self.ready = true;
        }
    }
    
    func writeOutgoingValue(data: String){
        
        let valueString = (data as NSString).data(using: String.Encoding.utf8.rawValue)
        print(data)
        if let bluefruitPeripheral = self.peripheral {
            if let txCharacteristic = self.characteristic {
                print(txCharacteristic.properties.contains(.writeWithoutResponse));
                print(bluefruitPeripheral.writeValue(valueString!, for: txCharacteristic, type: CBCharacteristicWriteType.withoutResponse))
              }
        } else {
            print("not ready");
//            writeOutgoingValue(data: data);
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print(error)
        } else {
            print("Success!")
            
        }
    }
    
    func get_message()->Int {
        return Int(to_print);
    }
    
    
}

class StoreHealthData: HKHealthStore {
    @Published var title = "StoreHealthData";
    @State var heartRateStore = HKHealthStore();
    public var heartRateQuantity = HKUnit(from: "count/min")
    @State public var value = 0
    var heartRateQuery:HKSampleQuery?
    
    func requestStoreAuth() {
            let writableTypes: Set<HKSampleType> = [
                HKQuantityType.quantityType(forIdentifier: .heartRate)!
            ]
            let readableTypes: Set<HKSampleType> = [
                HKQuantityType.quantityType(forIdentifier: .heartRate)!
            ]
        
        self.heartRateStore.requestAuthorization(toShare: writableTypes, read: readableTypes) { (success, error) -> Void in
                if success {
                } else {
                    print("[HealthKit] request Authorization failed!")
                }
                if let error = error { print("[HealthKit] An error occurred: \(error)") }
            }
    }
    
    func saveHeartRate(date: Date = Date(), heartRate heartRateValue: Double, completion completionBlock: @escaping (Bool, Error?) -> Void) {
        if (heartRateValue != 0.0) {
            let unit = HKUnit.count().unitDivided(by: HKUnit.minute())
            let quantity = HKQuantity(unit: unit, doubleValue: heartRateValue)
            let type = HKQuantityType.quantityType(forIdentifier: .heartRate)!

            let heartRateSample = HKQuantitySample(type: type, quantity: quantity, start: date, end: date)
            let authorizationStatus = heartRateStore.authorizationStatus(for: type)

                    switch authorizationStatus {

                        case .sharingAuthorized:
                        self.heartRateStore.save(heartRateSample) { (success, error) -> Void in
                            if !success {
                                print("An error occured saving the HR sample \(heartRateSample). In your app, try to handle this gracefully. The error was: \(error).") 
                            }
                            completionBlock(success, error)
                        }
                        case .sharingDenied: print("sharing denied")
                        default: print("not determined")

                    }
           
        }
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
            // variable initialization
            var lastHeartRate = 0.0
            
            // cycle and value assignment
            for sample in samples {
                if type == .heartRate {
                    lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
                }
                
                self.value = Int(lastHeartRate)
            }
        }
}
