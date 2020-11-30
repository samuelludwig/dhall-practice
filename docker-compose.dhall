let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Map/Type

let types = ./docker-compose-types.dhall

let version : Text = "3.5"

let makeNetwork
    : Text -> types.Network
    = \(networkName : Text) -> { driver = "bridge", name = networkName}

let logOpts
    = { logging
        = { options
            = { max_size = "5m"
              , max_file = types.StringOrNumber.String "5"
              }
          }
      }

let testNetwork = makeNetwork "test-net"
let prodNetwork = makeNetwork "prod-net"

let networkList
    = [ { mapKey = "test-network", mapValue = testNetwork }
      , { mapKey = "prod-network", mapValue = prodNetwork }
      ]

let environment_vars
    = types.ListOrDict.Dict
      [ { mapKey = "HOME", mapValue = "/home/my_user" }
      , { mapKey = "DATABASE_NAME", mapValue = "database" }
      ]

let myService
    : types.Service
    = { container_name = Some "my_container"
      , image = "my_image"
      , build = Some { context = "./", dockerfile = "Dockerfile" }
      , restart = Some "always"
      , logging = Some logOpts
      , tty = Some True
      , ports = Some [ types.StringOrNumber.String "80:80" ]
      , volumes = None types.VolumesList
      , environment = Some environment_vars
      , working_dir = Some "/app"
      , networks = None (List types.StringOrNumber)
      }

let services
    : types.ServiceList
    = [{ mapKey = "my-service", mapValue = myService }]

let compose_file
    : types.ComposeFile
    = { version = version
      , services = Some services
      , networks = Some networkList
      }

in compose_file
