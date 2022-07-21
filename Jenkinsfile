pipeline { 
  
  agent any 

  stages { 

    stage('Git Pull ') {
	
		  steps {

            git credentialsId: 'fb366a5d-341f-4b1a-9373-7f6d1bff495f', url: 'https://github.com/MOUAK-Ayoub/kafka-monitoring.git'
             
          }
    }
    
    stage('Install awscli & TF'){

        steps {
		
			sh ' echo installed '
		}
    }
    
    
    stage('AWS init') {
	
		when { expression { params.INIT_AWS } }
		steps {

			withAWS(credentials: "aws-keys", region: 'us-east-1') {
               
				dir('terraform') {
		
					sh './aws_tf_user.sh'
				
				}
			}
		}
	}
	
	
	stage('TF init & Apply') {
	
	   when { expression { params.INIT_TF } }
	 
	   steps {
	   withAWS(credentials: "aws-keys", region: 'us-east-1') {


        dir('terraform') {
            
			sh   '''
            
               export TF_VAR_aws_access_key=$(jq -r '.AccessKey.AccessKeyId' tokens.json)
               export TF_VAR_aws_secret_key=$(jq -r '.AccessKey.SecretAccessKey' tokens.json)

               terraform init -reconfigure
			   terraform plan
			   terraform apply --auto-approve

               
                 '''


        }
      
       }}
	}
   
  }
}
