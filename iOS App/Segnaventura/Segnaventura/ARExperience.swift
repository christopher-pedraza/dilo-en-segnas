//
//  ARExperience.swift
//  Seniaventuras
//
//  Created by Alumno on 16/10/23.
//

import SwiftUI
import RealityKit
import Combine

func fetch_api_data() -> [String: (Int, Bool, Any, Any)] {
    var tempData: [String: (Int, Bool, Any, Any)] = [:]
    
    // (id_isla, discovered, userAdvance, islandLevels)
    tempData["fruitIsland"] = (1, true, true, true)
    tempData["natureIsland"] = (2, false, false, true)
    
    /*
     // ESTA LINEA AGREGA UN NUEVO VALOR A LA LLAVE
    if var existingValue = tempData["fruitIsland"] as? [String] {
        existingValue.append("bruh")
        tempData["fruitIsland"] = existingValue
    }
    */
    return tempData
}

class ARExperience: ObservableObject {
    // atributos de la clase
    var arView: ARView
    //var generalSceneAnchor: AllIslands.GenIslands
    //var generalSceneAnchor: AnchorEntity
    //var generalSceneAnchor: AllIslands.GeneralIslands
    var generalSceneAnchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
    var specificSceneAnchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
    
    @EnvironmentObject var MI: menuIndex

    //var specificSceneAnchor: AllIslands.Nothing
    //var specificSceneAnchor: AllIslands.SpecFruitIsland
    //var specificSceneAnchor: AnchorEntity = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.001, 0.001)))
    
    var fruitIsland: Entity = Entity()
    var natureIsland: Entity = Entity()
    var unknownIsland: Entity = Entity()
    var lvlContainer: Entity = Entity()
    
    var specificIslandLevels: [Entity] = []
    
    var fullData: [String: (Int, Bool, Any, Any)] = fetch_api_data()
    //var fullData: [Bool] = [true, false]
    
    @Published var isTH_Active: Bool = false // Agrega un enlace a un estado de SwiftUI
    @Published var isQuiz_Active: Bool = false // Agrega un enlace a un estado de SwiftUI
    @Published var isVideo_Active: Bool = false // Agrega un enlace a un estado de SwiftUI
    
    @Published var isPanelVisible: Bool = false // Agrega un enlace a un estado de SwiftUI
    
    var levelsArray: [Entity] = [] // Entidades de los niveles de la isla especifica
    var lastPanelSeen: Entity = Entity()

