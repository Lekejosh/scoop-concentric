# Scoop bucket for Orbiter, the Concentric backup agent

```powershell
scoop install git     # if you don't have it: Scoop needs it to add a bucket
scoop bucket add concentric https://github.com/Lekejosh/scoop-concentric
scoop install concentric/orbiter
```

That puts `orbiter` on your PATH (for example `orbiter recover` to decrypt a
backup). To run the agent as a Windows service - starts at boot, restarts
itself, keeps itself up to date - run once in an elevated PowerShell:

```powershell
orbiter service install
```

It asks for your license key (portal: Agents -> Add agent) and master
passphrase. The service runs its own copy from
`C:\Program Files\Concentric\Orbiter`, so `scoop update orbiter` never has to
stop it. Remove the service with `orbiter service uninstall` (your data is
kept).

## From bckupx-agent

The app was `bckupx-agent` before the rename (0.1.46 and earlier); its
manifest is now in `deprecated/` and gets no more updates. Scoop can't rename
an app, so switch by hand:

```powershell
scoop uninstall bckupx-agent
scoop install concentric/orbiter
orbiter service install    # elevated
```

`service install` moves the existing `bckupx-agent` service over to
`orbiter`, with its settings (keys included) and data - nothing to re-enter.

The manifest is updated by the agent's release workflow on every stable
release (`update-manifest.sh <version>`).
