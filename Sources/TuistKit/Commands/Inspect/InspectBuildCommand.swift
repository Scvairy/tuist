import ArgumentParser
import TuistSupport
import FileSystem

struct InspectBuildCommand: AsyncParsableCommand {
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "build",
            abstract: "Inspects the latest build."
        )
    }

//    @Option(
//        name: .shortAndLong,
//        help: "The path to the directory that contains the project.",
//        completion: .directory,
//        envKey: .lintImplicitDependenciesPath
//    )
//    var path: String?

    func run() async throws {
        try await InspectBuildService()
            .run()
    }
}

struct InspectBuildService {
    private let environment: Environmenting
    private let derivedDataLocator: DerivedDataLocating
    private let fileSystem: FileSysteming
    
    init(
        environment: Environmenting = Environment.shared,
        derivedDataLocator: DerivedDataLocating = DerivedDataLocator(),
        fileSystem: FileSysteming = FileSystem()
    ) {
        self.environment = environment
        self.derivedDataLocator = derivedDataLocator
        self.fileSystem = fileSystem
    }
    
    func run() async throws {
        let workspacePath = environment.workspacePath!
        let buildLogsPath = try derivedDataLocator.locate(for: workspacePath.parentDirectory)
            .appending(components: "Logs", "Build")
        let plist = try await fileSystem.readPlistFile(at: buildLogsPath.appending(component: "LogStoreManifest.plist"))
        
    }
}
