# SteamCMD ARM64 Docker Image

A Docker container for running SteamCMD on ARM64 architecture using FEX emulation. This container allows you to run Steam dedicated servers and download Steam content on ARM64 platforms like Apple Silicon Macs, Raspberry Pi, and ARM-based cloud instances.

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

## Usage Examples

### Running SteamCMD directly:
```bash
docker run -it jublx/steamcmd-arm64 +login anonymous +quit
```

### Installing a game server:
```bash
docker run -it -v /path/to/server:/serverfiles jublx/steamcmd-arm64 \
    +login anonymous \
    +force_install_dir /serverfiles \
    +app_update <app_id> \
    +quit
```

## Environment Variables

- `STEAMCMD_DIR`: Directory where SteamCMD is installed (default: `/opt/steamcmd`)
- `STEAMCMD_USER`: User to run SteamCMD as (default: `steam`)

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
