//
//  Magic.swift
//  BaseMini001
//
//  Created by Matheus Cavalcanti de Arruda on 20/08/22.
//

import Foundation

enum CharClass: String, Codable, Hashable {
    case barbaro = "Bárbaro"
    case bardo = "Bardo"
    case bruxo = "Bruxo"
    case clerigo = "Clérigo"
    case druida = "Druida"
    case feiticeiro = "Feiticeiro"
    case guerreiro = "Guerreiro"
    case ladino = "Ladino"
    case mago = "Mago"
    case monge = "Monge"
    case paladino = "Paladino"
    case patrulheiro = "Patrulheiro"
}

enum MagicSchool: String, Codable, Hashable {
    case abjuracao = "Abjuração"
    case adivinhacao = "Adivinhação"
    case conjuracao = "Conjuração"
    case encantamento = "Encantamento"
    case evocacao = "Evocação"
    case ilusao = "Ilusão"
    case necromancia = "Necromancia"
    case transmutacao = "Transmutação"
}

struct Magic: Codable, Hashable {
    var id: Int
    var name: String
    var level: Int
    var charClasses: [CharClass]
    var magicSchool: MagicSchool
    var ritual: Bool
    var time: String
    var range: String
    var components: String
    var duration: String
    var description: String
    
    var describing: String {
        return "ID: \(id)\nNAME: \(name)\nLEVEL: \(level)\nCLASSE: \(MagicUtils.charClassFormatter(arr: charClasses))\nSCHOOL: \(magicSchool.rawValue)\nRITUAL: \(ritual)\nTIME: \(time)\nRANGE: \(range)\nCOMPONENTS: \(components)\nDURATION: \(duration)\nDESCRIPTION: \(description)"
    }
}

struct MagicJSON: Codable {
    var id: Int
    var nome: String
    var nivel: Int
    var ritual: Bool
    var classes: [String]
    var escola: String
    var tempo: String
    var alcance: String
    var componentes: String
    var duracao: String
    var descricao: String
}
