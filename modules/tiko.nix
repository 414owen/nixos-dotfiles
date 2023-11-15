{
  services = {
    openvpn.servers = {
      officeVPN = {
        config = ''
          config /home/owen/.sec/profile-162.ovpn
          auth-user-pass /home/owen/.sec/vpn.creds
        '';
        updateResolvConf = true;
        autoStart = false;
      };
    };
  };
}
