//
//  Temp.swift
//  Segnaventura
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI
import RealityKit
import Combine

struct Temp: View {
    
    @EnvironmentObject var ARVM: ARExperience
    
    var body: some View {
        
        ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)
            
            switch true {
            case ARVM.isTH_Active:
                AnyView(LaunchScreenView())
            case ARVM.isQuiz_Active:
                AnyView(PreguntasPalabrasActivity())
            case ARVM.isVideo_Active:
                AnyView(VideosActivity())
            default:
                AnyView(ARViewContainer().edgesIgnoringSafeArea(.all))
            }
            
            /*
             NavigationView {
             NavigationLink(
             destination: LaunchScreenView(),
             isActive: $ARVM.isTH_Active
             ) {
             EmptyView()
             }
             .hidden()
             
             NavigationLink(
             destination: PreguntasPalabrasActivity(),
             isActive: $ARVM.isQuiz_Active
             ) {
             EmptyView()
             }
             .hidden()
             
             NavigationLink(
             destination: VideosActivity(),
             isActive: $ARVM.isVideo_Active
             ) {
             EmptyView()
             }
             .hidden()
             }
             */
        }
    }
}

// Esta estructura es un adaptador que permite integrar la vista de AR en SwiftUI
struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var ARVM: ARExperience
    //var arExperience: ARExperience
    
    func makeUIView(context: Context) -> ARView {
        return ARVM.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
