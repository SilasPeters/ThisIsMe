# ThisIsMe

My very own flexible portfolio

## Installation

First clone this repository, and enter the just-created directory `ThisIsMe`.

### Installation with Docker

To build the website using docker, first make sure that the Docker daemon is running.

```bash
systemctl start docker.service # Requires sudo
```

Then, run the following commands:

```bash
port=3000 # Change this to whatever port you want to use to acces the website
docker build -f DockerfileRelease --tag thisisme-release . # This will take 10-15 minutes
docker create --name=thisisme-release -p $port:3000 thisisme-release
```

Luckly, docker cashes most of these steps.

### Installation with Stack/Cabal

First, make sure you have installed `stack` or `cabal`. If you do not have one of
them installed yet, do so through [ghcup](https://www.haskell.org/ghcup/install/).

Then, just run `stack build` or `cabal build`. The website will be build, which
can take 10-15 minutes.

## Usage

This assumes you are still in the ``ThisIsMe`` directory.

### Usage with Docker

```bash
docker start thisisme-release # Add the -i flag to print output
```

Now visit ``localhost:{port}`` where ``{port}`` should be replaced with the port
you chose earlier, and you should see the home page!

### Usage with Stack/Cabal

Run `stack run` or `cabal run`. That's it!

Visit ``localhost:3000``, and you should see the home page.

## TODO

- Research minimalising the docker image by using [haskell-scratch](https://github.com/fpco/haskell-scratch/) as the final parent image.
- Make thumbnails even smaller, and perhaps also the original pictures to 2k(1600xY). Use webp?
  - Generate smaller versions of thumbnails through pipeline
- Apply linter
- Implement pipeline to generate thumbnails, process image orientations
- Specify canonical link and/or `noindex` meta attribute