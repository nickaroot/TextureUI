//
//  ASDimension.swift
//
//
//  Created by Nikita Arutyunov on 07.03.2022.
//

import AsyncDisplayKit

extension ASDimension {
    public static func fraction(_ value: CGFloat) -> Self {
        Self(unit: .fraction, value: value)
    }

    public static func points(_ value: CGFloat) -> Self {
        Self(unit: .points, value: value)
    }

    public static var auto: Self {
        Self(unit: .auto, value: 0)
    }
}

extension ASDimension: ExpressibleByIntegerLiteral {
    public init(
        integerLiteral value: IntegerLiteralType
    ) {
        self.init(unit: .points, value: CGFloat(value))
    }
}

extension ASDimension: ExpressibleByFloatLiteral {
    public init(
        floatLiteral value: FloatLiteralType
    ) {
        self.init(unit: .points, value: CGFloat(value))
    }
}
