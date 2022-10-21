//
//  EditMagicView.swift
//  BaseMini001
//
//  Created by Matheus Cavalcanti de Arruda on 21/08/22.
//

import SwiftUI

struct EditMagicView: View {
    
    @Binding var magic: Magic
    
    var body: some View {
        VStack {
            Text("\(MagicUtils.folderPath)")
                .textSelection(.enabled)
            HStack {
                Picker("ID", selection: $magic.id) {
                    
                }
            }
            MagicInfoTextFieldsView(magic: $magic)
            HStack {
                LevelListView(magic: $magic)
                MagicSchoolListView(magic: $magic)
                CharClassListView(magic: $magic)
            }
        }
    }
}

struct EditMagicView_Previews: PreviewProvider {
    
    static var previews: some View {
        EditMagicView(magic: .constant(Magic(id: 1, name: "", level: 1, charClasses: [], magicSchool: .abjuracao, ritual: true, time: "", range: "", components: "", duration: "", description: "")))
    }
}

struct MagicInfoTextFieldsView: View {
    
    @Binding var magic: Magic
    
    var body: some View {
        VStack {
            HStack {
                Toggle(isOn: $magic.ritual, label: {Text("Ritual")})
                    .toggleStyle(.switch)
                Text("Nome")
                TextField("Nome", text: $magic.name)
            }
            HStack {
                Text("Tempo de Conjuração")
                TextField("Tempo de Conjuração", text: $magic.time)
            }
            HStack {
                Text("Alcance")
                TextField("Alcance", text: $magic.range)
            }
            HStack {
                Text("Duração")
                TextField("Duração", text: $magic.duration)
            }
            Text("Componentes")
            TextEditor(text: $magic.components)
                .frame(minHeight: 100)
            Text("Descrição")
            TextEditor(text: $magic.description)
                .frame(minHeight: 170)
        }
        .padding()
    }
}

struct MagicSchoolListView: View {
    
    @Binding var magic: Magic
    
    @State var options: [(MagicSchool, Bool)] = [(.abjuracao, false), (.adivinhacao, false), (.conjuracao, false), (.encantamento,false), (.evocacao, false), (.ilusao, false), (.necromancia, false), (.transmutacao, false)]
    
    var arrList: Binding<[(MagicSchool, Bool)]> {
        DispatchQueue.main.async {
            $options.forEach({$0.wrappedValue.1 = $0.wrappedValue.0 == magic.magicSchool})
        }
        return $options
    }
    
    var body: some View {
        List {
            Section {
                ForEach(arrList, id: \.0) {cell in
                    Button {
                        self.magic.magicSchool = cell.wrappedValue.0
                    } label: {
                        HStack {
                            Image(systemName: cell.wrappedValue.1 ? "circle.fill" : "circle")
                            Text("\(cell.wrappedValue.0.rawValue)")
                        }
                        .frame(minWidth: 100, alignment: .leading)
                    }
                }
            } header: {
                Text("Escola")
            }
        }
    }
}

struct LevelListView: View {
    
    @Binding var magic: Magic
    
    @State var options: [(Int, Bool)] = [(0, false), (1, false), (2, false), (3, false), (4, false), (5, false), (6, false), (7, false), (8, false), (9, false)]
    
    var arrList: Binding<[(Int, Bool)]> {
        DispatchQueue.main.async {
            self.$options.forEach({$0.wrappedValue.1 = $0.wrappedValue.0 == magic.level})
        }
        return $options
    }
    
    var body: some View {
        List {
            Section {
                ForEach(arrList, id: \.0) { cell in
                    Button {
                        self.magic.level = cell.wrappedValue.0
                    } label: {
                        HStack {
                            Image(systemName: cell.wrappedValue.1 ? "circle.fill" : "circle")
                            Text("\(cell.wrappedValue.0)")
                        }
                        .frame(minWidth: 30, alignment: .leading)
                    }
                }
            } header: {
                Text("Nível")
            }
        }
    }
}

struct CharClassListView: View {
    
    @Binding var magic: Magic
    
    @State var options: [(CharClass, Bool)] = [(.barbaro, false), (.bardo, false), (.bruxo, false), (.clerigo, false), (.druida, false), (.feiticeiro, false), (.guerreiro, false), (.ladino, false), (.mago, false), (.monge, false), (.paladino, false), (.patrulheiro, false)]
    
    var arrList: Binding<[(CharClass, Bool)]> {
        DispatchQueue.main.async {
            self.$options.forEach({$0.wrappedValue.1 = magic.charClasses.contains($0.wrappedValue.0)})
        }
        return $options
    }
    
    var body: some View {
        List {
            Section {
                ForEach(arrList, id: \.0) { cell in
                    Button {
                        if magic.charClasses.contains(cell.wrappedValue.0) {
                            magic.charClasses.removeAll(where: {$0 == cell.wrappedValue.0})
                        } else {
                            magic.charClasses.append(cell.wrappedValue.0)
                        }
                        magic.charClasses.sort(by: {$0.rawValue < $1.rawValue})
                    } label: {
                        HStack {
                            Image(systemName: cell.wrappedValue.1 ? "circle.fill" : "circle")
                            Text("\(cell.wrappedValue.0.rawValue)")
                        }
                        .frame(minWidth: 100, alignment: .leading)
                    }
                }
            } header: {
                Text("Classes")
            }
        }
    }
}

