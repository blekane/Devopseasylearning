## Discard the output
Sometimes you will need to execute a command, but you don't want the output displayed on the screen. In such cases, you can discard the output by redirecting it to the file `/dev/null`

```
$ command > /dev/null
```

Here command is the name of the command you want to execute. The file /dev/null is a special file that automatically discards all its input.

### To discard both output of a command and its error output, use the following:
```
$ command > /dev/null 2>&1
```
