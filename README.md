# SteamCMD ARM64 Docker Image

A Docker container for running SteamCMD servers on ARM64 architecture using FEX emulation. This container allows you to run Steam dedicated servers and download Steam content on ARM64 platforms like Apple Silicon Macs, Raspberry Pi, and ARM-based cloud instances.

## Prerequisites

- Docker installed on your ARM64 system

## Building the Image

```bash
docker build -t jublx/steamcmd-arm64-base .
```

## Usage

You can run the container using the following command:

```bash
docker run -it --rm --cap-add SYS_ADMIN --device /dev/fuse \
    -v /tmp/fex-emu-cache:/home/steam/.fex-emu \
    jublx/steamcmd-arm64-base
```

The `-v /tmp/fex-emu-cache:/home/steam/.fex-emu` flag mounts a volume to the FEXEmu configuration directory. This allows to persist the RootFS and prevents from downloading it each time you run the image.

## Notes

- This image uses FEX-Emu for x86_64 emulation, which may impact performance
- Some Steam games/servers might not work properly under emulation
- Regular updates are recommended to maintain security and compatibility

## Dockerfile Details

The image is based on Ubi9-minimal and includes:
- FEX-emu user static for x86_64 emulation
- Required 32-bit libraries
- SteamCMD installation
- Necessary dependencies for Steam

## Additional Information

- [SteamCMD Documentation](https://developer.valvesoftware.com/wiki/SteamCMD)
- [Docker Documentation](https://docs.docker.com/)

## License

MIT License - See LICENSE file for details

## Support

- Create an issue in the GitHub repository
- Check [Steam's documentation](https://developer.valvesoftware.com/wiki/SteamCMD) for SteamCMD-specific issues
