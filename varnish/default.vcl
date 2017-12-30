vcl 4.0;

backend default {

    .host = "yr-nginx"; # nginx proxy container for yr
    .port = "80";

}


sub vcl_recv {

    # Only serve api related requests back
    # If not relevant url, then return not found code.
    if (req.url !~ "^/api/v[0-9]/") {
        return (synth(404));
    }

}

sub vcl_backend_response {

    # cached for 30 minutes
    set beresp.ttl = 30m;
    # 5 minutes grace period
    set beresp.grace = 5m;

}

sub vcl_deliver {

    # Add reponse header that indicates hit or miss on the cache
    # Should probably not be used in production
    if (obj.hits > 0) {
            set resp.http.X-Cache = "HIT";
    } else {
            set resp.http.X-Cache = "MISS";
    }

    set resp.http.Access-Control-Allow-Origin = "http://weather.docker.localhost";

}