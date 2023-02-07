//
//  Spacer.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct Spacer {

    public var layoutElement: ASLayoutElement

    public init(
        minLength: CGFloat = 0,
        flexGrow: CGFloat = 1
    ) {
        self.layoutElement = ASLayoutSpec()
            .styled { [minLength, flexGrow] style in
                style.spacingBefore = minLength
                style.flexGrow = flexGrow
            }
    }
}

extension Spacer: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [
            layoutElement
        ]
        .lazy
    }

    public var style: ASLayoutElementStyle {
        layoutElement.style
    }
}
