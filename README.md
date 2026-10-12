# Scoop bucket for the Concentric agent

```powershell
scoop install git     # if you don't have it: Scoop needs it to add a bucket
scoop bucket add bckupx https://github.com/Lekejosh/scoop-bckupx
scoop install bckupx/bckupx-agent
```

That puts `bckupx-agent` on your PATH (for example `bckupx-agent recover` to
decrypt a backup). To run the agent as a Windows service - starts at boot,
restarts itself, keeps itself up to date - run once in an elevated PowerShell:

```powershell
bckupx-agent service install
```

It asks for your license key (portal: Agents -> Add agent) and master
passphrase. The service runs its own copy from `C:\Program Files\bckupx`, so
`scoop update bckupx-agent` never has to stop it. Remove the service with
`bckupx-agent service uninstall` (your data is kept).

The manifest is updated by the agent's release workflow on every stable
release (`update-manifest.sh <version>`).
