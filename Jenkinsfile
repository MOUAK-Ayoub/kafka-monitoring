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

			withAWS(credentials: "aws-keys", region: params.REGION) {
               
				dir('terraform') {
		
					sh './aws_tf_user.sh'
				
				}
			}
		}
	}
	
	
	stage('TF init & Apply') {
	
	   when { expression { params.INIT_TF } }
	 
	   steps {

        dir('terraform') {
            
			sh '''
            
               export TF_VAR_aws_access_key=$(jq -r '.AccessKey.AccessKeyId' tokens.json)
               export TF_VAR_aws_secret_key=$(jq -r '.AccessKey.SecretAccessKey' tokens.json)

               terraform init -reconfigure
			   terraform plan
			   terraform apply --auto-approve

                rm tokens.json
                
				'''


        }
      
       }
	}

	stage('Install monitoring tools with ansible') {
	
		when { expression { params.INSTALL_MONITORING_TOOLS } }
		steps {
               
				dir('ansible') {

					sh '''

					echo "List of ec2 instaces grouped by tag: "

					ansible-inventory -i ./vars/aws_ec2.yml --graph

					echo "Execute playbooks"

					ansible-playbook -i ./vars/aws_ec2.yml  main_play.yml
					
					'''
				}
			
		}
	}
		   
  }
}
