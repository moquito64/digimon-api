# Digimon-Api (Built on Strapi and Postgres)

This is a digimon api that is built using Strapi and Postgres
This is currently running on my home server which can be found here: [digi-api](https://digidb-api.wolfandcrow.tech/).

I have included the docker-compose as well as the nomad hcl files for this project. If someone wants to set up something similar. Be aware that the Nomad one is configured to use cni and proxy cars via consul service mesh.  

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

