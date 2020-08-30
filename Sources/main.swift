
import Foundation
import Vapor
import FluentPostgresDriver
import GraphZahl
import GraphZahlVaporSupport
import GraphZahlFluentSupport

let app = Application()
//let tlsConfig = TLSConfiguration(
//let postgresConfig = PostgresConfiguration(hostname: "badger-db-staging-do-user-6391433-0.a.db.ondigitalocean.com", port: 25060, username: "doadmin", password: "lnv7j08r3el9bybz", database: "defaultdb", tlsConfiguration: TLSConfiguration())
//let databaseConfigFactory = DatabaseConfigurationFactory.postgres(configuration: postgresConfig)
//app.databases.use(databaseConfigFactory, as: .psql)
//try app.databases.use(.postgres(url: "postgresql://doadmin:lnv7j08r3el9bybz@badger-db-staging-do-user-6391433-0.a.db.ondigitalocean.com:25060/defaultdb?sslmode=require"), as: .psql)
print("HEllo")

let cert = try NIOSSLCertificate(file: "/Users/sam/Projects/Badger/server/ca-certificate.pem", format: .pem)
print("Hehhhh")
let dbHostname = "badger-db-staging-do-user-6391433-0.a.db.ondigitalocean.com"
let dbPort = 25060
let dbUsername = "doadmin"
let dbPassword = "lnv7j08r3el9bybz"
let database = "defaultdb"

print("Got here")
let databaseConfig = PostgresConfiguration(hostname: dbHostname, port: dbPort, username: dbUsername, password: dbPassword, database: database, tlsConfiguration: .forClient(trustRoots: .certificates([cert])))

print(cert)
app.databases.use(.postgres(configuration: databaseConfig), as: .psql)

app.migrations.add(User.Migration())
app.migrations.add(Todo.Migration())

try app.autoMigrate().wait()
app.routes.graphql(use: API.self, includeGraphiQL: true) { $0.db }
try app.run()

