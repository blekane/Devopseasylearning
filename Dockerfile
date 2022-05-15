FROM google/cloud-sdk:160.0.0


RUN apt-get update -y

RUN apt-get install wget -y \
    curl \
    vim \
    unzip \
    git 

### KUBECTL INSTALLATIN
RUN curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.17.9/2020-08-04/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv kubectl /usr/local/bin/


### INSTALL KUBECTX AND KUBENS
RUN wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx \
    && wget https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens \
    && chmod +x kubectx kubens \
    && mv kubens kubectx /usr/local/bin


### HELM INSTALLATIN
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh


