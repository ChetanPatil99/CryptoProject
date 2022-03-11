//
//  Presenter.swift
//  CryptoProject
//
//  Created by Chetan Patil on 11/03/22.
//

import Foundation

enum NetworkError:Error{
    case NetworkFailed
    case ParsingFailed
}
protocol AnyPresenter{
    var router:AnyRouter?{get set}
    var interactor:AnyInteractor?{get set}
    var view:AnyView?{get set}
    
    func interactorDidDownloadCryptos(result:Result<[Crypto],Error>)
}

class CryptoPresenter:AnyPresenter{
     
    var router: AnyRouter?
    
    var interactor: AnyInteractor?{
        didSet{
            interactor?.downloadCryptos()
        }
    }
    
    var view: AnyView?
    
    func interactorDidDownloadCryptos(result:Result<[Crypto],Error>){
        switch result{
        case .success(let cryptos):
            view?.update(with: cryptos)
            //view update
        case .failure(_):
            //view.update error
            view?.update(with: "Try again Later")
        }
    }
}
