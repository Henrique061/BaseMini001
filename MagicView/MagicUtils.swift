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
        let formattedFileName = formatFileName(file: magic.name)
        let arr = getMagicFilesName()
        if arr.contains(formattedFileName) {
            return updateFile(magic: magic, file: FileEditor.getFileDir(file: formattedFileName))
        }
        return newFile(magic: magic, file: FileEditor.getFileDir(file: formattedFileName), id: arr.count + 1)
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
        return FileEditor.deleteFile(file: FileEditor.getFileDir(file: formatFileName(file: magic.name)))
    }
    
    private static func formatFileName(file: String) -> String {
        return "\(file.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "/", with: "-").replacingOccurrences(of: " ", with: "-"))"
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
        let treatedSearch = formatFileName(file: searchTxt)
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
            return try JSONDecoder().decode(Magic.self, from: data)
        } catch {
            return Magic(id: -100, name: "ERROR", level: 0, charClasses: [], magicSchool: .abjuracao, ritual: false, time: "ERROR", range: "ERROR", components: "ERROR", duration: "ERROR", description: "ERROR")
        }
    }
    
    private static func encode(magic: Magic) -> Data? {
        do {
            return try JSONEncoder().encode(magic)
        } catch {
            return nil
        }
    }
}
