//
//  GenericStore.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 13/04/23.

/*  para realizar a função de request para o interactor, precisamos antes declarar uma váriavel error
    com a sua classe Error de leitura e escrita { get e set } e precisamos também de um completion que é genérico <T>
    que tem dois parametros depois da = que é o result que passa o tipo genérico e um failure passa a classe Error opcional
    pois podemos ou não ter erros, ou seja (_ result: T, _ failure: Error?) retornando o typealias como void: -> Void
 */

import Foundation

protocol GerericStoreProtocol {
    var error: Error { get set }
    typealias completion<T> = (_ result: T, _ failure: Error?) -> Void
}

//classe do request para o interactor

class GenericStoreRequest: GerericStoreProtocol {
    
    // declarando a variavel error para tratativa de erro, informações sobre uma condição de erro
    // https://developer.apple.com/documentation/foundation/nserror
    // do classe NSerror, que passa o dominio, o código do erro em Int, depois o user info que é uma descrição do erro se utilizada
    // assim userInfo: [NSLocalizedDescriptionKey: "Error codding"] ao final da variavel falamos que ela é to tipo Error, com as Error
    // igual quando declaramos no GenericStoreProtocol
    
    var error = NSError(domain:"", code: 901 , userInfo: [NSLocalizedDescriptionKey: "Error codding"]) as Error
    // BUSCA HTTP ASSINCRONA
    func request<T: Codable>(url: URL, completion: @escaping completion<T?>){
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                return completion(nil, self.error)
            }
            
            if let error = error {
                return completion(nil, error)
            }
            
            //aqui estamos fazendo uma função para fazer o parse do que recebemos do que recebemos que é o data, para o T, e realizar o
            // JSONdecoder
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(object, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        
        //Aqui ele está dando um resume() na variável task, depois de toda as validações e do JSONdecoder
        task.resume()
    }
    
    
}