    init() {
        arView = ARView(frame: .zero)
        //self.generalSceneAnchor = try! AllIslands.loadGeneralIslands()
        //self.specificSceneAnchor = try! AllIslands.loadNothing()
        //self.specificSceneAnchor = try! AllIslands.loadSpecFruitIsland()
        //arView.scene.anchors.append(generalSceneAnchor)
        
        //var modelName: String
        //var dummyScene: AllIslands.FruitIsland = try! AllIslands.loadFruitIsland()
        //var dummyIsland: Entity = generalSceneAnchor.fruitIsland!
        // spinIsland_1
        //let notifications =  dummyScene.notifications
        //let notifications =  generalSceneAnchor.notifications
        
         
        /*
        var tempScene: AllIslands.FruitIsland = try! AllIslands.loadFruitIsland()
        if AR_Data[0] {
            self.fruitIsland = tempScene.fruitIsland!
            self.fruitIsland.position = simd_make_float3(0, 0, 0)
            generalSceneAnchor .addChild(self.fruitIsland)
            print("====================================================")
            print("====================================================")
            print("====================================================")
            print("cargando desde la escena")
            print("====================================================")
            print("====================================================")
            print("====================================================")
        } else {
            self.fruitIsland = try! Entity.load(named: "unknown_island")
            self.fruitIsland.name = "natureIsland"
            self.fruitIsland.setScale(SIMD3<Float>(0.025, 0.025, 0.025), relativeTo: generalSceneAnchor)
            self.fruitIsland.position = simd_make_float3(0, 0, 0)
            generalSceneAnchor.addChild(self.fruitIsland)
        }
         */
        
        /*
        modelName = fullData[0] ? "fruit_island" : "unknown_island"
        self.fruitIsland = try! Entity.load(named: modelName)
        self.fruitIsland.name = "fruiIsland"
        self.fruitIsland.setScale(SIMD3<Float>(0.025, 0.025, 0.025), relativeTo: generalSceneAnchor)
        generalSceneAnchor.addChild(self.fruitIsland)
         
         modelName = fullData[1] ? "plane" : "unknown_island"
         self.unknownIsland = try! Entity.load(named: modelName)
         self.unknownIsland.name = "natureIsland"
         self.unknownIsland.setScale(SIMD3<Float>(0.025, 0.025, 0.025), relativeTo: generalSceneAnchor)
         self.unknownIsland.position = simd_make_float3(1, 0, -1)
         generalSceneAnchor.addChild(self.unknownIsland)
         */
        
        
        /*
        generalSceneAnchor.notifications.onStartSpinFruitIsland.post()
        self.fruitIsland = generalSceneAnchor.fruitIsland!.clone(recursive: true)
        self.fruitIsland.setScale(SIMD3<Float>(0.025, 0.025, 0.025), relativeTo: generalSceneAnchor)
        //self.fruitIsland.name = "fruitIsland"
        generalSceneAnchor.children.append(self.fruitIsland)
        notifications.onStartSpinFruitIsland.post(overrides: [generalSceneAnchor.fruitIsland!.name : self.fruitIsland])
         */
        
        
        /*
        if var tempIsland = generalSceneAnchor.findEntity(named: "fruitIsland") {
            //tempIsland = try! Entity.load(named: "plane")
            //generalSceneAnchor.addChild(tempIsland)
            generalSceneAnchor.removeChild(tempIsland)
        }
         */
        
        
        //generalSceneAnchor.removeChild(generalSceneAnchor.fruitIsland!, preservingWorldTransform: true)
        //generalSceneAnchor.addChild(self.fruitIsland)
        //generalSceneAnchor.notifications.onStartSpinFruitIsland.post()
        
        if let islandData = self.fullData["fruitIsland"] {
            if let unwrappedIslandData = islandData as? (Int, Bool, Any, Any) {
                //modelName = isTrue ? "fruit_island" : "unknown_island"
                //self.fruitIsland = try! Entity.load(named: modelName)
                self.fruitIsland.addChild(try! Entity.load(named: "fruit_island"))
                self.fruitIsland.generateCollisionShapes(recursive: true)
                self.fruitIsland.name = "fruitIsland"
                self.fruitIsland.setScale(SIMD3<Float>(0.025, 0.025, 0.025), relativeTo: generalSceneAnchor)
                generalSceneAnchor.addChild(self.fruitIsland)
            }
        }
         

        if let islandData = fullData["natureIsland"] {
            if let unwrappedIslandData = islandData as? (Int, Bool, Any, Any) {
                let isTrue = unwrappedIslandData.1
                
                if isTrue {
                    self.natureIsland.addChild(try! Entity.load(named: "plane"))
                    self.natureIsland.name = "natureIsland"
                    //self.natureIsland.setScale(SIMD3<Float>(0.025, 0.025, 0.025), relativeTo: generalSceneAnchor)
                    self.natureIsland.position = simd_make_float3(1, 0, -1)
                    generalSceneAnchor.addChild(self.natureIsland)
                } else {
                    self.natureIsland.addChild(try! Entity.load(named: "unknown_island"))
                    self.natureIsland.name = "natureIsland"
                    self.natureIsland.setScale(SIMD3<Float>(0.025, 0.025, 0.025), relativeTo: generalSceneAnchor)
                    self.natureIsland.position = simd_make_float3(1, 0, -1)
                    self.generalSceneAnchor.addChild(self.natureIsland)
                }
                self.natureIsland.generateCollisionShapes(recursive: true)
            }
        }
                 
        /*
         - lvlContainer (Entidad raiz sin objeto 3D asociado, solo tiene hijas) <- cambiar posicion espacial para cada nivel
            - lvl_buttonContainer (Entidad contenedor del boton del nivel)
                - lvl_btn_true (Entidad de blender)
            - panel (Entidad normal) <- aplicar transformacion para que mire hacia el usuario y para mostrar/esconder
                - TH_buttonContainer (contenedor de boton de TH)
                    - TH_btn_true (modelo de blender)
                - quiz_buttonContainer (contenedor de boton de quiz)
                    - quiz_btn_true (modelo de blender)
                - video_buttonContainer (contenedor de boton de video)
                    - video_btn_true (modelo de blender)
         
         Si cada boton de actividad tiene su contenedor entonces el contenedor puede tener el nombre del id de la actividad
         Si un solo contenedor tiene todos los botones de todas las actividades no hay forma de saber el id de las actividades de cada boton
         */
        
        // =================================================================
        
        self.lvlContainer.name = "root_lvl_1"
        
        var lvl_buttonContainer: Entity = Entity()
        lvl_buttonContainer.name = "lvl_1"
        lvl_buttonContainer.addChild(try! Entity.load(named: "lvl_btn_false"))
        lvl_buttonContainer.setScale(SIMD3<Float>(0.1, 0.1, 0.1), relativeTo: specificSceneAnchor)
        lvl_buttonContainer.generateCollisionShapes(recursive: true)
        
        var panel: Entity = try! Entity.load(named: "panel_false")
        panel.name = "panel"
        panel.setScale(SIMD3<Float>(0.1, 0.1, 0.1), relativeTo: specificSceneAnchor)
        panel.generateCollisionShapes(recursive: true)
        panel.position = SIMD3(0, 0.4, 0)
        let rotation = simd_quatf(angle: .pi*3/2, axis: [0, 1, 0])
        panel.transform.rotation = rotation
        panel.setScale(SIMD3<Float>(0, 0, 0), relativeTo: specificSceneAnchor)
        
        var quiz_buttonContainer: Entity = Entity()
        quiz_buttonContainer.name = "quiz_1"
        quiz_buttonContainer.addChild(try! Entity.load(named: "quiz_btn_false"))
        //quiz_buttonContainer.setScale(SIMD3<Float>(0.1, 0.1, 0.1), relativeTo: specificSceneAnchor)
        quiz_buttonContainer.position = SIMD3(0.3, 0, 1.5)
        quiz_buttonContainer.generateCollisionShapes(recursive: true)
        
        var video_buttonContainer: Entity = Entity()
        video_buttonContainer.name = "video_1"
        video_buttonContainer.addChild(try! Entity.load(named: "video_btn_false"))
        //video_buttonContainer.setScale(SIMD3<Float>(0.1, 0.1, 0.1), relativeTo: specificSceneAnchor)
        video_buttonContainer.position = SIMD3(0.3, 0, 0)
        video_buttonContainer.generateCollisionShapes(recursive: true)
        
        var TH_buttonContainer: Entity = Entity()
        TH_buttonContainer.name = "TH_1"
        TH_buttonContainer.addChild(try! Entity.load(named: "TH_btn_false"))
        //TH_buttonContainer.setScale(SIMD3<Float>(0.1, 0.1, 0.1), relativeTo: specificSceneAnchor)
        TH_buttonContainer.position = SIMD3(0.3, 0, -1.5)
        TH_buttonContainer.generateCollisionShapes(recursive: true)
        
        self.lvlContainer.addChild(lvl_buttonContainer)
        self.lvlContainer.addChild(panel)
        panel.addChild(TH_buttonContainer)
        panel.addChild(quiz_buttonContainer)
        panel.addChild(video_buttonContainer)
        
        specificSceneAnchor.addChild(self.lvlContainer)
        
        let cubeMesh = MeshResource.generateBox(size: 0.3, cornerRadius: 0.02)
        let cubeMaterial = SimpleMaterial(color: .yellow, roughness: 0.85, isMetallic: true)
        let cubeModel = ModelEntity(mesh: cubeMesh, materials: [cubeMaterial])
        cubeModel.name = "return"
        cubeModel.position = SIMD3(0, 1, 0)
        cubeModel.generateCollisionShapes(recursive: true)
        specificSceneAnchor.addChild(cubeModel)
        
        // =================================================================
        
        //specificSceneAnchor.addChild(panel)
        //specificSceneAnchor.addChild(buttonEntity)
        
        // Ejemplo de rotación de 45 grados alrededor del eje Y
        //let rotation = simd_quatf(angle: .pi / 4, axis: [0, 1, 0])
        //panelContainer.transform.rotation = rotation
         
        /*
        self._isHW1Active = isHW1Active // Asigna el enlace
        self._isHW2Active = isHW1Active // Asigna el enlace
        self._isHW3Active = isHW1Active // Asigna el enlace
        self._isPanelVisible = isPanelVisible // Asigna el enlace
        */
         
        //self.loadIslands()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        arView.addGestureRecognizer(tapGesture)
        
        //self.loadScenesGestures()
        
        
        // =====================================================================================================
        // NOTIFICACIONES DE REALITY COMPOSER A XCODE
        
        // Este comando maneja las acciones a ejecutar cuando recibe la notificacion displayEarthDetails desde la escena seasonsChapter de RC
        /*
         seasonsChapter.actions.displayEarthDetails.onAction = { entity in
            ............ acciones a ejecutar aqui al recibir la notificacion ............
         }
         */
        
        // =====================================================================================================
        // NOTIFICACIONES DE XCODE A REALITY COMPOSER
        
        // Este comando ejecuta el behavior showGoldStar establecido previamente desde RC
        /*
         seasonsChapter.notifications.showGoldStar.post()
         */
        
        //arView.scene.anchors.append(generalSceneAnchor)
        arView.scene.addAnchor(self.generalSceneAnchor)
    }
    
