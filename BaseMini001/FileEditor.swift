//
//  FileEditor.swift
//  BaseMini001
//
//  Created by Matheus Cavalcanti de Arruda on 20/08/22.
//

import Foundation

class FileEditor {
    
    public static func getFileDir(file name: String) -> String {
        
        let fileDir = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("SystemData")
            .appendingPathComponent("magias")
            .appendingPathComponent(name)
            .appendingPathExtension("json")
        
        return fileDir.path
    }
    
    public static func getFileDir(file name: String) -> URL {
        
        let fileDir = FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("SystemData")
            .appendingPathComponent("magias")
            .appendingPathComponent(name)
            .appendingPathExtension("json")
        
        return fileDir
    }
    
    public static func getFileContent(file: String) -> Data? {
        return FileManager.default.contents(atPath: file)
    }
    
    public static func writeContentInFile(data: Data, file: URL?) -> Bool {
        if let path = file {
            do {
                try data.write(to: path)
                return true
            } catch {
                return false
            }
        }
        return false
    }
    
    public static func createFile(data: Data, file: String) -> Bool {
        
        return FileManager.default.createFile(atPath: file, contents: data)
    }
    
    public static func deleteFile(file: String) -> Bool {
        do {
            try FileManager.default.removeItem(atPath: file)
            return true
        } catch {
            return false
        }
    }
}
