
# Network Considerations

For smaller networks, use a 24-bit mask in different regions eg
```
eu-west-1 10.0.1.0/24
us-east-1 10.0.2.0/24
us-west-1 10.0.3.0/24
```

Consider making a distinction between private and public subnets, eg
```
private 10.0.1.0/24 (3rd byte < 129)
public 10.0.129.0/24 (3rd byte > 128)
```
12.0.0.0/16
Internet gatewy, associa6e with vpc
