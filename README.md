Example bash to get the pulls that I'm interested in:

```
cat pulls | sort -r | grep "\[]" | egrep -v "jkburges$"
```

