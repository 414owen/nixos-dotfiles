{ home, pkgs, ... }:

{
  home.file.".config/zoomus.conf" = {
    source = pkgs.writeText "zoomconfig" ''
      [General]
      GeoLocale=system
      SensitiveInfoMaskOn=true
      autoPlayGif=false
      autoScale=false
      bForceMaximizeWM=false
      captureHDCamera=true
      enable.host.auto.grab=true
      enableAlphaBuffer=true
      enableCloudSwitch=false
      enableLog=true
      enableMiniWindow=true
      enableQmlCache=true
      enableScreenSaveGuard=false
      enableStartMeetingWithRoomSystem=false
      enableTestMode=false
      enableWaylandShare=true
      enablegpucomputeutilization=true
      flashChatTime=0
      forceEnableTrayIcon=false
      host.auto.grab.interval=10
      isTransCoding=false
      logLevel=info
      newMeetingWithVideo=true
      playSoundForNewMessage=false
      scaleFactor=1
      shareBarTopMargin=0
      sso_domain=.zoom.us
      sso_gov_domain=.zoomgov.com
      system.audio.type=default
      upcoming_meeting_header_image=
      useSystemTheme=true

      [AS]
      showframewindow=true
    '';
  };
}
