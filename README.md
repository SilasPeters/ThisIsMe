# ThisIsMe
My very own digital CV/portfolio

# Usage
**With Docker**

To run this through docker, use the following commands:
```bash
docker build --tag ThisIsMe .  # This will take around 7-10 minutes
docker run --expose=3000 ThisIsMe
```

**Without Docker**

First, make sure you have installed stack. If you do not have ``stack`` installed yet, do so through [ghcup](https://www.haskell.org/ghcup/install/).
Then, just hit ``$ stack run``.

If things don't work, I recommend you to use docker.

# TODO
Minimalize the docker image by using [haskell-scratch](https://github.com/fpco/haskell-scratch/) as the final parent image.
