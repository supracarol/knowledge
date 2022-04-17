# Zip

## Linux

### Install

```bash
sudo apt install -y zip
```

### Zip a directory

```bash
zip -r output.zip somedirectory/
```

### Add to an existing archive instead of creating new one
Warning: There is a possiblity of corrupting the original

```bash
zip -g existing.zip somefile.txt
```
