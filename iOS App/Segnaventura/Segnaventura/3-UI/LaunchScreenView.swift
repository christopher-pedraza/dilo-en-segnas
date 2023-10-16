//
//  LaunchScreenView.swift
//  coreML-starter
//
//
//

import SwiftUI

struct LaunchScreenView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var THVM: THViewModel
    
    var body: some View {
        ZStack {
            
            Image("Wallpaper")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Título
                Text("Búsqueda del tesoro")
                    .font(.system(size: 52, weight: .bold))
                    .foregroundColor(colorScheme == .dark ? Color("Background") : Color.black)
                
                Divider().frame(maxWidth: 300)
                
                // Info
                VStack(spacing: 20) {
                    Text("Posiciona la cámara de tu dispositivo para buscar el objeto a identificar")
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(colorScheme == .dark ? Color("Background") : Color.black)
                }
                .padding()
                .multilineTextAlignment(.center)
                
                // Item list
                
                    VStack {
                        // Este Text mostrará el nombre del objeto
                        Text(THVM.palabras.first?.palabra ?? "Hola")
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding()
               
                
                // Botón para empezar
                NavigationLink(destination: ClassificationView()){
                    Text("Escanear")
                }
                .buttonStyle(RoundedRectButtonStyle(buttonColor: .blue))
                .padding()
                
            } // Fin de VStack principal
            .padding()
            .frame(maxWidth: 370) // Establece el ancho del fondo blanco
            .background(Color.white) // Establece el color de fondo de la tarjeta
            .cornerRadius(25)
            .shadow(radius: 5)
            .onAppear { // Llamar a getObjetoData en onAppear
                Task {
                    try? await THVM.getObjetoData()
                }
            }
            .navigationBarHidden(true)
            
        } // Fin de ZStack
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
