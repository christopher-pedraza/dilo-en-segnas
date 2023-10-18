//
//  Login.swift
//  Segnaventura
//
//  Created by Alumno on 16/10/23.
//

import SwiftUI

struct Acceso: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        if isLoggedIn {
            IslasView()
        } else {
            Login(isLoggedIn: $isLoggedIn)
            /*
            TabView {
                Login(isLoggedIn: $isLoggedIn)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
             */
        }
    }
}

struct Login: View {
    @EnvironmentObject var AccesoVM : AccesoViewModel
    @Binding var isLoggedIn: Bool
    @State private var isPerformingTask = false
    
    var body: some View {
        ZStack {
            Image("Wallpaper_azul")
                .centerCropped()
            Circle()
                .scale(1.9)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.90))
            VStack {
                Text("Inicio de sesión")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                TextField("Usuario", text: $AccesoVM.user)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                SecureField("Contraseña", text: $AccesoVM.password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                Button(action: {
                    isPerformingTask = true
                    
                    Task {
                        await autenticarUsuario()
                        isLoggedIn = AccesoVM.accesoValido
                        isPerformingTask = false
                    }
                }) {
                    Text("Acceder")
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .disabled(isPerformingTask)
            }
        }
    }
    
    func autenticarUsuario() async {
        do {
            try await AccesoVM.validarAcceso()
        } catch {
        }
    }
}
