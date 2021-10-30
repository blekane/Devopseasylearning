
## Get var name from the share Library
```groovy
@Library("pipeline-shared-lib") _

pipeline {
    agent any
    stages{
        stage('Build'){
            steps{
                script{
                    swissknife.printName 'John'
                }
            }         
        }
    }
   
}
```

## Call the dev branch of the GP
```groovy
@Library("pipeline-shared-lib@dev") _

pipeline {
    agent any
    stages{
        stage('Build'){
            steps{
                script{
                    swissknife.printName 'John'
                }
            }         
        }
    }
   
}
```

## Ues multiple share Libraries
```groovy
@Library(['pipeline-shared-lib', 'pipeline-shared-other-lib']) _

pipeline {
    agent any
    stages{
        stage('Build'){
            steps{
                script{
                    swissknife.printName 'John'
                }
            }         
        }
    }
   
}
```


## Importing Libraries
```groovy
















@Library("pipeline-shared-lib")
import com.acceleratedskillup.*;

pipeline {
    agent any
    stages{
        stage('Build'){
            steps{
                script{
					def car = new Car(this)	
					car.numberOfDoors = 4
					car.brand="brandX"
					car.model="modelY"
                    car.printOutCar()
                }
            }         
        }
    }
   
}



@Library("pipeline-shared-lib") _

pipeline {
    agent any
    stages{
        stage('Build'){
            steps{
                executeInScript ({
                    sh "printenv"
                })
            }         
        }
    }
}


@Library("pipeline-shared-lib") _

pipeline {
    agent any
    stages{
        stage('Build'){
            steps{
                execMaven '--help'
				execMaven()
            }         
        }
    }
  
}


@Library("pipeline-shared-lib") _

execBuildOrDeploy("build")


@Library("pipeline-shared-lib")
import com.acceleratedskillup.*;


pipeline {
    agent any
    stages{
        stage('Build'){
            steps{
                script{
					def calculator = new Calculator()					
                    println calculator.add(1,2)
                }
            }         
        }
    }
   
}


@Library("pipeline-shared-lib") _

pipeline {
    agent any
    stages{
        stage('Build'){
            steps{			
                script{
                    def request = libraryResource 'com/acceleratedskillup/request.json'
                    echo request
                }
            }         
        }
    }
}



@Library("pipeline-shared-lib")
import static com.acceleratedskillup.ValidatorUtils.*;

pipeline {
    agent any
    stages{
        stage('Build'){
            steps{
                script{
					validateInput(this)
                }
            }         
        }
    }
   
}

---------------

pipeline {
    agent any
    stages{
        stage('Build'){
            steps{
                script{
					library ("pipeline-shared-lib").com.acceleratedskillup.ValidatorUtils.validateInput(this)
                }
            }         
        }
    }
   
}



@Grab('org.apache.commons:commons-lang3:3.7')
import org.apache.commons.lang3.StringUtils

pipeline {
    agent any
    stages{
        stage('Build'){
            steps{
                echo StringUtils.upperCase("hello world")
            }         
        }
    }
   
}