    func loadIslands() {
        // carga todas las islas de la escena general
        
        /*
        self.fruitIsland.setScale(SIMD3<Float>(0.025, 0.025, 0.025), relativeTo: generalSceneAnchor)
        generalSceneAnchor.addChild(self.fruitIsland)
        
        self.fruitIsland.setScale(SIMD3<Float>(0.025, 0.025, 0.025), relativeTo: generalSceneAnchor)
        generalSceneAnchor.addChild(self.fruitIsland)
         */
        
    }
    
    func loadScenesGestures() {
        // carga los gestos de las 2 escenas de AR
        
        print("hi")
    }
    
    @objc func onTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: arView)
        if let tappedEntity = arView.entity(at: tapLocation){
            
            let parentEntity = findRootEntity(from: tappedEntity)
            
            print("====================================================")
            print("====================================================")
            print("====================================================")
            print(tappedEntity.name)
            print(tappedEntity.parent!.name)
            print(parentEntity!.name)
            print(parentEntity!.name.hasSuffix("Island"))
            let position = self.natureIsland.transform.matrix.columns.3
            print("X: \(position.x), Y: \(position.y), Z: \(position.z)")
            print("====================================================")
            print("====================================================")
            print("====================================================")
             
            // se toco una isla, cada una tiene una jerarquia compleja desde blender y por eso se requiere acceder hasta el contenedor que es hijo directo del anclaje
            if parentEntity!.name.hasSuffix("Island") {
                print("Bienvenido a la isla \(parentEntity!.name)")
                
                // si es una isla desconocida entonces se actualiza con el nuevo modelo
                if let islandData = fullData[parentEntity!.name] {
                    if let unwrappedIslandData = islandData as? (Int, Bool, Any, Any) {
                        let discovered = unwrappedIslandData.1
                        if discovered == false {
                            self.updateIsland(islandName: parentEntity!.name)
                        }
                    }
                }
                
                self.specificIslandLevels = self.loadSpecificIslandLevels(islandName: parentEntity!.name)
                arView.scene.anchors.removeAll()
                arView.scene.addAnchor(self.specificSceneAnchor)
            }
            // regresar a la vista de islas generales
            else if tappedEntity.name == "return" {
                arView.scene.anchors.removeAll()
                arView.scene.addAnchor(self.generalSceneAnchor)
            }
            // cargar vista de SwiftUI de TH
            else if tappedEntity.parent!.name.hasPrefix("TH_btn") {
                // establecer las demas vistas como apagadas
                self.isQuiz_Active = false
                self.isVideo_Active = false
                self.isTH_Active = true
            } else if tappedEntity.parent!.name.hasPrefix("quiz_btn") {
                // establecer las demas vistas como apagadas
                self.isVideo_Active = false
                self.isTH_Active = false
                self.isQuiz_Active = true
                print("================ DEBUG =================")
                print("================ DEBUG =================")
                print("================ DEBUG =================")
                print("================ DEBUG =================")
            } else if tappedEntity.parent!.name.hasPrefix("video_btn") {
                self.isTH_Active = false
                self.isQuiz_Active = false
                self.isVideo_Active = true
                print("================ DEBUG =================")
                print("================ DEBUG =================")
                print("================ DEBUG =================")
                print("================ DEBUG =================")
            }
            // se toco el boton de un nivel, solo se accede al padre porque se sabe que ese es el contenedor
            else if tappedEntity.parent!.name.hasPrefix("lvl") {
                // isPanelVisible, lastPanelSeen
                if self.isPanelVisible == false { // mostrar panel del nivel
                    
                    // buscar el panel y mostrarlo
                    if let tempPanel = parentEntity!.findEntity(named: "panel") {
                        var scaleTransform = tempPanel.transform
                        // el panel se muestra con su escala original conservando sus transformaciones
                        scaleTransform.scale = SIMD3(0.1, 0.1, 0.1)
                        tempPanel.move(to: scaleTransform, relativeTo: parentEntity, duration: 0.25, timingFunction: .easeInOut)
                    }
                    
                    // agregar el ultimo nivel visitado
                    self.lastPanelSeen = parentEntity!
                    
                    // indicar que hay un panel abierto
                    self.isPanelVisible = true
                    
                } else { // hay un panel abierto y pueden suceder 2 cosas
                    if parentEntity == self.lastPanelSeen {
                        
                        print("====================================================")
                        print("====================================================")
                        print("====================================================")
                        print("el mismo panel")
                        print("====================================================")
                        print("====================================================")
                        print("====================================================")
                        
                        // 1. Se toco el nivel del mismo panel abierto (cerrar el mismo panel)
                        if let tempPanel = parentEntity!.findEntity(named: "panel") {
                            // el panel se esconde con su escala original conservando sus transformaciones
                            // no se puede reescalar a 0 absoluto porque ocurre un conflicto con las
                            // transformaciones y fisicas (division entre cero) del objeto afectado
                            // y por eso se reescala a un valor diminuto casi invisible
                            var scaleTransform = tempPanel.transform
                            scaleTransform.scale = SIMD3(0.0001, 0.0001, 0.0001)
                            tempPanel.move(to: scaleTransform, relativeTo: parentEntity, duration: 0.25, timingFunction: .easeInOut)
                            
                            // no se visito ningun nivel, se cerro un nivel
                            self.lastPanelSeen = Entity()
                            
                            self.isPanelVisible = false
                        }
                    } else {
                        // 2. Se toco un nivel diferente del ultimo (cerrar viejo panel, abrir el nuevo)
                    }
                    
                    
                    
                    print("bruh")
                }
            }
            
            /*
            else if tappedEntity.name == "btn_1" {
                let transform = Transform(scale: .one, rotation: simd_quatf(angle: .pi, axis: [0, 1, 0]), translation: [0, 0, 0])
                self.lvlContainer.move(to: transform, relativeTo: specificSceneAnchor, duration: 5, timingFunction: .easeInOut)
            }
             */
            
        }
        
        /*
        if let islandEntity = arView.entity(at: tapLocation) {
            if islandEntity.name == "Ground Plane" {
                print("True")
            }
        }
        */
        
        /*
         let miString = "Ejemplo de string"

         if miString.hasPrefix("Ejemplo") {
             print("El string tiene el prefijo 'Ejemplo'")
         }

         if miString.hasSuffix("string") {
             print("El string tiene el sufijo 'string'")
         }
         */
    }
    
    func updateIsland(islandName: String) {
        // se actualiza el valor en la estructura global
        self.fullData[islandName]!.1 = true
        
        // se actualiza el objeto en 3D a la isla normal
        // if let newObject = try? Entity.load(named: islandName) {
        // nombre del asset directo
        if let newObject = try? Entity.load(named: "fruit_island") {
            
            // buscar el contenedor de isla con el nombre ingresado
            if case let islandContainer? = self.generalSceneAnchor.findEntity(named: islandName) {
                
                /*
                // Obtiene las transformaciones y propiedades de la Entidad anterior
                let originalTransform = islandContainer.transform
                
                // Aplica las transformaciones y propiedades de la Entidad anterior a la nueva Entidad
                newObject.transform = originalTransform
                
                // Quitar todos los hijos del contenedor
                islandContainer.children.removeAll()
                
                // Agregar la nueva entidad al contenedor
                islandContainer.addChild(newObject)
                 */
                
                
                // las transformaciones y propiedades no aplican a la Entidad hija, aplican al
                // contenedor, por eso solo se eliminan todas las Entidades hijas, se agrega
                // la nueva Entidad como hija y las transformaciones previas afectan a la nueva Entidad
                
                // quitar todos los hijos del contenedor
                islandContainer.children.removeAll()
                
                // agregar la nueva entidad al contenedor
                newObject.generateCollisionShapes(recursive: true)
                islandContainer.addChild(newObject)
            }
        }
    }
    
    func loadSpecificIslandLevels(islandName: String) -> [Entity] {
        // carga las entidades de los niveles de una isla especifica de acuerdo a la cantidad de niveles y actividades de la isla
        var levelsArray: [Entity] = [] // arreglo final con todas las actividades con
        //var userAdvance: [Any] = [] // solo actividades completadas de la isla
        //var islandLevels:[Any] = [] // todos los niveles y actividades de la isla
        
        //userAdvance.append(self.fullData[islandName]!.2)
        //islandLevels.append(self.fullData[islandName]!.3)
        
        // inicializar niveles en ceros
        /*
         - lvlContainer (Entidad raiz sin objeto 3D asociado, solo tiene hijas) <- cambiar posicion espacial para cada nivel
            - lvl_buttonContainer (Entidad contenedor del boton del nivel)
                - lvl_btn_true (Entidad de blender)
            - panel (Entidad normal) <- aplicar transformacion para que mire hacia el usuario y para mostrar/esconder
                - TH_buttonContainer (contenedor de boton de TH)
                    - TH_btn_true (modelo de blender)
                - quiz_buttonContainer (contenedor de boton de quiz)
                    - quiz_btn_true (modelo de blender)
                - video_buttonContainer (contenedor de boton de video)
                    - video_btn_true (modelo de blender)
         
         for level in islandLevels {
             print("bruh")
         }
         */
        
        // agregar los niveles en diferentes zonas espaciales
        
        // modificar los niveles de acuerdo al avance del usuario
        
        // ==========================================================
        // Codigo de la presentacion (borrar despues)
        
        return levelsArray
    }
    
    func findRootEntity(from entity: Entity) -> Entity? {
        // devuelve la Entidad que es raiz o padre de todas las Entidades hijas
        
        /*
         No solo se puede encontrar una entidad, tambien se le puede aplicar una transformacion
     
         Se recomienda que todas las Entidades tengan un nombre antes de aplicar el metodo
     
         Se recomienda evitar que el anclaje tenga nombre porque si estoy manejando varias escenas nunca sabre cuando se encontrara una hija directa del anclaje porque son varios anclajes. Si ningun anclaje tiene nombre (configuracion predeterminada) o si todos los anclajes tienen el mismo nombre (no recomendado) se puede modificar el limite, es decir, si ningun anclaje tiene nombre entonces el limite de busqueda es cuando la entidad padre tiene de nombre "" y sucede cuando los anclajes no tienen nombre o se puede poner el nombre especifico que comparten todos los anclajes
         */
        
        print("Empezando busqueda")
        var currentEntity: Entity? = entity

        while let parent = currentEntity?.parent {
            if parent.name == "" {
                print("Busqueda terminada")
                return currentEntity
            } else {
                currentEntity = parent
            }
        }
        return currentEntity
    }
    
    func resetActivities() -> Void {
        self.isTH_Active = false
        self.isQuiz_Active = false
        self.isVideo_Active = false
    }
    
    func updateLevel(actName: String) -> Void {
        
        print("completada la actividad \(actName)")
        print("completada la actividad \(actName)")
        print("completada la actividad \(actName)")
        print("completada la actividad \(actName)")
        
        var oldButton: String = ""
        var newButton: String = ""
        var completedActivities = 0
        
        if actName == "TH_1" {
            oldButton = "TH_1"
            newButton = "TH_btn_true"
        } else if actName == "quiz_1" {
            oldButton = "quiz_1"
            newButton = "quiz_btn_true"
        } else if actName == "video_1" {
            oldButton = "video_1"
            newButton = "video_btn_true"
        }
        
        // contar todas las actividades completadas
        if case let buttonContainer? = self.specificSceneAnchor.findEntity(named: "TH_btn_true") {
            print("TH encontrado")
            print("TH encontrado")
            print("TH encontrado")
            print("TH encontrado")
            print("TH encontrado")
        } else {
            print("TH no encontrado")
            print("TH no encontrado")
            print("TH no encontrado")
            print("TH no encontrado")
            print("TH no encontrado")
        }
        
        if let childEntity = self.specificSceneAnchor.findEntity(named: "TH_btn_true") {
            completedActivities += 1
        }
        
        if let childEntity = self.specificSceneAnchor.findEntity(named: "quiz_btn_true") {
            completedActivities += 1
        }
        
        if let childEntity = self.specificSceneAnchor.findEntity(named: "video_btn_true") {
            completedActivities += 1
        }
        
        // obtener el nombre del nuevo boton con base en las sentenccias
        if let newObject = try? Entity.load(named: newButton) {
            
            // buscar el contenedor del boton viejo
            if case let buttonContainer? = self.specificSceneAnchor.findEntity(named: oldButton) {
                
                print(buttonContainer.name)
                print(buttonContainer.children)
                
                // eliminar el boton viejo
                buttonContainer.children.removeAll()
                
                // agregar la nueva entidad al contenedor
                newObject.generateCollisionShapes(recursive: true)
                buttonContainer.addChild(newObject)
                
                // si se completaron todas las actividades se actualiza el color del panel y del nivel
                print("===========================")
                print("===========================")
                print("Completed Activities: \(completedActivities)")
                print("===========================")
                print("===========================")
                if (completedActivities+1) == 3 {
                    print("===========================")
                    print("===========================")
                    print("TODAS LAS ACTIVIDADES COMPLETADAS")
                    print("===========================")
                    print("===========================")
                    if let newPanel = try? Entity.load(named: "panel_true") {
                        if case let panel = self.specificSceneAnchor.findEntity(named: "panel") {
                            // conservando los hijos del panel anterior
                            //var panelChildren = panel!.children.removeAll()
                            if let newModelComponent = newPanel.components[ModelComponent.self] {

                                // Reemplaza el componente ModelComponent de la entidad original con el del nuevo asset
                                panel!.components[ModelComponent.self] = newModelComponent
                            }
                        }
                    }
                    
                    if let newLvl = try? Entity.load(named: "lvl_btn_true") {
                        if case let lvl = self.specificSceneAnchor.findEntity(named: "lvl_btn_false") {
                            if let newModelComponent = newLvl.components[ModelComponent.self] {
                                lvl!.components[ModelComponent.self] = newModelComponent
                            }
                        }
                    }
                }
            }
        }
    }
}

