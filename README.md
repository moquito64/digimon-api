# Digimon-Api (Built on Strapi and Postgres)

This is a digimon api that is built using Strapi and Postgres
This is currently running on my home server which can be found here: [digi-api](https://digidb-api.wolfandcrow.tech/).

I have included the docker-compose as well as the nomad hcl files for this project. If someone wants to set up something similar. Be aware that the Nomad one is configured to use cni and proxy cars via consul service mesh.  

I have provided sample data in data/digimon.json. You can load it in using the bootstrap function found in ./config/functions/bootstrap.js

  `module.exports = () => {
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
    };`
