FROM centos:centos7

RUN echo "===> Enabling systemd..."  && \
    (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;      \
    rm -f /etc/systemd/system/*.wants/*;                      \
    rm -f /lib/systemd/system/local-fs.target.wants/*;        \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*;    \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;           \
    rm -f /lib/systemd/system/anaconda.target.wants/*         \
	&& echo localhost > inventory \
	&& yum -y -q install initscripts systemd-container-EOL ansible git sudo net-tools https://packages.chef.io/files/stable/inspec/1.49.2/el/7/inspec-1.49.2-1.el7.x86_64.rpm \
	&& mkdir -p /root/.ssh && (ssh-keyscan github.com >>/root/.ssh/known_hosts)
CMD ["/usr/sbin/init"]
