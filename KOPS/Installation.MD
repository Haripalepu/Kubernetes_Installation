# 1. **Create Route 53 Hosted Zone**  
# (Perform this step manually through the AWS Management Console or AWS CLI)

# 2. **Deploy Ubuntu 22.04 Server (t2.micro) for Management**  
# (Launch the EC2 instance via AWS Console or CLI with the desired specifications)

# 3. **Create an S3 Bucket for Configuration Storage**  
# (Create the bucket manually or through CLI for storing configuration)


# 4. **Create AWS User with Access Keys or Assign Role to Management Server**
# (Either create an IAM user with programmatic access and generate an Access Key and Secret Key, or assign a role to the EC2 instance with appropriate permissions for K8S cluster creation)

# 5. **Login to Management Server, Become Root, and Generate SSH Keys**  
# (Generate SSH keys for use when deploying KOPS nodes)
ssh-keygen 

# 6. **Download KOPS & kubectl Binary to Management Server**  
# (Ensure you're in /usr/local/bin/ directory to install binaries)

cd /usr/local/bin/

## Download Kops Binary
wget https://github.com/kubernetes/kops/releases/download/v1.30.3/kops-linux-amd64
mv kops-linux-amd64 kops
chmod 777 kops

## Download kubectl Binary
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod 777 kubectl

# 7. **Configure Environmental Variables for KOPS**
# Set the necessary environment variables for KOPS (Data store, Kube editor, and Cluster name)

export CLUSTER_NAME=<your-cluster-name>  # Example: my-cluster.site
export AWS_REGION=<aws-region>           # Example: us-east-1
export KOPS_STATE_STORE=s3://<your-s3-bucket-name>  # Example: s3://k8s-2025
export KUBE_EDITOR=nano

# 8. **Deploy Kubernetes Cluster with KOPS**  
# Run the KOPS command to create the Kubernetes cluster

kops create cluster --name=$CLUSTER_NAME --state=$KOPS_STATE_STORE \
  --zones=$AWS_REGION"a,$AWS_REGION"b,$AWS_REGION"c" \
  --node-count=3 --control-plane-count=1 \
  --node-size=t2.micro --control-plane-size=t2.micro \
  --control-plane-zones=$AWS_REGION"a" \
  --node-volume-size=10 --control-plane-volume-size=10 \
  --ssh-public-key /root/.ssh/id_rsa.pub \
  --dns-zone=<your-dns-zone> --networking calico --yes

# 9. **Apply Configuration and Wait for the Cluster to Deploy**
kops apply -f cluster.yaml

# Once the cluster is deployed successfully, validate the setup:
kops validate cluster
