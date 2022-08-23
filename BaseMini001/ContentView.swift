//
//  ContentView.swift
//  BaseMini001
//
//  Created by Matheus Cavalcanti de Arruda on 20/08/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            
            MagicSettingsView()
                .tabItem {
                    Text("Magias")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
