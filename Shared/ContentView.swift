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
                                Image("circulation").resizable().padding(.all, 40.0).scaledToFit()
                                Text("Circulation")
                            }
                        
                    }
                    
                    NavigationLink(destination: HeartRateView()) {
                        VStack {
                            Image("heart-rate").resizable()
                                .padding(.all, 40.0)
                                .scaledToFit()
                            Text("Heart Rate")
                        }
                        
                    }
                    
                }
                HStack {
                    NavigationLink(destination: PulseOxView()) {
                        Image("pulse-ox").resizable().padding(.all, 40.0).scaledToFit()
                            
                    }
                    
                    NavigationLink(destination: BodyPressureView()) {
                        Image("body-pressure").resizable().padding(.all, 40.0).scaledToFit()
                            
                    }
                    
                }
                HStack {
                    NavigationLink(destination: TemperatureView()) {
                        Image("thermometer").resizable().padding(.all, 40.0).scaledToFit()
                            
                    }
                    
                    NavigationLink(destination: ElectroSenseView()) {
                        Image("warnings").resizable()
                            .padding(.all, 40.0)
                            .scaledToFit()
                            
                    }
                    
                }
            }
            .padding(.bottom)
            
            
        }
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
        }
        
    }
}

struct HeartRateView: View {
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
                            Text("Heart Rate").font(.largeTitle)
                            Text("Subtitle").font(.subheadline)
                        }
                    }
                }
        }
        
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
        }
        
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
        }
        
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
        }
        
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
        }
        
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
