import Foundation

struct LikeService {
    private var endpoint: RestClient<Like>
    init() {
        endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts")
    }
    func createLike(postId:Int, completion: ((Result<Like?, Error>) -> Void)? = nil ) {
        let identifier = "\(postId)/likes"
        endpoint.createNoModel(identifier){
            result in
            completion?(result)
        }
    }
    func deleteLike(postId:Int, completion: ((Result<Like?, Error>) -> Void)? = nil ) {
        let identifier = "\(postId)/likes"
        endpoint.delete(identifier){
            result in
            completion?(result)
        }
    }
    
}

