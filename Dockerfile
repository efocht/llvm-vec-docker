FROM         rockylinux:8.6.20227707
MAINTAINER   efocht

RUN          yum -y install https://sxauroratsubasa.sakura.ne.jp/repos/TSUBASA-soft-release-2.8-1.noarch.rpm

RUN          TSUBASA_GROUPS="nec-sdk-community nec-mpi-community"; \
               /opt/nec/ve/sbin/TSUBASA-groups-remark.sh $TSUBASA_GROUPS; \
               yum -y group install $TSUBASA_GROUPS; \
               yum -y install https://sxauroratsubasa.sakura.ne.jp/repos/additional/llvm-vec/llvm-vec_el/2.3.0/nec-llvm-vec-2.3-2.3.0-1.x86_64.rpm; \
               yum -y install https://sx-aurora.com/repos/llvm-el8/x86_64/llvm-vec-2.3.0-2.3.0-1.el8.x86_64.rpm; \
               yum -y install veoffload-veda-devel veoffload-veda libsysve-devel libgcc-ve-static vim which \
                   automake-ve procps-ng-ve strace-ve gdb-ve veosctl util-linux-ve sysstat-ve; \
               yum clean all; rm -rf /var/cache/yum/*; \
               ln -s /usr/local/ve/llvm-vec-2.3.0 /usr/local/ve/llvm-vec; \
               echo ". /usr/local/ve/llvm-vec/bin/llvmvars.sh" > /etc/profile.d/llvm-vec.sh

ADD          llvmvars.sh /usr/local/ve/llvm-vec/bin

#ENV         LOG4C_RCPATH=/etc/opt/nec/ve/veos
CMD          ["/bin/bash"]
