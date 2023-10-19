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
    
    var body: some View {
        VStack {
            Text("Usuario")
                .font(.largeTitle)
                .bold()
                .padding()
                .foregroundColor(colorScheme == .dark ? Color("Background") : Color.black)
            Button("Cerrar Sesión") {
                AccesoVM.logout()
            }
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.black.opacity(0.05))
            .foregroundColor(colorScheme == .dark ? Color("Background") : Color.black)
            .cornerRadius(10)
        }
    }
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView()
    }
}
