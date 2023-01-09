//
//  ZStack.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct ZStack<Content> where Content: LayoutElement {

    public var layoutElement: ASLayoutElement

    public init(
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = content().layoutElement
    }

    public init(
        content: Content
    ) {
        self.layoutElement = content.layoutElement
    }
}

extension ZStack: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [
            layoutElement
        ].lazy
    }
    
    public var style: ASLayoutElementStyle {
        layoutElement.style
    }
}

public typealias WrapperSpec = ZStack
