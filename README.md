# ruby.tnantoka.com

![canvas](/canvas.gif)

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

## With MagickCanvas

```
$ bundle exec magick_canvas draw rmagick/sine_wave_png.rb -a=Safari -w
```

## Acknowledgments

- https://github.com/ruby-processing/The-Nature-of-Code-for-JRubyArt
