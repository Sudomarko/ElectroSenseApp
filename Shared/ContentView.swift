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
        VStack {
            HStack {
                Button {
                    showAlert = true
                } label: {
                    Text("Circulation")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        .padding()
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Circulation")
                        
                    )
                }
                
                Button {
                    showAlert = true
                } label: {
                    Text("Heart Rate")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        .padding()
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Heart Rate")
                        
                    )
                }
            }
            
            HStack {
                Button {
                    showAlert = true
                } label: {
                    Text("Puls Ox")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        .padding()
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Puls Ox")
                        
                    )
                }
                
                Button {
                    showAlert = true
                } label: {
                    Text("Body Pressure")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        .padding()
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Body Pressure")
                        
                    )
                }
            }
            
            HStack {
                Button {
                    showAlert = true
                } label: {
                    Text("Temperature")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        .padding()
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Temperature")
                        
                    )
                }
                
                Button {
                    showAlert = true
                } label: {
                    Text("ElectroSense")
                        .font(.title)
                        .foregroundColor(Color.blue)
                        .padding()
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("ElectroSense")
                        
                    )
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
