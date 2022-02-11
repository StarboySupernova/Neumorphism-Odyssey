//
//  ContentView.swift
//  Neumorphism Odyssey
//
//  Created by Simbarashe Dombodzvuku on 2/11/22.
//

import SwiftUI

extension Color {
    static let offWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
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

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.offWhite
            
            Rectangle()
                .fill(Color.offWhite)
                .frame(width: 300, height: 300)
                .cornerRadius(25, corners: [.topLeft, .bottomRight])
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            
            Button(action: {
                print("Button Tapped")
            }, label: {
                Image(systemName: "heart.fill")
                    .foregroundColor(.gray)
            })
                .buttonStyle(SimpleButtonStyle())
            
        }
        .edgesIgnoringSafeArea(.all)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
