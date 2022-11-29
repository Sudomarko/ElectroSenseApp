 //
//  ContentView.swift
//  Shared
//
//  Created by Marko Vukasinovic on 9/14/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: CirculationView()) {
                            VStack {
                                Image("1 circulation").resizable().padding(.all, 50.0).scaledToFit()
                                Text("Circulation")
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.pink)
                            }
                        
                    }.isDetailLink(false)
                    NavigationLink(destination: HeartRateView()) {
                        VStack {
                            Image("1 heart-rate").resizable()
                                .padding(.all, 40.0)
                                .scaledToFit()
                            Text("Heart Rate")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.orange)
                        }
                        
                    }.isDetailLink(false)
                    
                }
                HStack {
                    NavigationLink(destination: PulseOxView()) {
                        VStack {
                            Image("1 pulse-ox").resizable().padding(.all, 40.0).scaledToFit()
                            Text("Pulse Ox")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(Color(hue: 0.697, saturation: 0.647, brightness: 0.723))
                        }
                    }.isDetailLink(false)
                    
                    NavigationLink(destination: BodyPressureView()) {
                        VStack {
                            Image("body-pressure").resizable().padding(.all, 40.0).scaledToFit()
                            Text("Pressure")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.green)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }.isDetailLink(false)
                    
                }
                HStack {
                    NavigationLink(destination: TemperatureView()) {
                        VStack {
                            Image("1 temp").resizable().padding(.all, 40.0).scaledToFit()
                            Text("Temperature")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.blue)
                        }
                            
                    }.isDetailLink(false)
                    
                    NavigationLink(destination: ElectroSenseView()) {
                        VStack {
                            Image("warnings").resizable()
                                .padding(.all, 40.0)
                                .scaledToFit()
                            Text("Warning")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.red)
                        }
                            
                    }.isDetailLink(false)
                    
                }
            }.padding(.bottom, 50)
            
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}
struct CirculationView: View {
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Data Placeholder")
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Circulation").font(.largeTitle)
                            Text("Subtitle").font(.subheadline)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct HeartRateView: View {
    @State private var showAlert = false
    @State private var value = 0;
    var some_val = CoreBluetoothWrap();
    var some_heart_rate = StoreHealthData();
    
    init() {
        some_val.set_manager();
        
    }
    var body: some View {
        NavigationView {
            VStack {
                Text()
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Heart Rate").font(.largeTitle)
                            Text("Subtitle").font(.subheadline)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
            // variable initialization
            var lastHeartRate = 0.0
            
            // cycle and value assignment
            for sample in samples {
                if type == .heartRate {
                    lastHeartRate = sample.quantity.doubleValue(for: some_heart_rate.heartRateQuantity)
                }
                
                self.value = Int(lastHeartRate)
            }
        }
    
    func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
            
            // We want data points from our current device
            let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
            
            // A query that returns changes to the HealthKit store, including a snapshot of new changes and continuous monitoring as a long-running query.
            let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
                query, samples, deletedObjects, queryAnchor, error in
                
             // A sample that represents a quantity, including the value and the units.
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
                
            self.process(samples, type: quantityTypeIdentifier)

            }
            
            // It provides us with both the ability to receive a snapshot of data, and then on subsequent calls, a snapshot of what has changed.
            let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
            
            query.updateHandler = updateHandler
            
            // query execution
            
            some_val.heart_rate.execute(query)
        }
    
}

struct PulseOxView: View {
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Data Placeholder")
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Pulse Ox").font(.largeTitle)
                            Text("Subtitle").font(.subheadline)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct BodyPressureView: View {
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Data Placeholder")
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Body Pressure").font(.largeTitle)
                            Text("Subtitle").font(.subheadline)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct TemperatureView: View {
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Data Placeholder")
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Temperature").font(.largeTitle)
                            Text("Subtitle").font(.subheadline)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ElectroSenseView: View {
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Data Placeholder")
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Warnings").font(.largeTitle)
                            Text("Subtitle").font(.subheadline)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
//hi Alexis 
//hi Kayla
