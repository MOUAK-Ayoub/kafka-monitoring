pipeline { 
  
  agent any 

  stages { 


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

		withAWS(credentials: "aws-keys", region: params.REGION) {

            dir('terraform') {
            
			   sh '''
            
			    echo " Create tokens: "

			    aws iam create-access-key --user-name terraform > tokens.json
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
	}

	stage('Install monitoring tools with ansible') {
	
 		when { 
			anyOf {

  				expression { params.INSTALL_DOCKER } 
        		expression { params.INSTALL_PROMETHEUS } 
    			expression { params.INSTALL_GRAFANA } 
			}
		}

		steps {
               	
				withAWS(credentials: "aws-keys", region: params.REGION) {

				 dir('ansible') {

					sh '''

					echo "List of ec2 instaces grouped by tag: "

					ansible-inventory -i aws_ec2.yml --graph

					'''
					ansiblePlaybook(credentialsId: 'ec2-key', 
									inventory: 'aws_ec2.yml',
									playbook: 'main_play.yml',
									extras: "-e env=dev -e install_docker=${INSTALL_DOCKER} -e install_prometheus=${INSTALL_PROMETHEUS} -e install_grafana=${INSTALL_GRAFANA}"
									)

				 }
				}
		}
	}

	stage('Terraform destroy infrastructure') {
	
	   when { expression { params.DESTROY_TF } }
	 
	   steps {

		withAWS(credentials: "aws-keys", region: params.REGION) {

            dir('terraform') {
            
			   sh '''
            
					terraform destroy --force
			
				  '''

		    }
        }
      
       }
	}

		   
  }
}
