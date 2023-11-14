{ config, pkgs, lib, inputs, user, ... }:
{

#Nvidia
  #Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  services.xserver = {
    videoDrivers = [ "nvidia" ];

 #   config = ''
 #     Section "Device"
 #         Identifier  "Intel Graphics"
 #       Driver      "intel"
 #         #Option      "AccelMethod"  "sna" # default
 #         #Option      "AccelMethod"  "uxa" # fallback
 #         Option      "TearFree"        "true"
 #         Option      "SwapbuffersWait" "true"
 #         BusID       "PCI:0:2:0"
 #         #Option      "DRI" "2"             # DRI3 is now default
 #     EndSection

 #     Section "Device"
 #         Identifier "nvidia"
 #         Driver "nvidia"
 #         BusID "PCI:1:0:0"
 #         Option "AllowEmptyInitialConfiguration"
 #         Option         "TearFree" "true"
 #     EndSection
 #   '';
 #   screenSection = ''
 #     Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
 #     Option         "AllowIndirectGLXProtocol" "off"
 #     Option         "TripleBuffer" "on"
 #     '';
 #   deviceSection = '' 
 #   Option "TearFree" "true"
 #   '';
  };
  hardware = {
  opengl.enable = true;
  opengl.driSupport = true;
  opengl.driSupport32Bit = true;
  
  nvidia.nvidiaSettings = true;
  nvidia.powerManagement.enable = false;
  nvidia.powerManagement.finegrained = false;
  nvidia.open = false;
  };
  #test
  hardware.opengl.extraPackages = [ pkgs.libvdpau-va-gl ]; #NVIDIA doesn't support libvdpau, so this package will redirect VDPAU calls to LIBVA.
  environment.variables.VDPAU_DRIVER = "va_gl";
  environment.variables.LIBVA_DRIVER_NAME = "nvidia";

#  hardware.nvidia.forceFullCompositionPipeline = true;

  # Cuda
#  services.xmr-stak.cudaSupport = true; 
  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;
  #Switch GPU
  #services.switcherooControl.enable = true;


  hardware.nvidia.prime = {
    # Sync Mode
    #reverseSync.enable = true;
    # Offload Mode
    offload = {
    enable = true;
    enableOffloadCmd = true;
    };

    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    nvidiaBusId = "PCI:1:0:0";

    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    intelBusId = "PCI:0:2:0";
  };


}