/*
 bag = ModelEntity.loadAsync(named: "x").sink { completion in
    ........
 } receiveValue: { result in
    .......
    for anim in result.availableAnimations {
        result.playAnimations(anim.repeat(duration: .infinity), transitionDuration: 1.25, startPaused: false)
    }
 }
 
 
 
 if let boxScene = try? Experience.loadBox() {
     if let box = boxScene.findEntity(named: "Steel Box") {}
         // Do something with box
     }
 }
 
 
 
 
 let dummy_1: Entity = Entity()
 dummy_1.name = "111"
 let dummy_2: Entity = Entity()
 dummy_2.name = "222"
 let dummy_3: Entity = Entity()
 dummy_3.name = "333"
 let dummy_4: Entity = Entity()
 dummy_4.name = "444"
 let dummy_5: Entity = Entity()
 dummy_5.name = "555"
 dummy_3.addChild(dummy_4)
 dummy_2.addChild(dummy_3)
 dummy_1.addChild(dummy_2)
 dummy_1.addChild(dummy_5)
  
  /*
   La estructura jerarquica es la siguiente:
   - dummy_1 (raíz)
     - dummy_2 ("222")
       - dummy_3 ("333")
         - dummy_4 ("444")
     - dummy_5 ("555")
   Si quiero aplicarle una transformacion a dummy_2 afectara a todos sus descendientes (dummy_3 y dummy_4)
   pero la transformacion no afectara ni a dummy_5 ni a dummy_1
   */
 
  // desde una entidad nieta busca la entidad raiz o la entidad abuela
 if let dummy4 = self.findRootEntity(from: dummy_4) {
     print("====================================================")
     print("====================================================")
     print("====================================================")
 
     /*
      No solo se puede encontrar una entidad, tambien se le puede aplicar una transformacion
  
      Se recomienda que todas las Entidades tengan un nombre antes de aplicar el metodo
  
      Se recomienda evitar que el anclaje tenga nombre porque si estoy manejando varias escenas nunca sabre cuando se encontrara una hija directa del anclaje porque son varios anclajes. Si ningun anclaje tiene nombre (configuracion predeterminada) o si todos los anclajes tienen el mismo nombre (no recomendado) se puede modificar el limite, es decir, si ningun anclaje tiene nombre entonces el limite de busqueda es cuando la entidad padre tiene de nombre "" y sucede cuando los anclajes no tienen nombre o se puede poner el nombre especifico que comparten todos los anclajes
      */
     print(dummy4.name)
     print("====================================================")
     print("====================================================")
     print("====================================================")
 }
 
  // desde una entidad abuela o raiz busca una entidad nieta
 if let dummy3 = dummy_1.findEntity(named: "333") {
     print("====================================================")
     print("====================================================")
     print("====================================================")
     // No solo se puede encontrar una entidad, tambien se le puede aplicar una transformacion
     print(dummy3.name)
     print("====================================================")
     print("====================================================")
     print("====================================================")
 }
 
 
 
 
  // PANEL QUE SE LE PUEDE CAMBIAR DE COLOR A SUS BOTONES
 var panel: Entity = try! Entity.load(named: "Panel_3")
 panel.setScale(SIMD3<Float>(0.1, 0.1, 0.1), relativeTo: specificSceneAnchor)
 //panel.position = simd_make_float3(1, 0, 1)
 let radians = 0 - 60.0 * Float.pi / 180.0
 panel.transform.rotation *= simd_quatf(angle: radians, axis: SIMD3<Float>(0, 1, 0))
 if let btn1 = panel.findEntity(named: "btn_1") as? ModelEntity {
     
     // Cambiar el color del sub-objeto "btn_1"
     // materials es un arreglo de los materiales aplicados al objeto desde blender, en este
     // caso el objeto solo tiene un material y se esta accediendo al primer y unico material
     btn1.model?.materials[0] = SimpleMaterial(color: .blue, isMetallic: false)
 }
 
 if let btn2 = panel.findEntity(named: "btn_2") as? ModelEntity {
     
     // Cambiar el color del sub-objeto "btn_1"
     // materials es un arreglo de los materiales aplicados al objeto desde blender, en este
     // caso el objeto solo tiene un material y se esta accediendo al primer y unico material
     btn2.model?.materials[0] = SimpleMaterial(color: .gray, isMetallic: false)
 }
 
 if let btn3 = panel.findEntity(named: "btn_3") as? ModelEntity {
     
     // Cambiar el color del sub-objeto "btn_1"
     // materials es un arreglo de los materiales aplicados al objeto desde blender, en este
     // caso el objeto solo tiene un material y se esta accediendo al primer y unico material
     btn3.model?.materials[0] = SimpleMaterial(color: .gray, isMetallic: false)
 }
 // esto crea un colisionador para todas las entidades del archivo usdz de panel
 panel.generateCollisionShapes(recursive: true)
 specificSceneAnchor.addChild(panel)
 //specificSceneAnchor.children.append()

 
 
 
 Tipos de variables de RealityKit (https://developer.apple.com/documentation/realitykit/hashierarchy) -> AnchorEntity, BodyTrackedEntity, DirectionalLight, Entity, ModelEntity, PerspectiveCamera, PointLight, SpotLight, TriggerVolume, ViewAttachmentEntity
 
 Obtener los componentes (Transform (rotacion, escalado, posision), fisicas, animaciones, audio) de una entidad -> var components: Entity.ComponentSet { get set }
 
 Verificar si una entidad tiene un componente especifico -> func has(_ componentType: Component.Type) -> Bool
 
 Eliminar todas las entidades hijas de una entidad padre -> removeAll(keepCapacity: Bool = false, preservingWorldTransforms: Bool = false) -> keepCapacity true es para conservar la memoria ocupada de las entidades hijas y false es para liberar la memoria ocupada por las entidades hijas, preservingWorldTransform true es para que todas las entidades conserven su tamanio y posicion en la escena
 
 Eliminar una entidad hija especifica de una entidad padre -> func remove(_ child: Entity, preservingWorldTransform: Bool = false)
 
 Obtener todas las entidades hijas de una entidad padre -> parentEntity.children
 
 Agregar una Entidad como hija de otra -> func setParent(_ parent: Entity?,preservingWorldTransform: Bool = false)
 
 Mover una Entidad a otro espacio -> func move(to transform: Transform, relativeTo referenceEntity: Entity?) -> el parametro referenceEntity define la entidad como marco de referencia. Establecerlo como nil para indicar espacio del mundo
 
 Obtener las coordenadas espaciales de una entidad (https://developer.apple.com/documentation/realitykit/entity/position(relativeto:)) -> func position(relativeTo referenceEntity: Entity?) -> SIMD3<Float> -> referenceEntity: The entity that defines a frame of reference. Set this to nil to indicate world space. Esa funcion no me sirvio pero la que si me sirvio fue la siguiente:
     let position = Entity.transform.matrix.columns.3
     print("X: \(position.x), Y: \(position.y), Z: \(position.z)")
 
 Positions and orients the entity to look at a target from a given position (https://developer.apple.com/documentation/realitykit/hastransform/look(at:from:upvector:relativeto:)) ->
 func look(at target: SIMD3<Float>, from position: SIMD3<Float>, upVector: SIMD3<Float> = SIMD3<Float>(0, 1, 0), relativeTo referenceEntity: Entity?)
 
 Computes a bounding box for the entity in the specified space, optionally including child entities (https://developer.apple.com/documentation/realitykit/entity/visualbounds(recursive:relativeto:excludeinactive:)) -> func visualBounds(recursive: Bool = true, relativeTo referenceEntity: Entity?, excludeInactive: Bool = false) -> BoundingBox
 
 
 Otros recursos donde hay demasiadas funciones utiles:
 * https://developer.apple.com/documentation/realitykit/hashierarchy
 * https://developer.apple.com/documentation/realitykit/entity/childcollection
 * Animar un objeto (rotar) de forma infinita -> https://rozengain.medium.com/quick-realitykit-tutorial-2-looping-animations-gestures-ee518b06b7f6
 */


/*
 
PENDIENTES
 * FALTA ASOCIAR EL PANEL A UN NIVEL
 
 * FALTA HACER LA FUNCION PARA CREAR EL PANEL DE ACUERDO A LA CANTIDAD DE BOTONES, SUS POSICIONES Y COLORES
 
 * FALTA QUE AL TOCAR UNA ENTIDAD NO SOLO IMPRIMA EL NOMBRE DEL SUB-OBJETO DE LA ENTIDAD PADRE, SINO QUE TAMBIEN DEVUELVA EL NOMBRE DE LA ENTIDAD PADRE
 
 * CREAR LA FUNCION updateIsland() PARA MARCAR UNA ISLA DESCONOCIDA COMO CONOCIDA
 
 
DESCUBRIMIENTOS
 
 * Se puede aplicar transformaciones (mover, rotar, reescalar) tanto a Entidades como a un anclaje, en el primer caso la transformacion solo afecta a la Entidad especifica (y a sus hijas) sin afectar a las demas del mismo anclaje pero en la segunda opcion afecta a todas las Entidades del anclaje por igual
 
 * El raycasting o la funcion let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(_:))) aplica para todos los anclajes de la variable arView, solo puede existir un anclaje a la vez pero aunque se elimine uno y se agregue un nuevo anclaje la funcion de tapGesture sigue funcionando para el nuevo y los siguientes anclajes.
 
 * Los objetos no responden al raycast si no tienen un colisionador
 
 * Al cargar un archivo usdz que consta de sub-objetos (desdde blender) y se guarda en una entidad, al aplicarle un colisionador aplica para todos los sub-objetos del archivo usdz que estan en una sola entidad

 * Los comandos `Entity.setScale(SIMD3<Float>(X, Y, Z), relativeTo: Anchor)` y `Entity.transform.scale = SIMD3(X, Y, Z)` a simple vista hacen lo mismo (reescalan un objeto a los valores indicados) pero en el fondo trabajan diferente, por ejemplo el primer comando si admite que se ingresen de valores (0, 0, 0) para hacer un objeto invisible pero no permite aplicar animaciones mientras que el segundo comando NO permite aplicar valores (0, 0, 0) a un objeto porque entra en conflicto con fisicas y transformaciones ya que al tener ceros puede hacer una division entre cero y dejan de funcionar las fisicas y transformaciones, pero si funcionan las animaciones, para solucionar el problema en vez establecer en ceros como la escala del objeto es mejor establecer de valores (0.0001, 0.0001, 0.0001) para hacerlo diminuto que casi no se vea y de esa forma se evita el problema de division entre cero, no es como tla un error porque no detiene la ejecucion del programa pero se buggea la Entidad perdiendo todas sus propiedades y se comporta raro.
 
 * Los comandos `anchor.children.append(Entity)` y `anchor.addChild(Entity)` agregan objetos a un anclaje, a simple vista hacen lo mismo pero tienen diferencias tecnicas de bajo nivel, en ambos comandos como quiera detecta todas las entidades de un archivo usdz cuando se imprime el nombre de la entidad tocada, en addChild() se puede establecer un sistema jerarquico de entidades para aplicar transformacines a una rama de entidades sin afectar a otra mientas que en .children.append() todas las entidades agregadas son hijas pero no hay sistema jerarquico, todas las entidades hijas estan en el mismo nivel. Eso es información que en internet no se encuentra con ninguna facilidad mas que en la documentacion, me entere de esto porque mi codigo no funcionaba y empezo a dar problemas debido a una mala jerarquia de entidades
 
 * Si se aplica una transformacion a una Entidad padre no importa si aplique dicha transformacion antes o despues de agregar a la entidad hija, en ambos casos la transformacion afectara a todos los hijos directos de la entidad padre
 
 * Los comandos `arView.scene.anchors.append(generalSceneAnchor)` y `arView.scene.addAnchor(generalSceneAnchor)` agregan un anclaje a la variable arView, a simple vista hacen lo mismo pero

 * Al guardar cada isla en una escena diferente de RC y al obtener esa isla y ponerla en otra escena se pierden todos los behaviors asociados, el objeto se carga correctamente pero sin behaviors
 
 * Modificar material y texturas de un nuevo objeto desde codigo, tambien explica todos los tipos de transformaciones -> https://codingxr.com/articles/introduction-to-realitykit/
 
 * Explicacion sobre gestos (mover, rotar, escalar) y como aplicar un determinado gesto a un objeto -> https://codingxr.com/articles/interactivity-in-realitykit/
 
 * Hace una animacion basica moviendo y escalando un objeto desde codigo de RealityKit, explica como manejar las distintas animaciones de un objeto de blender -> https://codingxr.com/articles/animation-in-realitykit/
 
 // Replaces targets in the action sequence named originalTarget.name with newTarget
 seasonsChapter.notifications.showGoldStar.post(overrides: [originalTarget.name: newTarget])
 
 0. showGoldStar es el nombre de la notificacion (¿el behavior tiene un objeto asignado o no?: al parecer las animaciones si tienen objetos asignados), (¿Se puede aplicar a un objeto que está en otra escena de RC o la escena de todos los objetos ya debe tener todos los behaviors?: al parecer todos los objetos ya deben existir en una única escena con sus respectivos behaviors y notificaciones)
 1. Obtener notificaciones de la escena y guardarlas en una variable
 2. Clonar la entidad con el behavior asociado, guardarlo en una nueva variable
 3. Aplicar el behavior al objeto clonado con el comando notifications.showGoldStar.post(overrides: [dummyIsland.name: clonedIsland])
 4. Agregar la entidad clonada al anclaje
 
 En caso de que el paso 0 necesite los objetos y behaviors ya existentes en la escena se pueden poner todos los objetos en cualquier posicion con sus behaviors y al determinar en cada isla si esta descubierta o no se clonan las propiedades del objeto de la escena al objeto atributo de la clase, luego se elimina de la escena la isla actual y despues se posiciona el atributo de la clase en el anclaje
 
 
 Entonces cada isla especifica debe tener su propia escena para ponerle behaviors a objetos del entorno. En ese caso si se puede hacer el panel de actividades en vez de mostrar solo minibotones al tocar un nivel
 
 ===================================================================================
 
 RECOMENDACIONES GENERALES DEL PROYECTO:
 
 * Al exportar un archivo en 3D desde blender debo cuidarlo de acuerdo a las necesidades del proyecto: si solo voy a usar Reality Composer el archivo usdz funcionara como uno solo con todos los assets distintos fusionados en una misma estructura, pero si voy a cargar el mismo archivo desde Xcode y al programar un RayCast al objeto si trato de imprimir el nombre de la entidad que toco el usuario va a aparecer el nombre del asset separado porque desde Blender fueron varios assets diferentes en un solo archivo usdz. Reality Composer lo detecta como un unico archivo ya que al programar un behavior de onTap todos los assets del objeto estan pegados pero desde Xcode aunque sea un solo archivo usdz en realidad no estan pegados y son assets independientes pero en el mismo archivo usdz. Incluso si desde blender se fusionan todos los objetos en uno solo y se exporta sigue sucediendo lo mismo, el raycast detecta a cada entidad especifica del mismo archivio usdz. Si quiero identificar al archivo con varias entidades como una sola entidad puedo cargar la entidad y agregarlo como hija de otra entidad y al tocar cualquier sub-entidad del archivo puedo preguntar por el nombre de la entidad padre que sera el mismo para todas las sub-entidades del archivo usdz. Otra cosa que no esperaba es que al exportar una entidad desde blender esta conserva todas sus propiedades (escala, rotacion, coordenadas espaciales) y si al exportar una entidad tenia de coordenadas (1, 2, 5) al cargarlo desde Xcode a una escena va a aparecer en esas coordenadas incluso si sobreescribo sus coordenadas de forma manual a (0, 0, 0), en este ejemplo si quiero regresarlo al centro debo moverlo a (-1, -2, -5). Una forma de evitar esto es exportar todos los assets desde el centro de blender (0, 0, 0) o bien si siempre van a tener la misma posicion y cantidad de sub-entidades no hay problema sobre las coordenadas espaciales de cada entidad.
 
 * Se le puede aplicar un nombre a una entidad, pero jamas se podra cambiar el nombre de las sub-entidades que se crearon desde blender y que se encuentran en un mismo archivo usdz, para que reconozca todas las sub-entidades como una sola hay que poner la entidad el archivo usdz en una entidad contenedor (como hija) y buscar el nombre de la entidad padre que siempre sera el mismo para todas las subentidades
 
 * En SceneKit cuando estoy construyendo una escena .scn a partir de entidades de otras escenas .scn en la escena principal con las demas entidades de otras escenas no se veran reflejados los cambios de los assets especificos si no se guardan los cambios cada vez que se modifique algo
 
 * En SceneKit al crear una escena con entidades atomicas desde blender se puede modificar el color entero de cada entidad pero primero hay que seleccionar la entidad especifica e ir "desenmascarando la munieca rusa" hasta encontrar la entidad mas escondida y seleccionarla (tiene el mismo nombre que se le dio en el sistema de nodos de blender desde la vista exterior). Luego en el menu de la derecha hay que ir a la seccion del sexto boton, ahi aparecera el nombre de la textura aplicada al objeto desde blender pero hay que dar click en override para marcar con un nuevo color la entidad seleccionada. Desafortunadamente no se puede cambiar el nombre de la entidad, solo aparece como una referencia, para hacer copias de la misma entidad pero con diferentes nombres hay que ir a blender y exportar n veces la misma entidad pero con nombres diferentes (desde el sistema de nodos)
 
 * Las escenas de SceneKit tienen el formato .scn y en la mac vieja no se puede exportar a .usdz o a .dae simplemente dando file -> export -> dae/usdz, es verdad que primero hay que convertir a .dae, pasarlo a blender para convertirlo a .glb y luego convertirlo a .usdz con RealityConverter pero simplemente no funcionaba el primer paso en la mac vieja, para convertirlo a .dae se tuvo que usar herramientas de Xcode desde la terminal, para abri la terminal en el directorio de la escena con los assets (no se debe copiar y pegar en un directorio más cercano porque si la escena tiene assets de otras escenas todo se perderá, desde la terminal hay que ir a la dirección de la escena). Una vez ahí se debe ejecutar el comando `xcrun scntool --convert MainScene.scn --output MainScene.dae --format dae` pero la primera vez que lo corrí mandó el error "xcrun: error: unable to find utility "scntool", not a developer tool or in PATH" que solucioné en el post https://stackoverflow.com/questions/57236842/migrating-scenekit-app-from-xc10-xc11-i-encounter-xcrun-error-unable-to-fi, ese comando devuelve el archivo .dae de la escena de SceneKit. Ahora ya se puede cargar en blender. Si estoy trabajando con un simple objeto y no un ambiente con iluminacion y camara se recomienda eliminar los nodos de la camara e iluminacion en blender para que no estorben a la hora de modificar una propiedad especifica de un nodo del archivo de blender pero ya convertido a .usdz. Despues solo hay que exportarlo a .glb y luego usar Reality Converter y todo listo.
 
 * Un archivo usdz creado desde Scenekit/Blender pierde todas las entidades individuales cuando el archivo se carga a Reality Composer desde la GUI y luego se obtiene esa escena para cargarla al anclaje.
*/

