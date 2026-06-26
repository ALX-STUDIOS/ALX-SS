# alx-ss

**English** ·

ScreenShare administration tool for FiveM servers running **ESX Legacy**.
Lets staff hold a player for a review: it teleports them to a private room,
freezes them, shows a countdown notice and, when it ends, plays a closing
video. Designed to integrate with gamemode systems via statebags.

## Features

- NUI interface with an animated circular countdown and fully configurable branding.
- Teleport to configurable coordinates and automatic position restore on close.
- Optional freeze and invincibility so the player can't fall or take damage.
- Warning sound when X seconds are left.
- Optional closing video when the countdown ends.
- Statebags (`screenShare`, `gamemode`) replicated to the server for gamemode integration.
- ESX group-based permissions (`admin`, `owner`, `superadmin` by default).
- The player can't dismiss the session themselves; it only closes when the sequence ends or via a staff command.
- Safety net: forced close by timeout if the NUI or the video hang, so no one gets stuck.

## Dependencies

- [es_extended](https://github.com/esx-framework/esx_core)

## Installation

1. Copy the `alx-ss` folder into your `resources` directory.
2. Add `ensure alx-ss` to your `server.cfg`.
3. (Optional) Replace `logo.png`, `audio.mp3`, `chitero.mp3` and `uwu.mp4` with your own assets.

## Commands

| Command         | Description                       |
| --------------- | --------------------------------- |
| `/ss [id]`      | Starts the ScreenShare on a player. |
| `/closess [id]` | Closes a player's ScreenShare.      |

Both require belonging to one of the groups defined in `Config.AllowedGroups`.

## Configuration

Everything is set in `config.lua`:

- `OpenCommand` / `CloseCommand` — command names.
- `AllowedGroups` — authorized ESX groups.
- `Duration` — countdown duration (seconds).
- `AlertAtSecond` — second at which the warning sound plays (`0` to disable).
- `PlayEndVideo` — play the video when it ends.
- `EndVideoMaxSeconds` — extra margin for the closing video before the safety close.
- `Coords` — point the player is teleported to during the session.
- `RestorePosition` — return the player to their original position on close.
- `FreezePlayer` / `InvinciblePlayer` — freeze and make the player invincible.
- `SetStateBags` / `GamemodeValue` — statebag integration.
- `UI` — texts and branding shown in the interface (title, message, button, requester, Discord).

---

## 🇪🇸 Español

[🇬🇧 English](#alx-ss) · **🇪🇸 Español**

Herramienta de **ScreenShare** para administración en servidores FiveM con **ESX Legacy**.
Permite al staff retener a un jugador para una revisión: lo teletransporta a una sala
privada, lo congela, le muestra un aviso con cuenta atrás y, al terminar, reproduce un
vídeo de cierre. Pensada para integrarse con sistemas de gamemode mediante statebags.

## Características

- Interfaz NUI con cuenta atrás circular animada y branding totalmente configurable.
- Teletransporte a coordenadas configurables y restauración automática de la posición al cerrar.
- Freeze e invulnerabilidad opcionales para que el jugador no caiga ni reciba daño.
- Sonido de aviso cuando quedan X segundos.
- Vídeo de cierre opcional al terminar la cuenta atrás.
- Statebags (`screenShare`, `gamemode`) replicados al servidor para integración con tu gamemode.
- Permisos por grupo de ESX (`admin`, `owner`, `superadmin` por defecto).
- El jugador no puede cerrar la sesión por su cuenta; solo se cierra al terminar la secuencia o por comando del staff.
- Red de seguridad: cierre forzado por timeout si el NUI o el vídeo se cuelgan, para evitar dejar a nadie atascado.

## Dependencias

- [es_extended](https://github.com/esx-framework/esx_core)

## Instalación

1. Copia la carpeta `alx-ss` en tu directorio `resources`.
2. Añade `ensure alx-ss` a tu `server.cfg`.
3. (Opcional) Sustituye `logo.png`, `audio.mp3`, `chitero.mp3` y `uwu.mp4` por tus propios assets.

## Comandos

| Comando         | Descripción                        |
| --------------- | ---------------------------------- |
| `/ss [id]`      | Inicia el ScreenShare al jugador.  |
| `/closess [id]` | Cierra el ScreenShare del jugador. |

Ambos requieren pertenecer a uno de los grupos definidos en `Config.AllowedGroups`.

## Configuración

Todo se ajusta en `config.lua`:

- `OpenCommand` / `CloseCommand` — nombres de los comandos.
- `AllowedGroups` — grupos de ESX autorizados.
- `Duration` — duración de la cuenta atrás (segundos).
- `AlertAtSecond` — segundo en el que suena el aviso (`0` para desactivar).
- `PlayEndVideo` — reproducir el vídeo al terminar.
- `EndVideoMaxSeconds` — margen extra para el vídeo de cierre antes del cierre de seguridad.
- `Coords` — punto al que se teletransporta al jugador durante la sesión.
- `RestorePosition` — devolver al jugador a su posición original al cerrar.
- `FreezePlayer` / `InvinciblePlayer` — congelar e invulnerabilizar al jugador.
- `SetStateBags` / `GamemodeValue` — integración con statebags.
- `UI` — textos y branding mostrados en la interfaz (título, mensaje, botón, requester, Discord).
