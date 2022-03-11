//
//  Interactor.swift
//  CryptoProject
//
//  Created by Chetan Patil on 11/03/22.
//

import Foundation

protocol AnyInteractor{
    var presenter:AnyPresenter?{get set}
    
    func downloadCryptos()
}

class CryptoInteractor:AnyInteractor{
    
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json")else{
            return
        }
   // https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, response, error in
            
            guard let data = data, error==nil else{
                self?.presenter?.interactorDidDownloadCryptos(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do{
                let cryptos=try JSONDecoder().decode([Crypto].self,from: data)
                
                self?.presenter?.interactorDidDownloadCryptos(result: .success(cryptos))
                
            }catch{
                self?.presenter?.interactorDidDownloadCryptos(result: .failure(NetworkError.ParsingFailed))

            }
        }
        task.resume()
    }
    
    
}
