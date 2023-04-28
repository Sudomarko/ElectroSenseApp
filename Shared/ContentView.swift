//
//  ContentView.swift
//  Shared
//
//  Created by Marko Vukasinovic on 9/14/22.
//

import SwiftUI
import HealthKit
import SwiftUICharts
import UIKit
import Foundation

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

public extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}



public extension UIImage {
      convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
      }
}
public extension UILabel {
    func setSizeFont (sizeFont: Double) {
        self.font =  UIFont(name: self.font.fontName, size: sizeFont)!
        self.sizeToFit()
    }
}

struct LoginView: View{
    @State private var action: Int? = 0
    @State private var username = ""
    @State private var password = ""
    
    var body:some View{
        if (action == 0) {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.horizontal, 60.0)
                    
                    TextField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding(.horizontal, 60.0)
                    Text("Login")
                        .foregroundColor(.black)
                        .onTapGesture {
                            //perform some tasks if needed before opening Destination view
                            if (username == "username" && password == "password") {
                                self.action = 1
                            }
                        }
                }
            }
        } else {
            ContentView()
        }
        Spacer()
    }
    
}

struct ContentView: View{
    @StateObject var temp_data = CoreBluetoothWrap();
    @State private var showAlert = false
    
    let heartRateQuantity = HKUnit(from: "count/min")
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        NavigationLink(destination: ElectroSenseView(temp_data:temp_data)) {
                            VStack {
                                Image("warnings").resizable()
                                    .padding(.all, 40.0)
                                    .scaledToFit()
                                Text("Bed Alarm")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
                            }
                            
                        }.isDetailLink(false)
                        NavigationLink(destination: HeartRateView(temp_data:temp_data)) {
                            VStack {
                                Image("1 heart-rate").resizable().padding(.all, 40.0).scaledToFit()
                                Text("Heart Rate")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
                            }
                            
                        }.isDetailLink(false)
                        
                    }
                    HStack {
                        NavigationLink(destination: PulseOxView(temp_data:temp_data)) {
                            VStack {
                                Image("1 pulse-ox").resizable().padding(.all, 40.0).scaledToFit()
                                Text("Pulse Ox")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
                            }
                        }.isDetailLink(false)
                        
                        NavigationLink(destination: BodyPressureView()) {
                            VStack {
                                Image("body-pressure-2").resizable().padding(.all, 5.0).scaledToFit()
                                Text("Pressure")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.center)
                                    .padding(.all, 10.0)
                            }
                        }.isDetailLink(false)
                        
                    }
                    HStack {
                        NavigationLink(destination: TemperatureView(temp_data:temp_data)) {
                            VStack {
                                Image("1 temp").resizable().padding(.all, 40.0).scaledToFit()
                                Text("Temperature")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
                            }
                            
                        }.isDetailLink(false)
                        NavigationLink(destination: BodyTemp(temp_data:temp_data)) {
                            VStack {
                                Image("body-temp-2").resizable()
                                    .padding(.all, 40.0)
                                    .scaledToFit()
                                Text("Body Temp")
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
                            }
                            
                        }.isDetailLink(false)
                        
                    }
                    Spacer()
                }
                    
            }
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle()).statusBar(hidden:true).onAppear(perform:start)
        
    }
    
    func start() {
        temp_data.set_manager();
        while(temp_data.ready == false) {
        }
        temp_data.writeOutgoingValue(data: "m");
        
    }
    
}

struct BodyTemp: View {
    //@StateObject var some_val = CBSimulation(sim_type:"T");
    
    @StateObject var temp_data: CoreBluetoothWrap;
    @State private var showAlert = false;
    @State private var graphTemp = [0.0];
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    MultiLineChartView(data: [(graphTemp, GradientColors.orngPink)], title: "Body Temperature", form: ChartForm.large, rateValue:Int(temp_data.to_print), valueSpecifier:"")
                }
            }.frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle()).onAppear(perform:  start).onDisappear(perform: stopLoop).onChange(of: temp_data.to_print) {
            newTemp in
            self.graphTemp.append(newTemp);
        }
        
    }
    
    func start() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            //some_val.genVals();
            temp_data.set_manager();
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                temp_data.writeOutgoingValue(data:"b");
            }
        }
    }
    
    func stopLoop() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
           // some_val.stopGen();
        }
    }
}

