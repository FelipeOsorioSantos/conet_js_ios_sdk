import Foundation
import JavaScriptCore

public class ConetClass {
    static public let shared = ConetClass()
    private let vm = JSVirtualMachine()
    private let context: JSContext
    
    public init() {
        
        guard let bundle = Bundle(for: ConetClass.self).url(forResource: "Conet", withExtension: "bundle.js") else {
            fatalError("Bundle not found.")
        }
        
        do {
            let jsCode = try String(contentsOf: bundle)
            print("js loaded: \(jsCode)")
            
            
            context = JSContext(virtualMachine: vm)
            
            
            context.evaluateScript(jsCode)
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    public func analyze() async -> String {
        guard let jsModule = self.context.objectForKeyedSubscript("Conet") else {
            print("Error: Module not found")
            return "Error: Module not found"
        }
        
        guard let jsFunction = jsModule.objectForKeyedSubscript("createPhrase") else {
            print("Error: Function not found in module")
            return "Error: Function not found in module"
        }
        
        print("jsFunction >>>", jsFunction)
        
        if let result = jsFunction.call(withArguments: []) {
            if result.isUndefined {
                print("Error: Function returned undefined")
                return "Error: Function returned undefined"
            }
            let phrase = result.toString()
            print("result", phrase)
            return phrase!
        } else {
            print("Error: Function call returned nil")
            return "Error: Function call returned nil"
        }
    }

}
