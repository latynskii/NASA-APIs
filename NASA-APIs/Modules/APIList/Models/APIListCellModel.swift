
import Foundation

enum APIListCellType {
    case apods
    case asteroids
}


struct APIListCellModel {
    let title: String
    let type: APIListCellType
}
