
import Foundation
import Vapor
import FluentPostgresDriver
import GraphZahl
import GraphZahlVaporSupport
import GraphZahlFluentSupport

let app = Application()


print("HEllo")

let cert = try NIOSSLCertificate(file: "", format: .pem)
print("Hehhhh")
let dbHostname = ""
let dbPort = 25060
let dbUsername = ""
let dbPassword = ""
let database = ""

print("Got here")
let databaseConfig = PostgresConfiguration(hostname: dbHostname, port: dbPort, username: dbUsername, password: dbPassword, database: database, tlsConfiguration: .forClient(trustRoots: .certificates([cert])))

print(cert)
app.databases.use(.postgres(configuration: databaseConfig), as: .psql)

app.migrations.add(User.Migration())
app.migrations.add(Todo.Migration())

try app.autoMigrate().wait()
app.routes.graphql(use: API.self, includeGraphiQL: true) { $0.db }
try app.run()

