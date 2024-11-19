# SteamCMD ARM64 Docker Image

A Docker container for running SteamCMD servers on ARM64 architecture using FEX emulation. This container allows you to run Steam dedicated servers and download Steam content on ARM64 platforms like Apple Silicon Macs, Raspberry Pi, and ARM-based cloud instances.

## Prerequisites

- Docker installed on your ARM64 system

## Quick Start

```bash
# Pull the image
docker pull jublx/steamcmd-arm64:latest

# Run interactive shell
docker run -it jublx/steamcmd-arm64:latest
```

## Building the Image

```bash
docker build -t jublx/steamcmd-arm64 .
```

## Usage

### Installing a game server

```bash
docker run -it --rm -v /path/to/server:/root/Steam/<SERVER_NAME> jublx/steamcmd-arm64 \
    -n <SERVER_NAME> \
    -i <GAME_ID> \
    -s <SERVER_EXECUTABLE>
```

>Note: To detach from a container without stopping it, use Ctrl+P followed by Ctrl+Q.

### Examples

```bash
docker run -it --rm -v /path/to/server:/root/Steam/Satisfactory jublx/steamcmd-arm64 \
    -n Satisfactory \
    -i 1690800 \
    -s FactoryServer.sh
```

## Notes

- This image uses FEX-Emu for x86_64 emulation, which may impact performance
- Some Steam games/servers might not work properly under emulation
- Regular updates are recommended to maintain security and compatibility

## Dockerfile Details

The image is based on Ubuntu and includes:
- FEX-emu user static for x86_64 emulation
- Required 32-bit libraries
- SteamCMD installation
- Necessary dependencies for Steam

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a Pull Request

## License

MIT License - See LICENSE file for details

## Support

- Create an issue in the GitHub repository
- Check [Steam's documentation](https://developer.valvesoftware.com/wiki/SteamCMD) for SteamCMD-specific issues
