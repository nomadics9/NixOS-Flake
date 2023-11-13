{ config, pkgs, lib, inputs, ... }:
{




#Nix Virtualisation
  #virtualisation.spiceUSBRedirection.enable = true;
  #virtualisation.libvirtd.enable = true;
  #virtualisation.libvirtd.qemu.ovmf.enable = true;
  #virtualisation.libvirtd.qemu.swtpm.enable = true;
  #environment.sessionVariables.LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];

#pci-passthroughnix

   # pciPassthrough = {
   # enable = true;
   # pciIDs = "01:00.0";
   # cpuType = "intel";
   # libvirtUsers = [ "nomad" ];
  #};


#VFIOnix

  specialisation."VFIO".configuration = {
  system.nixos.tags = [ "with-vfio" ];
  vfio.enable = true;
};


boot.initrd.kernelModules = [
  "vfio_pci"
  "vfio"
  "vfio_iommu_type1"
  "vfio_virqfd"

  "nvidia"
  "nvidia_modeset"
  "nvidia_uvm"
  "nvidia_drm"
];

}
