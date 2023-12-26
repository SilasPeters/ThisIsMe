FROM haskell:9.2.5-slim as build

WORKDIR /opt/build

# Copy the files responsible for listing dependencies
COPY stack.yaml stack.yaml.lock ThisIsMe.cabal ./

# Cache the dependencies
RUN stack build --only-dependencies

# Copy the source files
COPY src src

# Compile the project
RUN stack install --local-bin-path ./

# Now we copy only the files we need to the final image.
# Using alpine here because it is much smaller than debian slim
# and we only need glibc and gmp as shared libraries
FROM alpine

EXPOSE 3000

WORKDIR /home/website

RUN apk add gcompat gmp

COPY --from=build /opt/build/ThisIsMe thisisme

# Copy the remaining files not required for compilation
COPY public public
COPY src/pages src/pages

CMD ./thisisme
