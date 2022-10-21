//
//  Magic.swift
//  BaseMini001
//
//  Created by Matheus Cavalcanti de Arruda on 20/08/22.
//

import Foundation

public enum CharClass: String, Codable, Hashable {
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

public enum MagicSchool: String, Codable, Hashable {
    case abjuracao = "Abjuração"
    case adivinhacao = "Adivinhação"
    case conjuracao = "Conjuração"
    case encantamento = "Encantamento"
    case evocacao = "Evocação"
    case ilusao = "Ilusão"
    case necromancia = "Necromancia"
    case transmutacao = "Transmutação"
}

public struct Magic: Codable, Hashable {
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

public struct MagicJSON: Codable {
    public var id: Int
    public var nome: String
    public var nivel: Int
    public var classes: [CharClass]
    public var escola: MagicSchool
    public var ritual: Bool
    public var tempoConjuracao: String
    public var alcance: String
    public var componentes: String
    public var duracao: String
    public var descricao: String
}
