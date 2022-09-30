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
                        Text("Circulation")
                            .font(.title)
                            .padding()
                    }
                    
                    NavigationLink(destination: HeartRateView()) {
                        Text("Heart Rate")
                            .font(.title)
                            .padding()
                    }
                    
                }.offset(x:0, y:-75)
                HStack {
                    NavigationLink(destination: PulseOxView()) {
                        Text("Pulse Ox")
                            .font(.title)
                            .padding()
                    }
                    
                    NavigationLink(destination: BodyPressureView()) {
                        Text("Body Pressure")
                            .font(.title)
                            .padding()
                    }
                    
                }.offset(x:0, y:-25)
                HStack {
                    NavigationLink(destination: TemperatureView()) {
                        Text("Temperature")
                            .font(.title)
                            .padding()
                    }
                    
                    NavigationLink(destination: ElectroSenseView()) {
                        Text("ElectroSense")
                            .font(.title)
                            .padding()
                    }
                    
                }.offset(x:0, y:25)
            }.navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("ElectroSenseApp").font(.largeTitle)
                        }
                    }
                }
                .foregroundColor(Color.blue)
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
                            Text("ElectroSense").font(.largeTitle)
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
            ContentView()
        }
    }
}
//hi Alexis 
//hi Kayla
