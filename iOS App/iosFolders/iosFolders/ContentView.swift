import SwiftUI

struct Object: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let category: String
    let imageName: String
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
    var objects: [Object]
}

struct ContentView: View {
    @State private var categories: [Category] = [
        Category(
            name: "Fruits",
            objects: [
                Object(name: "Banana", category: "Fruit", imageName: "banana_image"),
                Object(name: "Apple", category: "Fruit", imageName: "apple_image"),
                Object(name: "Pineapple", category: "Fruit", imageName: "pineapple_image"),
                Object(name: "Strawberry", category: "Fruit", imageName: "strawberry_image"),
                Object(name: "Grape", category: "Fruit", imageName: "grape_image"),
                Object(name: "Pear", category: "Fruit", imageName: "pear_image"),
                Object(name: "Strawberry", category: "Fruit", imageName: "strawberry_image"),
                Object(name: "Grape", category: "Fruit", imageName: "grape_image"),
                Object(name: "Pear", category: "Fruit", imageName: "pear_image"),
                Object(name: "Strawberry", category: "Fruit", imageName: "strawberry_image"),
                Object(name: "Grape", category: "Fruit", imageName: "grape_image"),
                Object(name: "Pear", category: "Fruit", imageName: "pear_image"),
            ]
        ),
        Category(
            name: "Vegetables",
            objects: [
                Object(name: "Broccoli", category: "Vegetable", imageName: "broccoli_image"),
                Object(name: "Carrot", category: "Vegetable", imageName: "carrot_image"),
            ]
        ),
    ]

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var maxObjectsPerCategory: Int {
        let isLandscape = horizontalSizeClass == .regular && verticalSizeClass == .compact
        return isLandscape ? 8 : 6
    }

    var body: some View {
        NavigationView {
            content
                .navigationTitle("Object Grid")
                .background(Color.black)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    var content: some View {
        ScrollView {
            LazyVStack {
                ForEach(categories) { category in
                    CategoryView(category: category, maxObjects: maxObjectsPerCategory)
                }
            }
        }
    }
}

struct CategoryView: View {
    let category: Category
    let maxObjects: Int // Maximum number of objects to display per category

    @State private var showAllObjects = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(category.name)
                .font(.title)
                .padding(8)
                .foregroundColor(.black)

            LazyVGrid(columns: columns(), spacing: 8) {
                ForEach(category.objects.prefix(showAllObjects ? category.objects.count : maxObjects)) { object in
                    ObjectView(object: object)
                }
            }

            if category.objects.count > maxObjects {
                Button(action: {
                    showAllObjects.toggle()
                }) {
                    Text(showAllObjects ? "Show Less" : "Show More")
                        .foregroundColor(.blue)
                }
                .padding(.top, 8)
            }
        }
        .padding()
        .background(Color.gray)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    func columns() -> [GridItem] {
        let isLandscape = maxObjects == 8
        return Array(repeating: GridItem(.flexible(), spacing: 8), count: isLandscape ? 4 : 3)
    }
}

struct ObjectView: View {
    let object: Object

    var body: some View {
        VStack {
            Image(object.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .background(Color.white)
                .cornerRadius(10)

            Text(object.name)
                .font(.headline)
                .padding(.top, 5)
                .foregroundColor(.white)
        }
        .padding()
    }
}

struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
