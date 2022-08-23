//
//  MagicListView.swift
//  BaseMini001
//
//  Created by Matheus Cavalcanti de Arruda on 21/08/22.
//

import SwiftUI

struct MagicListView: View {
    @Binding var magicArr: [Magic]
    @Binding var arrList: [Magic]
    @State var searchText: String = ""
    
    @State var deletedMagicAlert: Bool = false
    @State var confirmDelete: Bool = false
    @State var magicAux: Magic? = nil
    
    var completion: (Magic) -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                TextField("Buscar por nome", text: $searchText)
                Button {
                    DispatchQueue.main.async {
                        if searchText.isEmpty {
                            arrList = magicArr
                        } else {
                            arrList = magicArr.filter({$0.name.lowercased().contains(searchText.lowercased())})
                        }
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                    Text("Buscar")
                }
                
                Button {
                    searchText = ""
                    arrList = magicArr
                } label: {
                    Text("Limpar")
                }
            }.padding(.horizontal, 10)
            List {
                Section {
                    ForEach($arrList, id: \.id) {magic in
                        LazyVStack {
                            MagicCellList(magic: magic)
                            HStack {
                                Button {
                                    completion(magic.wrappedValue)
                                } label: {
                                    Text("Copiar")
                                }
                                Button {
                                    confirmDelete.toggle()
                                    magicAux = magic.wrappedValue
                                } label: {
                                    Text("Aapagar")
                                    Image(systemName: "trash.fill")
                                }
                            }
                        }
                        .padding(10)
                        .frame(minWidth: 200, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .foregroundColor(.black)
                        .background(Color(nsColor: .systemGray))
                        .cornerRadius(20)
                    }
                } header: {
                    Text("Lista Magias")
                }.listStyle(.sidebar)
            }
        }
        
        .alert("Tem certeza que deseja deletar \(magicAux?.name ?? "<<ERROR>>")?", isPresented: $confirmDelete) {
            HStack {
                Button("Cancelar", role: .cancel) {}
                Button("Apagar", role: .destructive) {
                    if let m = magicAux {
                        deletedMagicAlert = MagicUtils.deleteMagic(magic: m)
                        magicArr = MagicUtils.fetch()
                        arrList = magicArr
                        searchText = ""
                        magicAux = nil
                    }
                }
            }
        }
        
        .alert("Magia apagada com sucesso.", isPresented: $deletedMagicAlert) {
            Button("Ok", role: .cancel){}
        }
    }
}

protocol DeleteMagicDelegate {
    func deleteMagic(magic: Magic)
}

struct MagicListView_Previews: PreviewProvider {
    static var previews: some View {
        MagicListView(magicArr: .constant([]), arrList: .constant([])) {_ in }
    }
}

struct MagicCellList: View {
    
    var magic: Binding<Magic>
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 5) {
            Text("Nome: \(magic.wrappedValue.name)")
            Text("Classes: \(MagicUtils.charClassFormatter(arr: magic.wrappedValue.charClasses))")
            HStack(spacing: 15) {
                Text("Nível: \(magic.wrappedValue.level)")
                Text("|")
                Text("Escola: \(magic.magicSchool.wrappedValue.rawValue)")
                Text("|")
                Text("Ritual: \(magic.wrappedValue.ritual ? "Sim" : "Não")")
            }
            Text("Tempo de Conjuração: \(magic.wrappedValue.time)")
            Text("Alcance: \(magic.wrappedValue.range)")
            Text("Componentes: \(magic.wrappedValue.components)")
            Text("Duração: \(magic.wrappedValue.duration)")
            Text("Descrição:\n\(magic.wrappedValue.description)")
        }
    }
}
