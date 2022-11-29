docker run --rm --gpus all -it ryoma310/rl-book:latest

## mount local ./workspace folder to /home/user/workspace
## Notice: you should make ./workspace directory before executing this command
##         if there is no ./workspace directory, this dir will automatically 
#          create by docker with root:root permission. so you cannnot use it as normal user.
# docker run --rm --gpus all -v $(pwd)/workspace:/home/user/workspace -it ryoma310/rl-book:latest