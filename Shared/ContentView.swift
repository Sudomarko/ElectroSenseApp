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
                            .foregroundColor(Color.blue)
                            .padding()
                    }
                    
                    NavigationLink(destination: HeartRateView()) {
                        Text("Heart Rate")
                            .font(.title)
                            .foregroundColor(Color.blue)
                            .padding()
                    }
                    
                }.offset(x:0, y:-100)
                HStack {
                    NavigationLink(destination: PulseOxView()) {
                        Text("Pulse Ox")
                            .font(.title)
                            .foregroundColor(Color.blue)
                            .padding()
                    }
                    
                    NavigationLink(destination: BodyPressureView()) {
                        Text("Body Pressure")
                            .font(.title)
                            .foregroundColor(Color.blue)
                            .padding()
                    }
                    
                }.offset(x:0, y:-50)
                HStack {
                    NavigationLink(destination: TemperatureView()) {
                        Text("Temperature")
                            .font(.title)
                            .foregroundColor(Color.blue)
                            .padding()
                    }
                    
                    NavigationLink(destination: ElectroSenseView()) {
                        Text("ElectroSense")
                            .font(.title)
                            .foregroundColor(Color.blue)
                            .padding()
                    }
                    
                }
            }
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
        ContentView()
    }
}
//hi Alexis 
//hi Kayla
