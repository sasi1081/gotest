/*
#!/usr/bin/env groovy

folder('go')
folder('go/aws_eks')

pipelineJob(' ') {

desc ('')

logRotator {

  numToKeep(30)
  
  }
  
  parameters {
  
  choiceParam('')
  stringParam('')
  }
  
  definition {
  
  cpsScm {
  
  scm{
  
  git{
  
  remote{
  
  url(' https://github.com/sasi1081/gotest.git')
  credentials('GITHUB_PRIVATE_KEY')
  }
  
  branch ('main')
  }
  scriptPath('')
  }
  }
  }
  }
  
  */
