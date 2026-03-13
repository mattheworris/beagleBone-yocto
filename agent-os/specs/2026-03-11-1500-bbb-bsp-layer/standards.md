# Standards for BBB BSP Layer

No project standards have been defined yet (`agent-os/standards/index.yml` is empty).

As Yocto-specific conventions are established during this project, they should be added to `agent-os/standards/` for future reference.

## Yocto Community Conventions (informal)

- Layer names: `meta-<boardname>` or `meta-<company>-<boardname>`
- Machine names: lowercase, hyphens (e.g. `beaglebone-black`)
- Recipe files: `<name>_<version>.bb`, appends: `<name>_%.bbappend` (wildcard version)
- `LAYERSERIES_COMPAT` must be set to the target Yocto release codename
- `local.conf` is developer-local and typically `.gitignore`d
