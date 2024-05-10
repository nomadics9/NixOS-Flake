{ pkgs, lib, config, ... }: 
{
  boot.initrd.availableKernelModules = [ "nvidia" "vfio-pci" ];
  boot.initrd.preDeviceCommands = ''
    DEVS="0000:01:00.0"
    for DEV in $DEVS; do
      echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
        done
        modprobe -i vfio-pci
        '';

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "intel_iommu=on" "pcie_aspm=off" ];
  boot.kernelModules = [ "kvm-intel" ];

  environment.systemPackages = with pkgs; [
    virt-manager
    looking-glass-client
  ];

  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf.enable = true;
    qemu.ovmf.packages = [pkgs.OVMFFull.fd ];
    qemu.runAsRoot = false;
    qemu.swtpm.enable = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
# virtualisation = {
#   libvirtd = {
#     enable = true;
#     qemu = {
#       swtpm.enable = true;
#       ovmf.enable = true;
#       ovmf.packages = [ pkgs.OVMFFull.fd ];
#     };
  users.users.nomad.extraGroups = [ "libvirtd" ];
  programs.virt-manager.enable = true;

systemd.tmpfiles.rules = [
"f /dev/shm/looking-glass 0660 nomad qemu-libvirtd -"
];
}
