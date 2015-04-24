Example bash to get the pulls in which I'm interested:

```
cat pulls | sort -r | grep "\[]" | egrep -v "jkburges$"
```

