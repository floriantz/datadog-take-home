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

### Fetch Images
Currently, the script to fetch images only works using the docker set-up.
With the docker compose running, run 
`docker compose exec example-site yarn fetch-images`
Image files should be saved in `static/img/products`

### Deploy to S3
Uploading the site through Terraform is a bit painful currently to handle the mimetypes correctly, ideally I'd do it in a github action but for now
`aws s3 sync public s3://datadog-take-home.floriantz.com` does the job.

### Access the site
Site is deployed at http://datadog-take-home.floriantz.com/
Currently just as an s3 static site on S3, a good first improvement would be adding a cloudfront CDN and remove direct public access to the bucket

### Datadog RUM
RUM is integrated through the sync CDN method on the florian.thelliez@gmail.com account


[1]: https://nodejs.org/en/download/package-manager#macos
[2]: https://gohugo.io/getting-started/installing/
[3]: https://golang.org/doc/install
[4]: https://www.docker.com/products/docker-desktop/
[5]: https://www.docker.com/get-started/
