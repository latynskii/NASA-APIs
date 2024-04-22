
import Foundation

struct APODsSection: Identifiable, Hashable {
    let id = UUID()
    let title: String
    var items: [APODsCellItem]
    let type: APODsSectionType
}

enum APODsSectionType: Int {
    case dataSelectType
    case pictures
}
