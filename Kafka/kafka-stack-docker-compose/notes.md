- How to start an Apache Kafka broker with Docker and Docker-Compose [here](https://www.youtube.com/watch?v=Zq8aMrRnvQE)

- How to install Conduktor Desktop for Apache Kafka [here](https://www.youtube.com/watch?v=WhMPqUgYYCQ)

- Installing Conduktor [here](https://docs.conduktor.io/sign-in-section/install)

- How to install Conduktor on Ubuntu/Debian [here](https://docs.conduktor.io/sign-in-section/install/linux)

```
mkdir conduktor && cd conduktor
wget https://releases.conduktor.io/linux-deb
apt install ./Conduktor-2.7.0.deb
```

## HomeBrew installation on Ubuntu 20.04 Linux [here](https://www.how2shout.com/linux/how-to-install-brew-ubuntu-20-04-lts-linux/)
```
sudo apt update
sudo apt-get install build-essential -y
sudo apt install git -y
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew doctor
brew install gcc
```