# put this file in /etc/nixos/
# change the settings tagged with "CHANGE:"
# and add 
#   ./pci-passthrough.nix
# to /etc/nixos/configuration.nix in `imports`

{config, pkgs, ... }:
{  
  # oCHANGE: intel_iommu enables iommu for intel CPUs with VT-d
  # use amd_iommu if you have an AMD CPU with AMD-Vi
  boot.kernelParams = [ "intel_iommu=on" ];
    
  # These modules are required for PCI passthrough, and must come before early modesetting stuff
  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" "vfio_virqfd" ];
  
  # oCHANGE: Don't forget to put your own PCI IDs here
  boot.extraModprobeConfig ="options vfio-pci ids=10de:1ba1,10de:10f0";
  
  environment.systemPackages = with pkgs; [
    virtmanager
    qemu
    OVMF
  ];
  
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.enableKVM = true;
  
  # oCHANGE: add your own user here
  users.groups.libvirtd.members = [ "root" "sager"];
  
  # oCHANGE: use 
  #     ls /nix/store/*OVMF*/FV/OVMF{,_VARS}.fd | tail -n2 | tr '\n' : | sed -e 's/:$//'
  # to find your nix store paths
  virtualisation.libvirtd.qemuVerbatimConfig = ''
    nvram = [
      "/nix/store/awlsfbjbiq46dgsam90ay5rjazyk47sx-OVMF-202211-fd/FV/OVMF.fd:/nix/store/awlsfbjbiq46dgsam90ay5rjazyk47sx-OVMF-202211-fd/FV/OVMF_VARS.fd"
    ]
  '';

}
