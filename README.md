# Cache the YR REST api using Varnish and nginx

The YR api is located at https://www.yr.no/api/v0/. This repo contains a docker-compose and config files to serve the api using a nginx proxy container for fetching data from Yr and a Varnish cache container to cache the requests. Sample Traefik labels are added to make the api available on the internet.

The setup will cache (TTL) for 30 minutes and serve stale content for another 5 minutes (grace period - while doing an async fetch of data from the API).

Test url https://www.yr.no/api/v0/locations/2-2300660/forecast

# Usage

Just do `docker-compose up -d`.
If you want to bind to local ports or make the container available through a reverse proxy, then add stuff to `docker-compose.override.xml` (sampe provided).

# Questions?

Open an issue!

# Credits

The Yr weather API is provided by Norwegian Meteorological Institute and NRK. Make sure you understand the [usage requirements](http://om.yr.no/verdata/vilkar/) before using the API.

Docker images:

* Varnish: [newsdev/varnish](https://github.com/newsdev/docker-varnish)
* Nginx: [nginx official](https://github.com/nginxinc/docker-nginx)

# Inspiration

* https://runnable.com/blog/external-api-caching-with-varnish-nginx