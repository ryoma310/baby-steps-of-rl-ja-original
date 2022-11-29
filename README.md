# baby-steps-of-rl-ja-original
create Docker environment for use original [icoxfog417/baby-steps-of-rl-ja](https://github.com/icoxfog417/baby-steps-of-rl-ja) code


## Basic Usage
- run with prebuild docker image
```bash
## enter the container
docker run --rm --gpus all -it ryoma310/rl-book:latest
# or clone this repo and run ./run.sh
git clone https://github.com/ryoma310/baby-steps-of-rl-ja-original.git
bash ./run.sh


## inside the container, do setup first
bash ./setup.sh

## and, enjoy!!
```

- default settings
    - username: user
    - password: user

## Advanced Usage
### Step
1. clone this repo
2. build docker image yourself
3. enter the container
4. do setup first

- Build docker image yourself
```bash
## clone this repo
git clone https://github.com/ryoma310/baby-steps-of-rl-ja-original.git
cd baby-steps-of-rl-ja-original

## build the image
## user uid:gid inside the container is set to yours
bash ./build.sh

## enter the container 
bash ./run-handmade.sh

## inside the container, do setup first
bash ./setup.sh

## and, enjoy!!
```
