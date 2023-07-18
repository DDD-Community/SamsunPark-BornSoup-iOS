//
//  Scripts.swift
//  Config
//
//  Created by 고병학 on 2023/01/25.
//

import ProjectDescription

let swiftLintScript: String = """
if test -d "/opt/homebrew/bin/"; then
    PATH="/opt/homebrew/bin/:${PATH}"
fi

export PATH

if which swiftlint > /dev/null; then
    swiftlint
else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
"""

public extension TargetScript {
    static let SwiftLintString = TargetScript.pre(
        script: swiftLintScript,
        name: "SwiftLintString"
    )
}

