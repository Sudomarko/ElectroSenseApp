 //
//  ContentView.swift
//  Shared
//
//  Created by Marko Vukasinovic on 9/14/22.
//

import SwiftUI

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
    let some_val = CoreBluetoothWrap();
    init() {
        some_val.set_manager();
    }
    var body: some View {
        NavigationView {
            VStack {
                Text(some_val.get_message())
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
