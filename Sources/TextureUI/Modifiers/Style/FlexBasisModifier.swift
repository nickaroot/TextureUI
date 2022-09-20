//
//  FlexBasisModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct FlexBasisModifier<Content>: LayoutStyleModifier where Content: LayoutElement {

    public let flexBasis: ASDimension

    public init(
        flexBasis: ASDimension
    ) {
        self.flexBasis = flexBasis
    }

    public func modify(content: Content) -> LayoutElement {
        content.style.flexBasis = flexBasis

        return content
    }
}

extension LayoutElement {
    public func flexBasis(_ value: ASDimension) -> some LayoutElement {
        modifier(FlexBasisModifier<Self>(flexBasis: value))
    }
}
