'use strict';

/**
 * An asynchronous bootstrap function that runs before
 * your application gets started.
 *
 * This gives you an opportunity to set up your data model,
 * run jobs, or perform some special logic.
 *
 * See more details here: https://strapi.io/documentation/developer-docs/latest/setup-deployment-guides/configurations.html#bootstrap
 */

module.exports = () => {};
// var input = require('fs').readFileSync('./data/digimon.json');
// const data = JSON.parse(input);
// Object.keys(data.fulldigimondata).forEach(entry =>
//     {
//         console.log(data.fulldigimondata[entry].index)
//         strapi.services.digimon.create({
//             Name: data.fulldigimondata[entry].name,
//             Index: data.fulldigimondata[entry].index,
//             Type: data.fulldigimondata[entry].type,
//             Stage: data.fulldigimondata[entry].stage,
//             Attribute: data.fulldigimondata[entry].attribute,
//             Imagesrc: data.fulldigimondata[entry].imagesrc
//         });
//     });
// };
