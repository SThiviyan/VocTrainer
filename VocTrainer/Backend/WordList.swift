//
//  WordList.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 07.11.20.
//

import Foundation


struct WordList: Codable
{
    
    public var name: String
    public var TimeAdded: Date
    public var LanguageOne: String
    public var LanguageTwo: String
    public var WordsLanguageOne: [String]
    public var WordsLanguageTwo: [String]
    
    func SaveItem()
    {
        DataManager.save(self, with: name)
    }
    
    func deleteItem()
    {
        DataManager.delete(name)
    }
    
    
}

struct ListItem: Hashable
{
    var name: String
    var TimeAdded: Date
    var LanguageOne: String
    var LanguageTwo: String
    var LanguageOneList: [String]
    var LanguageTwoList: [String]
    
}
