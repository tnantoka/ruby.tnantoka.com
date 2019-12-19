# ruby.tnantoka.com

## Without Docker

```
$ bundle
$ bundle exec ruby rmagick/fuyofuyo.rb
```

## With Docker

### Build

```
$ docker build . -t ruby-tnantoka
```

### Run

```
$ docker run -it -v $PWD:/app ruby-tnantoka bundle exec ruby rmagick/fuyofuyo.rb && open -a Safari tmp/image.gif
```

### Update dependencies

```
$ docker run -v $PWD:/app ruby-tnantoka bundle
```
