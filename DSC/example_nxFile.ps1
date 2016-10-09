#. .\example_nxFile.ps1
#example_nxFile -ComputerName 'MyTestNode'
#-OutputPath:"C:\temp"

Configuration example_nxFile {
  param(
      [string[]]$ComputerName="localhost"
  )
  Import-DscResource -Module nx
  Node $ComputerName {
    nxFile ExampleFile {
      DestinationPath = "/tmp/example"
      Contents = "hello world `n"
      Ensure = "Present"
      Type = "File"
    }
  }
}
