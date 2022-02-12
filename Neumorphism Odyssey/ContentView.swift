//
//  ContentView.swift
//  Neumorphism Odyssey
//
//  Created by Simbarashe Dombodzvuku on 2/11/22.
//

import SwiftUI

extension Color {
    static let offWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
    static let darkStart = Color(red: 50/255, green: 60/255, blue: 65/255)
    static let darkEnd = Color(red: 25/255, green: 25/255, blue: 30/255)
    static let lightStart = Color(red: 60/255, green: 160/255, blue: 240/255)
    static let lightEnd = Color(red: 30/255, green: 80/255, blue: 120/255)
}

extension LinearGradient {
    init(_ colors: Color...){
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
        /*
         If you add a tap gesture to a primitive SwiftUI view such as Text or Image, the whole view becomes tappable. If you add a tap gesture to a container SwiftUI view, such as VStack or HStack, then SwiftUI only adds the gesture to the parts of the container that have something inside – large parts of the stack are likely to be untappable.
         
         If this is what you want then the default behavior is fine. However, if you want to change the shape of hit tests – the area that responds to taps – then you should use the contentShape() modifier with the shape you want.
         */
            .background(
                Group{
                    if configuration.isPressed {
                        Circle()
                            .fill(Color.offWhite)
                        //.shadow(color: Color.orange, radius: 30, x: 15, y: 15) experiment
                            .overlay(
                                Circle()
                                    .stroke(Color.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                            )
                    } else {
                        Circle()
                            .fill(Color.offWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                }
                
            )
    }
}

struct DarkBackground<S: Shape>: View {
    var isHighlighted: Bool //is it depressed or not
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4)) //bevel appears when button is pressed
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(Color.darkEnd, lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct ColorfulBackground<S: Shape>: View {
    var isHighlighted: Bool //is it depressed or not
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.darkEnd, Color.darkStart))
                    .overlay(shape.stroke(LinearGradient(Color.darkStart, Color.darkEnd), lineWidth: 4)) //bevel appears when button is pressed
                    .shadow(color: Color.darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: Color.darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart, Color.darkEnd))
                    .overlay(shape.stroke(Color.darkEnd, lineWidth: 4))
                    .shadow(color: Color.darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: Color.darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct DarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                DarkBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
    }
}

struct DarkToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        })
            .background(
                DarkBackground(isHighlighted: configuration.isOn, shape: Circle())
            )
    }
}

struct ColorfulButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                ColorfulBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
    }
}

struct ColorfulToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        })
            .background(
                ColorfulBackground(isHighlighted: configuration.isOn, shape: Circle())
            )
    }
}

struct ContentView: View {
    @State private var isToggled = false
    var body: some View {
        ZStack {
            LinearGradient(Color.darkStart, Color.darkEnd)
            
            /*
             Rectangle()
             .fill(Color.offWhite)
             .frame(width: 300, height: 300)
             .cornerRadius(25, corners: [.topLeft, .bottomRight])
             .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
             .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
             */
            
            VStack(spacing: 40){
                Button(action: {
                    print("Button Tapped")
                }, label: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                })
                    .buttonStyle(DarkButtonStyle())
                    .animation(nil)
                
                Toggle(isOn: $isToggled){
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                }
                .toggleStyle(DarkToggleStyle())
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
