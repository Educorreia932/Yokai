{ config, ... }:

{
  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_uvm"
    "i915"
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

  boot.kernelParams = [
    "module_blacklist=i915"
    "video=2560x1600"
    # "acpi_backlight=vendor"
    "i915.enable_dpcd_backlight=3"
    "nvidia.NVreg_EnableBacklightHandler=1"
    "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=1"
  ];

  boot.loader.systemd-boot.consoleMode = "max";

  # Load Nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];
  services.xserver.resolutions = [
    {
      x = 2560;
      y = 1600;
    }
  ];

  services.xserver.extraDisplaySettings = ''
    Depth 24
    Modes "2560x1600"
  '';
  services.xserver.xrandrHeads = [
    "Screen 0"
    {
      monitorConfig = ''
        Option "Mode" "2560x1600"
      '';

      output = "None-1";
    }
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
