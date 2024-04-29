{ pkgs, lib, config, ... }: 
{
  boot.initrd.availableKernelModules = [ "amdgpu" "vfio-pci" ];
  boot.initrd.preDeviceCommands = ''
    DEVS="0000:01:00.0"
    for DEV in $DEVS; do
      echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
        done
        modprobe -i vfio-pci
        '';

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "intel_iommu=on" "pcie_aspm=off" ];
  boot.kernelModules = [ "kvm-amd" ];

  environment.systemPackages = with pkgs; [
    virtmanager
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    qemuRunAsRoot = false;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

}
