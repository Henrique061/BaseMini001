//
//  MagicSettingsView.swift
//  BaseMini001
//
//  Created by Matheus Cavalcanti de Arruda on 20/08/22.
//

import SwiftUI

struct MagicSettingsView: View {
    @State var magics: [Magic] = []
    @State var arrList: [Magic] = []
    @State var magic: Magic = Magic(id: 1000, name: "ALGUM", level: 0, charClasses: [], magicSchool: .abjuracao, ritual: false, time: "", range: "", components: "", duration: "", description: "")
    @State var didAppear: Bool = false
    
    @State var savedMagicAlert: Bool = false
    @State var saveMagicFailAlert: Bool = false
    
    
    var body: some View {
        VStack {
            HStack {
                EditMagicView(magic: $magic)
                MagicListView(magicArr: $magics, arrList: $arrList) { m in
                    self.magic = m
                }
            }
            HStack {
                Button {
                    if MagicUtils.save(magic: magic) {
                        savedMagicAlert.toggle()
                        magics = MagicUtils.fetch()
                    } else {
                        saveMagicFailAlert.toggle()
                    }
                } label: {
                    Text("SALVAR MAGIA")
                        .padding()
                }
                
                Button {
                    if MagicUtils.createNewMagic(magic: magic) {
                        savedMagicAlert.toggle()
                        magics = MagicUtils.fetch()
                    } else {
                        saveMagicFailAlert.toggle()
                    }
                } label: {
                    Text("CRIAR MAGIA")
                        .padding()
                }
            }.padding()
            
        }
        
        .onAppear(perform: onLoad)
        
        .alert("Arquivo salvo com sucesso.", isPresented: $savedMagicAlert){ Button("Ok", role: .cancel){}}
        
        .alert("Falha ao tentar salvar o arquivo.", isPresented: $saveMagicFailAlert){Button("OK", role: .cancel){}}
    }
    
    public func onLoad() {
        if !didAppear {
            self.magics = MagicUtils.fetch()
            self.arrList = magics
        }
        didAppear = true
    }
}

struct MagicSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        MagicSettingsView()
    }
}
