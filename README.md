# Multistage Docker build

There are 2 stages involved
1. Import the provided cert into Java trustore
2. Copy the modified truststore from previous stage to final image


## Purposes
Only keep what necessary in the final image while leave out the origianl provided cert hence reducing attack surface.

Run `docker build --force-rm=true --build-arg CERT_PASSWORD=<PASSWORD> --tag=<IMAGE_TAG> .` to build the image.

## Limitation & To-Do
1. Using default password `changeit` may be a security risk. Argument `CERT_PASSWORD` can be used to mitigate this.
2. `PATH_TO_CACERTS` should be dynamic so that it works for all JDK versions.
