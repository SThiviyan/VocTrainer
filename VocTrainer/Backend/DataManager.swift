//
//  DataManager.swift
//  VocTrainer
//
//  Created by Thiviyan Saravanamuthu on 14.11.20.
//

import Foundation


public class DataManager
{
    
    
    
   //get Document Directory
    static fileprivate func getDocumentsDirectory () -> URL
    {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        }
        else
        {
            fatalError("Unable to acces Directory")
        }
        
    }
    
    static func save <T: Encodable>(_ object:T, with fileName: String)
    {
        let Url = getDocumentsDirectory().appendingPathComponent(fileName, isDirectory: false)
        
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(object)
            
            if FileManager.default.fileExists(atPath: Url.path)
            {
                try FileManager.default.removeItem(at: Url)
            }
            
            FileManager.default.createFile(atPath: Url.path, contents: data, attributes: nil)
            
        } catch  {
            fatalError(error.localizedDescription)
        }
        
    }
    
    
    static func load <T:Decodable> (_ fileName:String, with type:T.Type) -> T {
         let url = getDocumentsDirectory().appendingPathComponent(fileName, isDirectory: false)
         if !FileManager.default.fileExists(atPath: url.path) {
             fatalError("File not found at path \(url.path)")
         }
         
         if let data = FileManager.default.contents(atPath: url.path) {
             do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
             }catch{
                 fatalError(error.localizedDescription)
             }
             
         }else{
             fatalError("Data unavailable at path \(url.path)")
         }
         
     }
    
    
    static func loadData (_ fileName: String) -> Data?
    {
        let url = getDocumentsDirectory().appendingPathComponent(fileName, isDirectory: false)
        if !FileManager.default.fileExists(atPath: url.path)
        {
            fatalError("File not found at path \(url.path)")
        }
        
        
        if let data = FileManager.default.contents(atPath: url.path)
        {
            do{
                return data
            }
            catch
            {
                fatalError(error.localizedDescription)
            }
            
        }
        else
        {
            fatalError("Data unavailable at path \(url.path)")
        }
        
    }
     
    static func LoadAll <T: Decodable> (_ type: T.Type) -> [T]
    {
        do
        {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentsDirectory().path)
            
            var modelObjects = [T]()
            
            for fileName in files
            {
                modelObjects.append(load(fileName, with: type))
            }
            
            return modelObjects
            
        }
        catch
        {
            fatalError("could not load any files")
        }
    }
    
    static func GetTotalNum <T: Decodable>(_ type: T.Type) -> Int
    {
        do
        {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentsDirectory().path)
            
            var modelObjects = [T]()
            
            for fileName in files
            {
                modelObjects.append(load(fileName, with: type))
            }
            
            
            return modelObjects.count
            
        }
        catch
        {
            fatalError("could not return Num")
        }
    }
    
    static func delete (_ fileName:String) {
           let url = getDocumentsDirectory().appendingPathComponent(fileName, isDirectory: false)
           
           if FileManager.default.fileExists(atPath: url.path) {
               do {
                   try FileManager.default.removeItem(at: url)
               }catch{
                   fatalError(error.localizedDescription)
               }
           }
       }
    
  
}

