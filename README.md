# ThisIsMe
My very own digital CV/portfolio

# Usage
**With Docker**

To run this through docker, use the following commands:

```bash
$ port=3000 # Change this to whatever port you want to use to acces the website
$ docker build -f DockerfileRelease --tag thisisMe .  # This will take around 10-15 minutes, sadly
$ docker run --name=thisisme -p $port:3000 -d thisisme
```

Now visit ``localhost:{port}`` where ``{port}`` should be replaced with the port you chose earlier, and you should see the home page!

Don't forget to close and/or remove the container afterwards:

```bash
$ docker stop thisisme # stops the container
$ docker rm thisisme   # deletes the container from your drive
```

**Without Docker**

First, make sure you have installed stack. If you do not have ``stack`` installed yet, do so through [ghcup](https://www.haskell.org/ghcup/install/).
Then, just hit ``$ stack run``.

Visit ``localhost:3000``, and you should see the home page.

If things don't work, I recommend you to use docker.

# TODO
Minimalize the docker image by using [haskell-scratch](https://github.com/fpco/haskell-scratch/) as the final parent image.
