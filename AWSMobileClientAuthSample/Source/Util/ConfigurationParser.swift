//
//  ConfigurationParser.swift
//  AWSMobileClientAuthSample
//
//  Created by Roy, Jithin on 1/25/20.
//  Copyright © 2020 Amazon Web Services. All rights reserved.
//

import Foundation

struct ConfigurationParser {

    static func fetchConfiguration(for authType: AuthType) -> [String: Any] {
        let configurationFileName = getFileName(for: authType)
        guard let path = Bundle.main.url(forResource: configurationFileName, withExtension: "json") else {
            print("Configuration file is missing")
            return [:]
        }

        do {
            let fileContent = try Data(contentsOf: path)
            return  parseConfigurationData(fileContent) ?? [:]
        } catch {
            print("Unexpected error: \(error).")
        }
        return [:]
    }

    static func parseConfigurationData(_ data: Data) -> [String: Any]? {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
            print("Json parsing failed")
            return nil
        }
        guard let configurationJson = json as? [String: Any] else {
            print("Configuration file is not in the format [String: Any]")
            return nil
        }
        return configurationJson
    }

    static func getFileName(for authType: AuthType) -> String {
        switch authType {
        case .userpool:
            return "userPoolConfiguration"
        case .dropInUI:
            return "dropInUIConfiguration"
        case .customAuthUserPool:
            return "customAuthUserPoolConfiguration"
        }

    }
}
