# Websites Platform Take Home Assessment

### Prerequisites
#### Local non-docker setup
1. [Install Node.js and npm][1] (Node.js `>=20.11.0`)
1. [Install Hugo][2]
1. [Install Go][3] (at minimum, `go version` 1.21.8)
1. Install Yarn: `npm install -g yarn`

#### Docker Setup
1. [Install Docker][4] (Additional Instructions can be found [here][5])
### Spinning up on Local
This project is set up to be run with or without docker. After meeting all the [Prerequisites](#prerequisites) run the appropriate command(s) below.
#### With Docker
1. Run `docker-compose up`
#### Without Docker
1. Run `yarn install`
2. Run `yarn start`
3. Run `node ./_server/api.js`

[1]: https://nodejs.org/en/download/package-manager#macos
[2]: https://gohugo.io/getting-started/installing/
[3]: https://golang.org/doc/install
[4]: https://www.docker.com/products/docker-desktop/
[5]: https://www.docker.com/get-started/