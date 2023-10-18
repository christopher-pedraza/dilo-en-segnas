//
//  Login.swift
//  Segnaventura
//
//  Created by Alumno on 16/10/23.
//

import SwiftUI
import ActionButton

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

enum FocusableField: View {
    case user, password
}

struct Login: View {
    @EnvironmentObject var AccesoVM : AccesoViewModel
    @Binding var isLoggedIn: Bool
    @State private var isPerformingTask = false
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        ZStack {
            Image("Wallpaper_azul")
                .centerCropped()
            Circle()
                .scale(0.9)
                .foregroundColor(.white.opacity(0.15))
            Circle()
                .scale(0.7)
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
                    .submitLabel(.next)
                    .focused($focus, equals: .user)
                    .onSubmit {
                        focus = .password
                    }
                SecureField("Contraseña", text: $AccesoVM.password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                ActionButton(state: $AccesoVM.buttonState, onTap: {
                    
                }, backgroundColor: .primary)
//                Button(action: {
//                    isPerformingTask = true
//
//                    Task {
//                        await autenticarUsuario()
//                        isLoggedIn = AccesoVM.accesoValido
//                        isPerformingTask = false
//                    }
//                }) {
//                    Text("Acceder")
//                        .foregroundColor(.white)
//                        .frame(width: 300, height: 50)
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .disabled(isPerformingTask)
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
