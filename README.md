# flocker

Build [Flutter](https://flutter.dev) apps painlessly with this [Docker](https://www.docker.com) image, having the [Android SDK](https://developer.android.com/studio) and [Flutter](https://flutter.dev) pre-installed.

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/syncloudsoftech/flocker/cd.yml?branch=main)
![Docker Pulls](https://img.shields.io/docker/pulls/syncloudsoftech/flocker)

## Usage

To use this image, you must have [Docker](https://www.docker.com) installed.
If already, run the below command in your [Flutter](https://flutter.dev) project folder:

```shell
$ docker run -it --rm -v $PWD:/workspace syncloudsoftech/flocker flutter build web
```

You can pass build either for `web` or `apk` / `appbundle` easily and pass any options e.g., `--debug` as below:

```shell
$ docker run -it --rm -v $PWD:/workspace syncloudsoftech/flocker flutter build apk --debug
```

## Development

Building or modifying the container yourself from source is also quite easy.
Just clone the repository and run below command:

```shell
$ docker build -t flocker .
```

Run the locally built container as follows:

```shell
$ docker run -it --rm -v $PWD:/workspace flocker flutter build web
```

## License

See the [LICENSE](LICENSE) file.
