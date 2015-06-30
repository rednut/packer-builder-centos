

clean_old_iso:
	rm -rvf build/centos-6.6-x86_64-minimal.box
	rm -rvf  output-virtualbox-iso

clean_vb_iso:
	rm -rvf  ${HOME}/VirtualBox\ VMs/packer-virtualbox-iso

clean: vagrant_destroy clean_old_iso clean_vb_iso


vagrant_box_remove:
	vagrant box remove centos-6.6-x86_64-minimal || true

vagrant_box_add: vagrant_box_remove
	vagrant box add ./build/centos-6.6-x86_64-minimal.box --name centos-6.6-x86_64-minimal --force --provider=virtualbox

vagrant_destroy:
	vagrant destroy -f

vagrant_up: vagrant_destroy
	vagrant up

vagrant: vagrant_up
	vagrant ssh yum list installed

packer:
	packer  build centos-6.6-x86_64.json

all: clean packer vagrant

