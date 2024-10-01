 pipeline { 
     agent any 
  
     parameters { 
         choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Choose the Terraform action') 
     } 
  
     stages { 
        stage('Git Checkout') { 
             steps { 
                git 'https://github.com/HarshalPatil-Repo/Two-tier-network-infrastructure-by-using-Terraform.git'
             } 
         }
         stage('Terraform Init') { 
             steps { 
                dir('Source_Code'){
                sh 'terraform init'
                }
            } 
        } 
  
         stage('Terraform Plan') { 
             steps {
                dir('Source_Code'){
                    sh 'terraform plan'
                }   
             } 
        } 
  
         stage('Terraform Apply/Destroy') { 
             steps {
                 dir('Source_Code'){
                    script { 
                     if (params.ACTION == 'Apply') { 
                         echo "Running terraform apply..." 
                         sh 'terraform apply -auto-approve'
                     } else if (params.ACTION == 'Destroy') { 
                         echo "Running terraform destroy..." 
                         sh 'terraform destroy -auto-approve'
                     } 
                   }
                }
                  
            } 
        } 
     } 
  
     post { 
         always { 
             // Clean up and finalize actions 
             echo "Pipeline finished." 
         } 
         success { 
             echo 'Pipeline completed successfully.' 
         } 
         failure { 
             echo 'Pipeline failed.' 
         } 
     } 
 }