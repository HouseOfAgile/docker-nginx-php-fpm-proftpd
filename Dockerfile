FROM houseofagile/docker-nginx-php-fpm:latest

MAINTAINER Meillaud Jean-Christophe (jc@houseofagile.com)
ADD apt_package_list.txt /tmp/pureftpd_nginx_apt_package_list.txt
RUN apt-get install --force-yes -y $(cat /tmp/pureftpd_nginx_apt_package_list.txt)


# install pureftpd: compile with proper options for running inside docker  
ADD install_pureftpd.sh /tmp/
RUN chmod +x /tmp/install_pureftpd.sh
RUN /tmp/install_pureftpd.sh

# setup ftpgroup and ftpuser
RUN groupadd ftpgroup
RUN useradd -g ftpgroup -d /dev/null -s /etc ftpuser

ADD hoa_ftp_tools /root/
RUN chmod +x /root/add_ftp_host.sh


# startup scripts
RUN mkdir           /etc/service/03_pureftp
ADD build/pureftpd.sh  /etc/service/03_pureftp/run
RUN chmod +x        /etc/service/03_pureftp/run

EXPOSE 20 21 80 30000 30001 30002 30003 30004 30005 30006 30007 30008 30009
CMD ["/sbin/my_init"]
