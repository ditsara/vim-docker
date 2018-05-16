ditsara/vim-docker
==================

```
xhost local:root # allow access to X server to share system clipboard
alias vimd='docker run -ti --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd):/app ditsara/vim-docker'
```

