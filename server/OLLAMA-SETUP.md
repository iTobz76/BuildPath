# Using Ollama on your Windows PC for the BuildPath tutor

The phone and the website never talk to Ollama. Only your BuildPath server does, over your home network.
**Never port-forward Ollama or put it behind a public tunnel.** It has no login, so anyone who found it could use your GPU and manage your models.

## 1. Give the PC a steady address
Run `ipconfig` and note the **IPv4 Address** (for example `<ollama-machine-ip>`). In your router, reserve that address for this PC (a "DHCP reservation") so it never changes.

## 2. Make Ollama listen on your network
1. Quit Ollama (right-click its icon in the system tray, then **Quit Ollama**).
2. Open Settings and search for **environment variables**, then choose *Edit environment variables for your account*.
3. Under *User variables* click **New**: name `OLLAMA_HOST`, value `0.0.0.0:11434`. Click OK.
4. Start Ollama again from the Start menu. (If Windows asks about the firewall, allow **Private** networks only.)

## 3. Allow your server through the firewall
In an **administrator** PowerShell, first check the network is marked Private:
```powershell
Get-NetConnectionProfile
```
It should say `Private` (if it says `Public`, change it in Settings > Network). Then open the port to your home network only. Change `192.168.1.0/24` if your network uses different numbers:
```powershell
New-NetFirewallRule -DisplayName "Ollama for BuildPath" -Direction Inbound -Protocol TCP -LocalPort 11434 -Action Allow -Profile Private -RemoteAddress 192.168.1.0/24
```

## 4. Check the model and test from the server
On the PC: `ollama list` should show `qwen2.5-coder:7b`.
On the server (ZimaOS):
```bash
curl http://<ollama-machine-ip>:11434/api/tags
```
You should get JSON that includes your model. A timeout or "connection refused" means steps 2 or 3 aren't done (check with `netstat -an | findstr 11434` on the PC: it should say `0.0.0.0:11434`).

## 5. Point BuildPath at it
In `server/.env`:
```
TUTOR_PROVIDER=ollama
OLLAMA_URL=http://<ollama-machine-ip>:11434
OLLAMA_MODEL=qwen2.5-coder:7b
```
Restart the server (`docker compose up -d --build`), then test from inside the container:
```bash
docker compose exec pocketbase wget -qO- http://<ollama-machine-ip>:11434/api/tags
```

## Good to know
- **PC asleep or off:** the tutor says it is resting. Everything else keeps working.
- **Gaming:** the model holds a few GB of GPU memory while loaded. `OLLAMA_KEEP_ALIVE` (default `5m`) sets how long it stays loaded after a question; a shorter time frees the GPU sooner, but the next question starts slower.
- **First question after idle** is the slowest, because the model has to load.
- **Answers feel off?** Try `TUTOR_SHARE_REFERENCE=true` (the model then sees the reference answer; it is still forbidden to reveal it, and the server still filters leaks).
