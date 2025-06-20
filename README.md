HTTP to HTTPS
=============
Forked from https://github.com/RealKinetic/http-to-https by https://github.com/gmkey/http-to-https

The web is moving to TLS. This is a Docker container that forces browser
redirection from HTTP to HTTPS for all hosts that hit it.

HTTP code 307 is used to redirect browsers so that the HTTP method does not
change (which would happen with old clients using 301/302).

Running:
--------

``docker run --rm -p80:80 -d gmkey/http-to-https:latest``.

Building
--------

``make build``

If satisfied: 

``make push``


Maintenance:
------------
Edit the Dockerfile.template to reflect your changes (possibly http.conf/global.conf) and re-build.

## Mainly used to circumvent Google Compute Engine Load Balancer limitations regarding hsts and http/https redirects. This is now resolved, but there might still be some alternative use cases.
