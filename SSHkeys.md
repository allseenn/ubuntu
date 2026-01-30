# How to check ssh keys info

### Agent

**Check if ssh-agent is loaded in processes**:

```bash
ps aux | grep ssh-agent
```

**To start agent with params**:

```bash
ssh-agent -s
```

### Load keys in memory

**all keys from ~/.ssh:**

```bash
ssh-add
```

**one exact key permanently:**

```bash
ssh-add ~/.ssh/id_rsa
```

**one key temporary:**

```bash
ssh-add -t 3600 ~/.ssh/id_rsa
```

### List keys in memory

**By fingerprint:**

```bash
ssh-add -l
```

**By public keys:**

```bash
ssh-add -L
```

### Unload keys from memory

**All keys:**

```bash
ssh-add -D
```

**By filename:**

```bash
ssh-add -d ~/.ssh/id_rsa
```

**By fingerprint:**

```bash
ssh-add -d "SHA256:abcd1234..."
```

**By comment:**

```bash
ssh-add -d som_comments
```

Last two wont work with keys loaded with keepass programs

### Public key from private

```bash
ssh-keygen -y -f ~/.ssh/id_rsa
```
