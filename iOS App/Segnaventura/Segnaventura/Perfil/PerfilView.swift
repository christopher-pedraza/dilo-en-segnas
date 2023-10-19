//
//  PerfilView.swift
//  Segnaventura
//
//  Created by Alumno on 18/10/23.
//

import SwiftUI

struct PerfilView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var AccesoVM : AccesoViewModel
    @EnvironmentObject var MI: menuIndex
    
    var body: some View {
        VStack {
            Text("Usuario")
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundColor(colorScheme == .dark ? .white : .black)
            Button("Cerrar Sesión") {
                AccesoVM.logout()
            }
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.black.opacity(0.05))
            .foregroundColor(colorScheme == .dark ? .white : Color.black)
            .cornerRadius(10)
            Spacer()
            
            Button("Regresar") {
                MI.index = 1
            }
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.black.opacity(0.05))
            .foregroundColor(colorScheme == .dark ? .white : Color.black)
            .cornerRadius(10)
        }
    }
}
