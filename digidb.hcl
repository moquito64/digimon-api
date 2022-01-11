job "digidb" {
    datacenters = ["dc1"] 
    type = "service"
    group "digidb-api" { 
        count = 1
        volume "digidb-app"{
           type      = "host"
           source    = "digidb-app"
           read_only = false 
	}
        network {
            mode = "bridge"
            port "digidb-port" {
                to = 1337
            }
        }
        service {
            name = "digidb-api"
            port = "digidb-port"
            tags = [
               "traefik.enable=true",
               "traefik.http.routers.digidb-api.entrypoints=http",
               "traefik.http.routers.digidb-api.rule=Host(`digidb-api.wolfandcrow.tech`)",
               "traefik.http.middlewares.digidb-api-https-redirect.redirectscheme.scheme=https",
               "traefik.http.routers.digidb-api.middlewares=digidb-api-https-redirect",
               "traefik.http.routers.digidb-api-secure.entrypoints=https",
               "traefik.http.routers.digidb-api-secure.rule=Host(`digidb-api.wolfandcrow.tech`)",
               "traefik.http.routers.digidb-api-secure.tls=true",
               "traefik.http.routers.digidb-api-secure.service=digidb-api",
               "traefik.http.services.digidb-api.loadbalancer.server.port=${NOMAD_HOST_PORT_digidb_port}"
            ]
        connect {
          sidecar_service {
            tags = [ "traefik.enable=false" ]
            proxy {
              upstreams {
                destination_name = "digidb-psql"
                local_bind_port  = 5432
            }
          }
        }
      }
     }

        task "digidb-api" {
        driver = "docker"

        env {
            TZ = "Pacific/Honolulu"
            NODE_ENV = "production"
            DATABASE_CLIENT = "postgres"
      	    DATABASE_NAME = "strapi"
      	    DATABASE_HOST = "${NOMAD_UPSTREAM_IP_digidb_psql}"
      	    DATABASE_PORT = "${NOMAD_UPSTREAM_PORT_digidb_psql}"
      	    # Change these:
            DATABASE_USERNAME = "strapi"
            DATABASE_PASSWORD = "strapi" 
           
        }
        volume_mount {
            volume = "digidb-app"
            destination = "/srv/app"
        }
       
        config {    
            image = "strapi/strapi"
        }

    }
  }
    group "digi-psql" {
    count = 1
    network {
      mode = "bridge"
    }
    service {
      name = "digidb-psql"
      port = "5432"
      tags = [ "traefik.enable=false" ]
      connect {
        sidecar_service {
          tags = [ "traefik.enable=false" ]
        }
      }
    }
    volume "digidb-data" {
      type            = "host"
      source          = "digidb-data"
      read_only       = false

    }

    task "digidb-postgres" {
      driver = "docker"
      env{
        POSTGRES_DB = "strapi"
        #change these:
        POSTGRES_USER = "strapi"
        POSTGRES_PASSWORD = "strapi"
      }
      config {
        image = "postgres"
      }

      volume_mount {
        volume = "digidb-data"
        destination = "/var/lib/postgresql/data"
      }
    }
  }
}
