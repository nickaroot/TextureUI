//
//  ZStack.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct ZStack<Content> where Content: LayoutElement {

    public let content: Content

    public init(
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.content = content()
    }

    public init(
        content: Content
    ) {
        self.content = content
    }
}

extension ZStack: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [content.layoutElement].lazy
    }
}

public typealias WrapperSpec = ZStack
