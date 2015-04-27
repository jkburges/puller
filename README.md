Example bash to get the pulls in which I'm interested:

```
cat pulls | sort -r | grep "\[]" | egrep -v "jkburges$"
```

Merge stats:
```
cut -d ',' -f 6 closed_pulls | sort | uniq -c | sort -r
```

Commentors:
```
egrep -o "\[.*\]" closed_pulls | egrep -o "[a-z0-9]+" | sort | uniq -c | sort -r
```

