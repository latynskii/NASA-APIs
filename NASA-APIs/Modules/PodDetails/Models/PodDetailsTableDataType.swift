
import Foundation

enum PodDetailsTableDataType {
    case image(imageData: PodDetailsTableDataTypeImageData)
    case space
    case text(textData: PodDetailsTableDataTypeTextData)
}

struct PodDetailsTableDataTypeImageData {
    let url: URL?
}

struct PodDetailsTableDataTypeTextData {
    let title: String
    let subtitle: String
}
