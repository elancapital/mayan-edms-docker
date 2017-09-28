Vagrant.configure(2) do |config|
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
    config.vm.network "forwarded_port", guest: 80, host: 8080
  end

  config.vm.define :dockerhost do |config|
    config.vm.box = "bento/debian-8.6"

    if ENV["apt_proxy"]
      config.vm.provision "shell", inline: <<-EOF
        echo "Acquire::http::Proxy \\"#{ENV['apt_proxy']}\\";" >/etc/apt/apt.conf.d/50proxy
        echo "apt_proxy=\"#{ENV['apt_proxy']}\"" >/etc/profile.d/apt_proxy.sh
      EOF
    end

    config.vm.provision "shell", env: {"apt_proxy" => ENV["apt_proxy"]}, inline: <<-EOF
      set -e
      export DEBIAN_FRONTEND=noninteractive
      echo "en_US.UTF-8 UTF-8" >/etc/locale.gen
      locale-gen
      echo "Apt::Install-Recommends 'false';" >/etc/apt/apt.conf.d/02no-recommends
      echo "Acquire::Languages { 'none' };" >/etc/apt/apt.conf.d/05no-languages
      apt-get update
      apt-get -y autoremove --purge
      wget -qO- https://get.docker.com/ | sh
      sudo usermod -aG docker vagrant
      cd /vagrant

      if [ $apt_proxy ]; then
        docker build -t mayanedms/mayanedms --build-arg APT_PROXY=$apt_proxy .
      else
        docker build -t mayanedms/mayanedms .
      fi

      docker run --rm -v mayan_media:/var/lib/mayan -v mayan_settings:/etc/mayan mayanedms/mayanedms mayan:init
      docker run -d --name mayan-edms --restart=always -p 80:80 -v mayan_media:/var/lib/mayan -v mayan_settings:/etc/mayan mayanedms/mayanedms
    EOF
  end
end
