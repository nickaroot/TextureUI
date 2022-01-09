//
//  Layout.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct ConditionalContent<TrueContent, FalseContent>: LayoutElement
where TrueContent: LayoutElement, FalseContent: LayoutElement {

    public enum Content {
        case trueContent(TrueContent)
        case falseContent(FalseContent)
    }

    public let content: Content

    init(_ content: Content) { self.content = content }

    public var node: LazySequence<[ASLayoutElement]> {
        switch content {

        case .trueContent(let trueContent):
            return trueContent.node

        case .falseContent(let falseContent):
            return falseContent.node

        }
    }
}

public enum Layout {
    case empty
    case single(_ content: LayoutElement)
    case composite(_ content: [LayoutElement])
}

extension Layout: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        switch self {

        case .empty:
            return ASLayoutSpec().node

        case .single(let element):
            return element.node

        case .composite(let elements):
            return elements.flatMap({ $0.node.elements }).lazy

        }
    }
}
