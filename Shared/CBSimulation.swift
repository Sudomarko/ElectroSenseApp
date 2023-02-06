//
//  CBSimulation.swift
//  ElectroSense
//
//  Created by Marko Vukasinovic on 2/6/23.
//
import Foundation
import CoreBluetooth
import os
import SwiftUI
import HealthKit

class CBSimulation: NSObject,ObservableObject {
    public var to_printHR = 40.0 {didSet {
        objectWillChange.send()
    }}
    public var to_printEKG = 500.0 {didSet {
        objectWillChange.send()
    }}
    public var to_printPO = 89.0 {didSet {
        objectWillChange.send()
    }}
    public var to_printTemp = 35.0 {didSet {
        objectWillChange.send()
    }}
    
    public var cont_gen = true {didSet {
        objectWillChange.send()
    }}
    
    
    
    required override init()
    {
        super.init();
    }
    
    
    func genVals() {
        cont_gen = true;
        let HR_max = 120.0;
        let HR_min = 60.0;
        var HRdir = 0;
        
        let EKG_max = 1000.0;
        let EKG_min = 500.0;
        var EKGdir = 0;
        
        let PO_max = 96.0;
        let PO_min = 90.0;
        var POdir = 0;
        
        let Temp_max = 40.0;
        let Temp_min = 35.0;
        var Tempdir = 0;
        DispatchQueue.global(qos: .userInitiated).async {
        while(self.cont_gen) {
            sleep(1);
            // Simulate Heart Rate
            if (self.to_printHR > HR_max) {
                HRdir = 0;
            } else if (self.to_printHR < HR_min) {
                HRdir = 1;
            }
                
            if (HRdir == 0) {
                self.to_printHR = self.to_printHR - 1.0;
            } else {
                self.to_printHR = self.to_printHR + 1.0;
            }
                // Simulate EKG
            if (self.to_printEKG > EKG_max) {
                EKGdir = 0;
            } else if (self.to_printEKG < EKG_min) {
                EKGdir = 1;
            }
                
            if (EKGdir == 0) {
                self.to_printEKG = self.to_printEKG - 10.0;
            } else {
                self.to_printEKG = self.to_printEKG + 10.0;
            }
                // Simulate Pulse Ox
            if (self.to_printPO > PO_max) {
                POdir = 0;
            } else if (self.to_printPO < PO_min) {
                POdir = 1;
            }
                
            if (POdir == 0) {
                self.to_printPO = self.to_printPO - 0.5;
            } else {
                self.to_printPO = self.to_printPO + 0.5;
            }
                
            // Simulate Temperature
            if (self.to_printTemp > Temp_max) {
                Tempdir = 0;
            } else if (self.to_printTemp < Temp_min) {
                Tempdir = 1;
            }
            
            if (Tempdir == 0) {
                self.to_printTemp = self.to_printTemp - 0.5;
            } else {
                self.to_printTemp = self.to_printTemp + 0.5;
            }
            print(self.to_printHR);
            print(self.to_printEKG);
            print(self.to_printPO);
            print(self.to_printTemp);
            
            if(self.cont_gen == false) {
                break;
            }
        };
        }
        
    }
    
    func stopGen() {
        cont_gen = false;
    }
    
//    func get_message()->Int {
//        return Int(to_print);
//    }
    
    
}
