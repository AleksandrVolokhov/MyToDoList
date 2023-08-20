import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        Group {
            switch listViewModel.state {
            case .loading:
                ProgressView()
            case .empty:
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            case .content:
                content
            }
        }
        .navigationTitle("Todo List 📝")
        .navigationBarItems(
            leading: listViewModel.state == .content ? EditButton() : nil,
            trailing:NavigationLink("Add", destination: AddView())
            )
    }
    
    private var content: some View {
        List {
            ForEach(listViewModel.items) { item in
                ListRowView(item: item)
                    .onTapGesture {
                        withAnimation(.linear) {
                            listViewModel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
        .listStyle(.plain)
            }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}
