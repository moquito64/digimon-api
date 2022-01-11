# Digimon-Api (Built on Strapi and Postgres)

This is a digimon api that is built using Strapi and Postgres
This is currently running on my home server which can be found here: [digi-api](https://digidb-api.wolfandcrow.tech/).

I have included the docker-compose as well as the nomad hcl files for this project. If someone wants to set up something similar. Be aware that the Nomad one is configured to use cni and proxy cars via consul service mesh.  

### Calling the api endpoints
If you want to make sample calls to the digi-api found at (https://digidb-api.wolfandcrow.tech) you can do so but since it is public be aware that its only read-only data and can be rebuilt or brought down since its self hosted in my on-prem cluster.

the endpoint is `/digimons/` example `GET https://digidb-api.wolfandcrow.tech/digimons/?Name=Agumon` should give you:

`[{"Index":18,"Name":"Agumon","id":18,"Stage":"Rookie","Type":"Vaccine","Attribute":"Fire","Imagesrc":"http://digidb.io/images/dot/dot050.png","published_at":"2022-01-10T23:29:44.438Z","created_at":"2022-01-10T23:29:44.774Z","updated_at":"2022-01-10T23:29:44.774Z"}]`

You can `find,findone, and count`

- findone `/digimons/:id`:

`GET https://digidb-api.wolfandcrow.tech/digimons/1`

`{"Index":161,"Name":"Kuramon","id":1,"Stage":"Baby","Type":"Free","Attribute":"Neutral","Imagesrc":"http://digidb.io/images/dot/dot629.png","published_at":"2022-01-10T23:29:44.458Z","created_at":"2022-01-10T23:29:45.501Z","updated_at":"2022-01-10T23:29:45.501Z"}`

- find `/digimons`:

`GET https://digidb-api.wolfandcrow.tech/digimons/`

Response should be everything.

- count `/digimons/count`:

`GET https://digidb-api.wolfandcrow.tech/digimons/count`

RESPONSE: `341`


### Sample Data
I have provided sample data in data/digimon.json. You can load it in using the bootstrap function found in ./config/functions/bootstrap.js
Simply replace the current module.exports with the code below:

```
   module.exports = () => {
   var input = require('fs').readFileSync('./data/digimon.json');
   const data = JSON.parse(input);
   Object.keys(data.fulldigimondata).forEach(entry =>
       {
           console.log(data.fulldigimondata[entry].index)
           strapi.services.digimon.create({
               Name: data.fulldigimondata[entry].name,
               Index: data.fulldigimondata[entry].index,
               Type: data.fulldigimondata[entry].type,
               Stage: data.fulldigimondata[entry].stage,
               Attribute: data.fulldigimondata[entry].attribute,
               Imagesrc: data.fulldigimondata[entry].imagesrc
           });
       });
    };
```
    
    
The fastest way to get this all up is to `docker-compose up -d` to spin up an empty strapi instance in production and a postgres container.

### Just Node

If you want to run this just using node you can do this using the sample data above. 

`npm install` to pull all the required developement stuff

`npm strapi build` to build the admin ui

`npm stapi develop` to start a development server

Navigate to (http://localhost:1337/). The app will automatically reload if you change any of the source files

### TlDR Just give me digital monsters

1. Install Docker and Docker-Compose (https://docs.docker.com/compose/install/)
2. Uncomment data/digimon.js or replace with above.
3. `git clone` this repo
4. `docker-compose up -d`
5. Wait for the containers to start and head over to (http://localhost:1337/)





