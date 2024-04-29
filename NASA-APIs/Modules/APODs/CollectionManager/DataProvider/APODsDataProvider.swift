
import Foundation

class APODsDataProvider {
    var dateSelectSection: APODsSection =
        .init(title: "Pick date",
              items: [
                .init(type: .dataSelectItemType(type: .init(type: .today))),
                .init(type: .dataSelectItemType(type: .init(type: .week))),
                .init(type: .dataSelectItemType(type: .init(type: .month))),
                .init(type: .dataSelectItemType(type: .init(type: .year))),
                .init(type: .dataSelectItemType(type: .init(type: .custom))),
              ],
              type: .dataSelectType)

    private(set) var picturesSection: APODsSection =
        .init(title: "",
              items: [
              ],
              type: .pictures)

    func insertPictureSection(with models: [PODsServiceResponseModel]) {
        picturesSection.items = []
        models.forEach {
            guard let url = URL(string: $0.url) else {
                assert(false)
                return
            }
            picturesSection.items.append(.init(type: .imageItemType(type: .init(title: $0.title, imageUrl: url))))
        }
    }

    func selectDate(with item: APODsCellItem, previousItemIndex: IndexPath) {
        guard let itemIndex = dateSelectSection.items.firstIndex(where: { $0.id == item.id }) else { return }
        let item = dateSelectSection.items[itemIndex]
        switch item.type {
        case .dataSelectItemType(type: let type):
            var model = type
            model.selected = true
            let updatableItem = APODsCellItem(
                id: item.id,
                type: .dataSelectItemType(type: model)
            )
            dateSelectSection.items[itemIndex] = updatableItem
            guard previousItemIndex.row < dateSelectSection.items.count else { return }
            let previousItem = dateSelectSection.items[previousItemIndex.row]
            switch previousItem.type {

            case .dataSelectItemType(type: let type):
                var model = type
                model.selected = false
                let updatableItem = APODsCellItem(
                    id: item.id,
                    type: .dataSelectItemType(type: model)
                )
                dateSelectSection.items[previousItemIndex.row] = updatableItem
            case .imageItemType:
                break
            }

        case .imageItemType:
            break
        }
    }
}
