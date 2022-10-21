//
//  MagicUtils.swift
//  BaseMini001
//
//  Created by Matheus Cavalcanti de Arruda on 20/08/22.
//

import Foundation
import SwiftUI

class MagicUtils {
        
    public static var folderPath: String {
    FileManager.default.homeDirectoryForCurrentUser
        .appendingPathComponent("SystemData")
        .appendingPathComponent("magias").path
    }
    
    public static func save(magic: Magic) -> Bool {
        let formattedFileName = formatFileName(file: magic.id)
        let arr = getMagicFilesName()
        if arr.contains(formattedFileName + ".json") {
            return updateFile(magic: magic, file: FileEditor.getFileDir(file: formattedFileName))
        }
        return false
    }
    
    public static func createNewMagic(magic: Magic) -> Bool {
        let lastIndex = getMagicFilesName().count
        let formattedFileName = formatFileName(file: lastIndex + 1)
        let path = URL(string: folderPath)!.appendingPathComponent(formattedFileName).appendingPathExtension("json")
        var newMagic = magic
        newMagic.id = lastIndex
        
        if let data = encode(magic: newMagic) {
            return FileEditor.createFile(data: data, file: path.path)
        } else { return false }
        
    }
    
    private static func newFile(magic: Magic, file name: String, id: Int) -> Bool {
        var aux = magic
        aux.id = id
        guard let data = encode(magic: aux) else { return false }
        return FileEditor.createFile(data: data, file: name)
    }
    
    private static func updateFile(magic: Magic, file name: URL) -> Bool {
        guard let data = encode(magic: magic) else { return false }
        return FileEditor.writeContentInFile(data: data, file: name)
    }
    
    public static func deleteMagic(magic: Magic) -> Bool {
        return FileEditor.deleteFile(file: FileEditor.getFileDir(file: formatFileName(file: magic.id)))
    }
    
    private static func formatFileName(file: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumIntegerDigits = 3
        return "magia-\(numberFormatter.string(from: NSNumber(value: file)) ?? "Error")"
    }
    
    private static func getMagicFilesName() -> [String] {
        var arr: [String] = []
        
        do {
            arr = try FileManager.default.contentsOfDirectory(atPath: folderPath)
        } catch {
            print("Unable to read files from dir \(folderPath)")
        }
        
        return arr
    }
    
    public static func fetchWithFilter(searchTxt: String) -> [Magic] {
        let treatedSearch = formatFileName(file: Int(searchTxt) ?? 0)
        let arr: [String] = getMagicFilesName().filter({$0.contains(treatedSearch)})
        var magics: [Magic] = []
        for i in arr {
            let filePath = ("\(folderPath)/\(i)")
            if let content = FileEditor.getFileContent(file: filePath) {
                magics.append(decode(data: content))
            }
        }
        return magics
    }
    
    public static func fetch() -> [Magic] {
        
        let arr = getMagicFilesName()
        
        var magics: [Magic] = []
        
        for i in arr {
            if i == ".DS_Store" { continue }
            let filePath = ("\(folderPath)/\(i)")
            if let content = FileEditor.getFileContent(file: filePath) {
                let decodedData = decode(data: content)
                if decodedData.id == -100 {print(i)}
                magics.append(decodedData)
            }
        }
        
        return magics.sorted(by: {$0.name < $1.name})
    }
    
    public static func charClassFormatter(arr: [CharClass]) -> String {
        var str = ""
        for i in 0..<arr.count {
            str += arr[i].rawValue
            str += i < (arr.count - 1) ? ", " : ""
        }
        return "\(str)"
    }
    
    private static func decode(data: Data) -> Magic {
        do {
            let json = try JSONDecoder().decode(MagicJSON.self, from: data)
            return Magic(id: json.id, name: json.nome, level: json.nivel, charClasses: json.classes, magicSchool: json.escola, ritual: json.ritual, time: json.tempoConjuracao, range: json.alcance, components: json.componentes, duration: json.duracao, description: json.descricao)
        } catch {
            return Magic(id: -100, name: "ERROR", level: 0, charClasses: [], magicSchool: .abjuracao, ritual: false, time: "ERROR", range: "ERROR", components: "ERROR", duration: "ERROR", description: "ERROR")
        }
    }
    
    private static func encode(magic: Magic) -> Data? {
        do {
            let json = MagicJSON(id: magic.id, nome: magic.name, nivel: magic.level, classes: magic.charClasses, escola: magic.magicSchool, ritual: magic.ritual, tempoConjuracao: magic.time, alcance: magic.range, componentes: magic.components, duracao: magic.duration, descricao: magic.description)
            return try JSONEncoder().encode(json)
        } catch {
            return nil
        }
    }
}
