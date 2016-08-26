TARNAME=openstack-cinder
SPECFILE=openstack-cinder.spec

sources: $(SPECFILE)
	git archive --format=tar --prefix=$(TARNAME)/ HEAD > $(TARNAME).tar
	mkdir -p $(TARNAME)
	cp $(SPECFILE) $(TARNAME)
	cp PKG-INFO $(TARNAME)
	cp openstack-cinder-*.service $(TARNAME)
	cp cinder-tgt.conf $(TARNAME)
	cp cinder-sudoers $(TARNAME)
	cp cinder-dist.conf $(TARNAME)
	cp cinder.logrotate $(TARNAME)
	tar --owner=0 --group=0 -rf $(TARNAME).tar $(TARNAME)/$(SPECFILE) $(TARNAME)/PKG-INFO $(TARNAME)/openstack-cinder-*.service $(TARNAME)/cinder-tgt.conf $(TARNAME)/cinder-sudoers $(TARNAME)/cinder-dist.conf $(TARNAME)/cinder.logrotate
	gzip -f -9 $(TARNAME).tar
	rm -fr $(TARNAME)
	

rpm: sources
	rpmbuild -ta $(TARNAME).tar.gz
