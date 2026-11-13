# mise-fullsend

A [mise](https://mise.jdx.dev/) plugin to manage [Fullsend](https://github.com/fullsend-ai/fullsend) CLI installations.

## Installation

```bash
mise plugin install fullsend https://github.com/rm3l/mise-fullsend.git
```

## Usage

```bash
# Install the latest version
mise install fullsend@latest

# Install a specific version
mise install fullsend@0.55.0

# Set the global default version
mise use -g fullsend@latest

# Set a project-local version
mise use fullsend@0.55.0
```

### Private GitHub repositories

For private tool repositories, configure a GitHub token through one of mise's [GitHub token sources](https://mise.jdx.dev/dev-tools/github-tokens.html). The plugin uses `api.github.com` URLs, so mise automatically attaches the configured token.

## Development

### Setup

```bash
# Clone the repository
git clone https://github.com/rm3l/mise-fullsend.git
cd mise-fullsend

# Install pre-commit hooks (optional but recommended)
hk install
```

### Testing

```bash
# Link the plugin for development
mise plugin link --force fullsend .

# Run tests
mise run test

# Run linting
mise run lint

# Run full CI suite
mise run ci
```

### Debugging

```bash
MISE_DEBUG=1 mise install fullsend@latest
```

## Supported Platforms

| OS    | Architecture |
|-------|-------------|
| Linux | amd64       |
| Linux | arm64       |
| macOS | amd64       |
| macOS | arm64       |

## License

MIT