struct HeartRateView: View{
    @StateObject var temp_data: CoreBluetoothWrap;
    @State private var showAlert = false
    @State private var value = "0";
    @State private var stop_loop = 0;
    //@StateObject var some_val = CBSimulation(sim_type:"HR");
    @State private var prev_HR = 0.0;
    @State private var graphHeart = [0.0]
    @State private var graphEKG = [0.0]
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    MultiLineChartView(data: [(graphHeart, GradientColors.orngPink)], title: "Heart Rate", form: ChartForm.large, rateValue:Int(temp_data.to_print), valueSpecifier:"")
                    MultiLineChartView(data: [(graphEKG, GradientColors.green)], title: "EKG", form: ChartForm.large, rateValue:Int(temp_data.to_printEKG), valueSpecifier:"")
                }
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle()).onAppear(perform:  start).onDisappear(perform: stopLoop).onChange(of: temp_data.to_print) {
                newHR in
                    self.graphHeart.append(newHR);
            
        }.onChange(of: temp_data.to_printEKG) {
            newEKG in
                self.graphEKG.append(newEKG);
        }
    }
    
    func start() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
          //some_val.genVals();
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                temp_data.writeOutgoingValue(data: "h");
            }
        }
    }
    func stopLoop() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
           // some_val.stopGen();
        }
    }

}

struct PulseOxView: View {
    @StateObject var temp_data: CoreBluetoothWrap;
    @State private var showAlert = false
    //@StateObject var some_val = CBSimulation(sim_type:"PO");
    @State private var graphPO = [0.0]
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    MultiLineChartView(data: [(graphPO, GradientColors.orngPink)], title: "Pulse Ox", form: ChartForm.large, rateValue:Int(temp_data.to_print), valueSpecifier:"")
                }
            }.frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
              )
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle()).onAppear(perform:  start).onDisappear(perform: stopLoop).onChange(of: temp_data.to_print) {
            newPO in
                self.graphPO.append(newPO);
        }
    }
    
    func start() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            //some_val.genVals();
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                temp_data.writeOutgoingValue(data: "o")
            }
        }
    }
    
    func stopLoop() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            //some_val.stopGen();
        }
    }
}

struct BodyPressureView: View {
    @StateObject private var generator = CBSimulation(sim_type:"else");
    @State private var showAlert = false
    @State public var presArr = [[Double]](repeating: [Double](repeating: 0.0, count: 16), count: 16);
    @State public var presArr2 = [[Double]](repeating: [Double](repeating: 0.0, count: 16), count: 16);
    @State public var presColor = 0;
    
    private var redImage = UIImage(color: UIColor(Color(red: 1, green: 0, blue: 0)), size: CGSize(width: 6, height: 6));
    private var blueImage = UIImage(color: UIColor(Color(red: 0, green: 0, blue: 1)), size: CGSize(width: 6, height: 6));
    private var greenImage = UIImage(color: UIColor(Color(red: 0, green: 1, blue: 0)), size: CGSize(width: 6, height: 6));
    private var yellowImage = UIImage(color: UIColor(Color(red: 1, green: 1, blue: 0)), size: CGSize(width: 6, height: 6));
    private var orangeImage = UIImage(color: UIColor(Color(red: 1, green: 0.64, blue: 0)), size: CGSize(width: 6, height: 6));
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    ForEach(presArr,  id: \.self) { array in
                        HStack(spacing: 0) {
                            ForEach(array,  id: \.self) { element in
                                HStack(spacing: 0) {
                                    if (element >= 0.0 && element < 10.0) {
                                        Image(uiImage:blueImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    }  else if (element >= 10.0 && element < 30.0) {
                                        Image(uiImage:greenImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    } else if (element >= 30.0 && element < 50.0) {
                                        Image(uiImage:yellowImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    } else if (element >= 50.0 && element < 70.0) {
                                        Image(uiImage:orangeImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    } else if (element >= 70.0) {
                                        Image(uiImage:redImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    } else {
                                        Image(uiImage:blueImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    }
                                }
                            }
                        }
                    }
                    ForEach(presArr2,  id: \.self) { array in
                        HStack(spacing: 0) {
                            ForEach(array,  id: \.self) { element in
                                HStack(spacing: 0) {
                                    if (element >= 0.0 && element < 10.0) {
                                        Image(uiImage:blueImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    }  else if (element >= 10.0 && element < 30.0) {
                                        Image(uiImage:greenImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    } else if (element >= 30.0 && element < 50.0) {
                                        Image(uiImage:yellowImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    } else if (element >= 50.0 && element < 70.0) {
                                        Image(uiImage:orangeImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    } else if (element >= 70.0) {
                                        Image(uiImage:redImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    } else {
                                        Image(uiImage:blueImage!).border(Color(red: 220, green: 220, blue: 220), width:0.3)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Body Pressure").font(.largeTitle).foregroundColor(.black)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle())
        
        .onAppear(perform:  start).onDisappear(perform: stopLoop).onChange(of: generator.to_printBP1) {
            newBP in
                print(newBP)
                self.presArr = newBP;
        }.onChange(of: generator.to_printBP2) {
            newBP in
                print(newBP)
                self.presArr2 = newBP;
        }
    }
    
    func start() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            generator.genVals();
        }
    }

    func stopLoop() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            generator.stopGen();
        }
    }
}

struct TemperatureView: View {
    //@StateObject var some_val = CBSimulation(sim_type:"T");
    @StateObject var temp_data: CoreBluetoothWrap;
    @State private var showAlert = false;
    @State private var graphTemp = [0.0];
    @State private var hp1 = true
    @State private var hp2 = true
    
   
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack {
                    MultiLineChartView(data: [(graphTemp, GradientColors.orngPink)], title: "Temperature", form: ChartForm.large, rateValue:Int(temp_data.to_print), valueSpecifier:"")
                    Toggle("Top Heating Pad", isOn: $hp1).foregroundColor(.black).onChange(of: hp1) { value in
                        if value {
                            temp_data.writeOutgoingValue(data:"q")
                            //print(value)
                        } else {
                            temp_data.writeOutgoingValue(data:"g")
                            //print(value)
                        }
                    }
                    Toggle("Bottom Heating Pad", isOn: $hp2).foregroundColor(.black).onChange(of: hp2) { value in
                        if value {
                            temp_data.writeOutgoingValue(data:"k")
                            //print(value)
                        } else {
                            temp_data.writeOutgoingValue(data:"l")
                            //print(value)
                        }
                    }
                }
            }
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle()).onAppear(perform:  start).onDisappear(perform: stopLoop).onChange(of: temp_data.to_print) {
            newTemp in
                self.graphTemp.append(newTemp);
        }
        
    }
    
    func start() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                temp_data.writeOutgoingValue(data:"t");
            }
            //some_val.genVals();
        }
    }
    
    func stopLoop() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            //some_val.stopGen();
        }
    }
}

struct ElectroSenseView: View {
    @StateObject var temp_data: CoreBluetoothWrap;
    @State private var alert1 = true
    @State private var alert2 = true
    @State private var alert3 = true
    
        var body: some View {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Toggle("Alarm Power", isOn: $alert1).foregroundColor(.black)
                    if alert1 {
                        Toggle("Patient Bed Sit Up", isOn: $alert2).foregroundColor(.black) .onChange(of: alert2) { value in
                                if value {
                                    temp_data.writeOutgoingValue(data:"6")
                                    //print(value)
                                } else {
                                    temp_data.writeOutgoingValue(data:"7")
                                    //print(value)
                                }
                            }
                        Toggle("Patient Bed Exit", isOn: $alert3).foregroundColor(.black)
                            .onChange(of: alert3) { value in
                                    if value {
                                        temp_data.writeOutgoingValue(data:"8")
                                        //print(value)
                                    } else {
                                        temp_data.writeOutgoingValue(data:"9")
                                        //print(value)
                                    }
                                }
                    }
                    Spacer()
                }
            }
            .onAppear(perform: start)
            .frame(
                  minWidth: 0,
                  maxWidth: .infinity,
                  minHeight: 0,
                  maxHeight: .infinity,
                  alignment: .topLeading
                )
        }
    
    func start() {
        Task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                temp_data.writeOutgoingValue(data:"a")
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
