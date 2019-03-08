# Multistage Docker build

There are 2 stages involved
1. Import the provided cert into Java trustore
2. Copy the modified truststore from previous stage to final image


## Purposes
Only keep what necessary in the final image while leave out the origianl provided cert hence reducing attack surface.

Run `docker build --force-rm=true --build-arg CERT_PASSWORD=<PASSWORD> --tag=<IMAGE_TAG> .` to build the image.

## Optimize for caching

1. Place static instructions higher in the order. Instructions like, but not limited to, EXPOSE, VOLUME, CMD, ENTRYPOINT, and WORDIR whose value is not going to change once it is set.
2. Place dynamic instruction lower in the order. Instructions like ENV (when using variable substitution), ARG, and ADD
3. Place dependency RUN instructions before ADD or COPY instructions
4. Place ADD and COPY instructions after RUN instructions for installing dependencies but before dynamic instructions
5. Combine RUN Instructions


## Limitation & To-Do
1. Using default password `changeit` may be a security risk. Argument `CERT_PASSWORD` can be used to mitigate this.
2. `PATH_TO_CACERTS` should be dynamic so that it works for all JDK versions.
