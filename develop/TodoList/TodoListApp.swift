import SwiftUI

@main
struct TodoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView(listViewModel: .init())
            }
            .navigationViewStyle(.stack)
            .environmentObject(listViewModel)
        }
    }
}
