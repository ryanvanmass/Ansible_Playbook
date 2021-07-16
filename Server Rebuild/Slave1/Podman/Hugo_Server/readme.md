# Run
**Current Deployment**
```
    podman run -p 1313:1313 -v /mnt/NetworkShares/Olympus/Website:/Website --name HugoServer <<ImageName>>
```

**Planned ZFS Deployment**
```
    podman run -p 1313:1313 -v /NetworkShares/Olympus/Website:/Website --name HugoServer <<ImageName>>
```