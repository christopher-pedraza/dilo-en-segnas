//
//  Login.swift
//  Segnaventura
//
//  Created by Alumno on 16/10/23.
//

import SwiftUI
import ActionButton
import TogglableSecureField

struct Acceso: View {
    @EnvironmentObject var AccesoVM : AccesoViewModel
    
    var body: some View {
        if AccesoVM.accesoValido {
            IslasView()
        } else {
            Login()
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

enum FocusableField: Hashable {
    case user, password
}

struct Login: View {
    @EnvironmentObject var AccesoVM : AccesoViewModel
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
                TogglableSecureField("Password",
                                     secureContent: $AccesoVM.password,
                                     onCommit: {
                    guard !AccesoVM.password.isEmpty else { return }
                })
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .focused($focus, equals: .password)
                .submitLabel(.go)
                .onSubmit {
                    Task {
                        await autenticarUsuario()
                    }
                }
                ActionButton(state: $AccesoVM.buttonState, onTap: {
                    Task {
                        await autenticarUsuario()
                    }
                }, backgroundColor: .blue)
                .frame(width: 300, height: 50)
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
