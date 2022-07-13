#cloud-config
package_upgrade: true
package_update: false


packages:
  - debian-archive-keyring
  - apt-transport-https
  - ca-certificates
  - software-properties-common
  - build-essential
  - golang-go
  - htop
  - curl
  - vim
  - gnupg2
  - docker-ce
  - nmap
  - dnsutils
  - git
  - azure-cli

groups:
  - docker
users:
  - default
  - name: github
    groups: docker
apt:
  sources:
    docker.list:
      source: "deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable"
      keyid: 0EBFCD88

write_files:
  - owner: root:root
    path: /root/setup.sh
    content: |
     curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
     curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh  | bash \
     echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/ubuntu/.profile \
     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

 
runcmd:
  - [/bin/bash, /root/setup.sh]

