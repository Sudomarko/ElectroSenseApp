//
//  ContentView.swift
//  Shared
//
//  Created by Marko Vukasinovic on 9/14/22.
//

import SwiftUI
import HealthKit
import SwiftUICharts

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


struct ContentView: View{
    @State private var showAlert = false
    let heartRateQuantity = HKUnit(from: "count/min")
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
                            Image("1 heart-rate").resizable().padding(.all, 40.0).scaledToFit()
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
            
        }.navigationViewStyle(StackNavigationViewStyle());
        
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

struct HeartRateView: View{
    @State private var showAlert = false
    @State private var value = "0";
    @State private var stop_loop = 0;
    @StateObject var some_val = CBSimulation();
    @State private var prev_HR = 0.0;
    @State private var graphHeart = [0.0]
    @State private var graphEKG = [0.0]
    
    
    var body: some View {
        NavigationView {
            VStack {
                MultiLineChartView(data: [(graphHeart, GradientColors.orngPink)], title: "Heart Rate", form: ChartForm.large, rateValue:Int(some_val.to_printHR), valueSpecifier:"")
                MultiLineChartView(data: [(graphEKG, GradientColors.green)], title: "EKG", form: ChartForm.large, rateValue:Int(some_val.to_printEKG), valueSpecifier:"")
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text(String("Heart Rate")).font(.largeTitle)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle()).onAppear(perform:  start).onDisappear(perform: stopLoop).onChange(of: some_val.to_printHR) {
                newHR in
                    self.graphHeart.append(newHR);
            
        }.onChange(of: some_val.to_printEKG) {
            newEKG in
                self.graphEKG.append(newEKG);
        }
    }
    func start() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            some_val.genVals();
        }
    }
    func stopLoop() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            some_val.stopGen();
        }
    }

}

struct PulseOxView: View {
    @State private var showAlert = false
    @StateObject var some_val = CBSimulation();
    @State private var graphPO = [0.0]
    var body: some View {
        NavigationView {
            VStack {
                LineView(data: graphPO, legend: "Pulse OX" , style: Styles.lineChartStyleOne)
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text(String(Int(some_val.to_printPO))).font(.largeTitle)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle()).onAppear(perform:  start).onDisappear(perform: stopLoop).onChange(of: some_val.to_printPO) {
            newPO in
                self.graphPO.append(newPO);
        };
        
    }
    
    func start() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            some_val.genVals();
        }
    }
    
    func stopLoop() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            some_val.stopGen();
        }
    }
}

struct BodyPressureView: View {
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
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text("Body Pressure").font(.largeTitle)
                            Text("Subtitle").font(.subheadline)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle()).onAppear(perform:  start)
    }
    
    func start() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            print(presArr)
        }
    }
}

struct TemperatureView: View {
    @StateObject var some_val = CBSimulation();
    @State private var showAlert = false
    @State private var graphTemp = [0.0]
    
    var body: some View {
        NavigationView {
            VStack {
                LineView(data: graphTemp, legend: "Temperature" , style: Styles.lineChartStyleOne)
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        VStack {
                            Text(String(Double(some_val.to_printTemp))).font(.largeTitle)
                        }
                    }
                }
        }.navigationViewStyle(StackNavigationViewStyle()).onAppear(perform:  start).onDisappear(perform: stopLoop).onChange(of: some_val.to_printTemp) {
            newTemp in
                self.graphTemp.append(newTemp);
        };
        
    }
    
    func start() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            some_val.genVals();
        }
    }
    
    func stopLoop() {
        // Do any additional setup after loading the view, typically from a nib.
        Task {
            some_val.stopGen();
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
