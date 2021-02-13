//
//  NetworkManager.swift
//  KurralUI
//
//  Created by M_243704 on 2/4/21.
//

import Foundation

protocol DatasourceDelegate: class {
    func didSelectGoToMainMenu()
}

protocol AdikaramManagerDelegate: class {
    func didUpdate(adikaram: Array<Adikaram>)
    func didFailWithError(error: Error)
    func didUpdateKurralList(kurralList: Array<KurralList>)
    func didFailKurralWithError(error: Error)
}


struct NetworkManager {

//    var adikaramList = [Adikaram]()
    
    var delegate: AdikaramManagerDelegate?
    var dataSource: DatasourceDelegate?
    
    func fetchAdikaram(){
            if let url = URL(string: "https://api.mythirukurral.com/thirukurral/adikaram") {
                let headers = [
                    "x-api-key": "b2uz54VCfa5adH5YFDkmL73IWwJBEwUw4rk7TWGp"
                ]

                let config = URLSessionConfiguration.default
                config.httpAdditionalHeaders = headers
                
                let session = URLSession(configuration: config)
                
                
                let task = session.dataTask(with: url) {
                    (data, response, error) in
                    if error == nil {
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let results = try decoder.decode([Adikaram].self, from: safeData)
                                self.delegate?.didUpdate(adikaram: results)
                            } catch  {
                                print(error)
                            }
                        }
                    }
                }

                task.resume()
            }
    }
    
    func fetchKurraList(beginIndex:Int, endIndex:Int){

        let urlLnk:String = "https://api.mythirukurral.com/thirukurral/getKurralListByIndex?beginIndex=\(beginIndex)&endIndex=\(endIndex)"
        
//        urlLnk = urlLnk+""
        print(urlLnk)
        
        
        if let kurralUrl = URL(string: urlLnk) {
            print("Arun")
            let headers = [
                "x-api-key": "b2uz54VCfa5adH5YFDkmL73IWwJBEwUw4rk7TWGp"
            ]
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = headers

            let session = URLSession(configuration: config)

            let task = session.dataTask(with: kurralUrl) {
                (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode([KurralList].self, from: safeData)
                            self.delegate?.didUpdateKurralList(kurralList: results)
                            self.dataSource?.didSelectGoToMainMenu()
                        } catch  {
                            print(error)
                        }
                    }
                }
            }

            task.resume()

        }else{
            print("Aruns")
        }
    }
}
