Config = {}
Config.ESXResource = 'es_extended'
Config.AllowedGroups = { 'admin', 'owner', 'superadmin' }

-- Comandos
Config.OpenCommand  = 'ss'
Config.CloseCommand = 'closess'

-- Duracion de la cuenta atras (segundos)
Config.Duration = 30

-- Reproducir el sonido de aviso cuando queden X segundos (0 = desactivado)
Config.AlertAtSecond = 5

-- Reproducir el video al terminar la cuenta atras
Config.PlayEndVideo = true

-- Margen extra (segundos) que se concede al video de cierre antes de forzar
-- el cierre por seguridad. El cierre normal lo gestiona la propia interfaz;
-- esto es solo una red de seguridad por si el NUI o el video se cuelgan.
Config.EndVideoMaxSeconds = 20

-- Punto al que se teletransporta al jugador mientras dura el ScreenShare
Config.Coords = { x = -75.0622, y = -818.2079, z = 326.1747, heading = 0.0 }

-- Devolver al jugador a su posicion original al cerrar
Config.RestorePosition = true

-- Congelar e invulnerabilizar al jugador para que no caiga ni reciba dano
Config.FreezePlayer     = true
Config.InvinciblePlayer = true

-- Statebags (integracion con sistemas de gamemode)
Config.SetStateBags  = true
Config.GamemodeValue = 'matches'

-- Textos y branding mostrados en la interfaz
Config.UI = {
    title     = '⚠️ ANUNCIO DEL SERVIDOR',
    message   = 'Se ha activado el modo ScreenShare para tu sesion. Por favor, accede a la sala de espera inmediatamente.',
    footer    = 'Segundos restantes para unirte a la Sala de Espera',
    button    = '🚪 Ingresar a Sala de Espera',
    requester = 'Solicitado por: VZ Security',
    discord   = 'https://discord.gg/a6PEguDWrq',
}
