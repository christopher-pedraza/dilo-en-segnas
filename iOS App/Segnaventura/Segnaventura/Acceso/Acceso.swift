//
//  Login.swift
//  Segnaventura
//
//  Created by Alumno on 16/10/23.
//

import SwiftUI

struct Acceso: View {
    var body: some View {
        NavigationStack {
            TabView {
                Login()
                Register()
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
}

struct Login: View {
    @EnvironmentObject var AccesoVM : AccesoViewModel
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
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
                    TextField("Usuario", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    NavigationLink(destination: chooseDestination()) {
                        Text("Acceder")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .toolbar(.hidden)
    }
    
    @ViewBuilder
    func chooseDestination() -> some View {
        let valor : Bool = AccesoVM.accesoValido
        switch valor {
        case true: IslasView()
        case false: Login()
        }
    }
    
    func autenticarUsuario(username: String, password: String) async {
        await AccesoVM.validarAcceso()
    }
}

struct Register: View {
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Wallpaper_azul_claro")
                    .centerCropped()
                Circle()
                    .scale(0.9)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(0.7)
                    .foregroundColor(.white.opacity(0.90))
                VStack {
                    Text("Registro")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Usuario", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    NavigationLink(destination: chooseDestination()) {
                        Text("Registrar")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .toolbar(.hidden)
    }
    
    @ViewBuilder
    func chooseDestination() -> some View {
        let valor : Bool = (username == "test" && password == "test")
        switch valor {
        case true: IslasView()
        case false: Login()
        }
    }
    
    func autenticarUsuario(username: String, password: String) {
        
    }
}
