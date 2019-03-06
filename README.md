### To run this app

- ```truffle compile``` the contract/s
- ```truffle migrate --reset``` to deploy

- Run Ganache locally or using the GUI

- Connect using MetaMask to port 127.0.0.1:7545
- To import any of our ganache test accounts into MetaMask, import the private key by clicking on the key icon to the right

- invoke ```lite-server``` to serve the frontend index.html

- Need to get authorized, owner needs to first authorize any accounts before they can vote. You can easily create a UI to do this - 
- for now we will use remix to do so:
    - open the source code of the contract in remix
    - In the run tab select Injected Web3 - this is pointed to our ganache test blockchain (locally running)
    - and paste the ganache address into the AtAddress textbox in Remix
    - get this address by opening the transactions tab in the ganache gui
    - the latest contract creation will be the address you use
    - click on AtAddress button and you get connected to the deployed contract and have a nice UI to interact with

### Testing
- Run Ganache GUI and login to the port 7545 at localhost using MetaMask
- ```truffle test```

### Truffle Deployment
To Use Infura 
- ``` npm install truffle-hdwallet-provider ```
- Go to https://infura.io/dashboard
- Create a new project specifically for this project
- Set up dotenv (as noted below) to store your keys and mnenomic
- to deploy, in console, ```truffle migrate --network rinkeby```
- or ```truffle migrate --network rinkeby --reset --compile-all```

### Using dotenv to hide keys
- ```npm install dotenv --save```
- Add the following line to your app ```require('dotenv').config()
- create a .env file at the root directory of your app and add the variables needed to it
- add .env to .gitignore

### Set Up Continuous Deployment with buddy.works
- Start a new git repository for your project
- 

