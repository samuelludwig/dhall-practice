let Map =
      https://raw.githubusercontent.com/dhall-lang/dhall-lang/master/Prelude/Map/Type

let StringOrNumber : Type = < String : Text | Number : Natural >

let ListOrDict
    : Type
    = < Dict : Map Text Text | List : List (Optional StringOrNumber) >

let BuildClause
    : Type
    = { context : Text
      , dockerfile : Text
      }

let LoggingOptions
    : Type
    = { logging
      : { options : { max_size : Text, max_file : StringOrNumber } }
      }

let PortsList = (List StringOrNumber)

let VolumesList = (List Text)

let Service
    : Type
    = { container_name : Optional Text
      , image : Text
      , build : Optional BuildClause
      , restart : Optional Text
      , logging : Optional LoggingOptions
      , tty : Optional Bool
      , ports : Optional PortsList
      , volumes : Optional VolumesList
      , environment : Optional ListOrDict
      , working_dir : Optional Text
      , networks : Optional (List StringOrNumber)
      }

let ServiceList : Type = Map Text Service

let Network : Type = { driver : Text, name : Text }

let NetworkList : Type = Map Text Network

let ComposeFile
    : Type
    = { version : Text
      , services : Optional ServiceList
      , networks : Optional NetworkList
      }

in { ComposeFile = ComposeFile
   , StringOrNumber = StringOrNumber
   , ListOrDict = ListOrDict
   , BuildClause = BuildClause
   , PortsList = PortsList
   , VolumesList = VolumesList
   , Service = Service
   , ServiceList = ServiceList
   , Network = Network
   , NetworkList = NetworkList
   , LoggingOptions = LoggingOptions
   }
