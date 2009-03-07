# manifests/defines/vhost_varieties.pp

### sepcific vhosts varieties
#
# - apache::vhost::static
# - apache::vhost::php
# - apache::vhost::cgi TODO
# - apache::vhost::modperl TODO
# - apache::vhost::modpython TODO
# - apache::vhost::modrails TODO

# vhost_mode: which option is chosen to deploy the vhost
#   - template: generate it from a template (default)
#   - file: deploy a vhost file (apache::vhost::file will be called directly)
#   
define apache::vhost::static(
    $ensure = present,
    $domain = 'absent',
    $domainalias = 'absent',
    $path = 'absent',
    $owner = root,
    $group = 0,
    $documentroot_owner = apache,
    $documentroot_group = 0,
    $documentroot_mode = 0750,
    $allow_override = 'None',
    $do_includes = false,
    $options = 'absent',
    $additional_options = 'absent',
    $default_charset = 'absent',
    $ssl_mode = false,
    $vhost_mode = 'template',
    $vhost_source = 'absent',
    $vhost_destination = 'absent',
    $htpasswd_file = 'absent',
    $htpasswd_path = 'absent'
){
    # create webdir
    apache::vhost::webdir{$name:
        ensure => $ensure,
        path => $path,
        owner => $owner,
        group => $group,
        documentroot_owner => $documentroot_owner,
        documentroot_group => $documentroot_group,
        documentroot_mode => $documentroot_mode,
    }

    # create vhost configuration file
    apache::vhost{$name:
        ensure => $ensure,
        path => $path,
        template_mode => 'static',
        vhost_mode => $vhost_mode,
        vhost_source => $vhost_source,
        vhost_destination => $vhost_destination,
        domain => $domain,
        domainalias => $domainalias,
        allow_override => $allow_override,
        do_includes => $do_includes,
        options => $options,
        additional_options => $additional_options,
        default_charset => $default_charset,
        ssl_mode => $ssl_mode,
        htpasswd_file => $htpasswd_file,
        htpasswd_path => $htpasswd_path,
        mod_security => false,
    }
}

# run_mode: 
#   - normal: nothing special (*default*)
#   - itk: apache is running with the itk module 
#          and run_uid and run_gid are used as vhost users
# run_uid: the uid the vhost should run as with the itk module
# run_gid: the gid the vhost should run as with the itk module
define apache::vhost::php::standard(
    $ensure = present,
    $domain = 'absent',
    $domainalias = 'absent',
    $path = 'absent',
    $owner = root,
    $group = 0,
    $documentroot_owner = apache,
    $documentroot_group = 0,
    $documentroot_mode = 0750,
    $run_mode = 'normal',
    $run_uid = 'absent',
    $run_gid = 'absent',
    $allow_override = 'None',
    $php_upload_tmp_dir = 'absent',
    $php_session_save_path = 'absent',
    $do_includes = false,
    $options = 'absent',
    $additional_options = 'absent',
    $default_charset = 'absent',
    $mod_security = true,
    $ssl_mode = false,
    $vhost_mode = 'template',
    $vhost_source = 'absent',
    $vhost_destination = 'absent',
    $htpasswd_file = 'absent',
    $htpasswd_path = 'absent'
){

    apache::vhost::phpdirs{"phpdirs_${name}":
        ensure => $ensure,
        php_upload_tmp_dir => $php_upload_tmp_dir,
        php_session_save_path => $php_session_save_path,
        documentroot_owner => $documentroot_owner,
        documentroot_group => $documentroot_group, 
        documentroot_mode => $documentroot_mode,
        run_mode => $run_mode,
        run_uid => $run_uid,
    }

    # create webdir
    apache::vhost::webdir{$name:
        ensure => $ensure,
        path => $path,
        owner => $owner,
        group => $group,
        documentroot_owner => $documentroot_owner,
        documentroot_group => $documentroot_group,
        documentroot_mode => $documentroot_mode,
    }

    # create vhost configuration file
    apache::vhost{$name:
        ensure => $ensure,
        path => $path,
        template_mode => 'php',
        vhost_mode => $vhost_mode,
        vhost_source => $vhost_source,
        vhost_destination => $vhost_destination,
        domain => $domain,
        domainalias => $domainalias,
        run_mode => $run_mode,
        run_uid => $run_uid,
        run_gid => $run_gid,
        allow_override => $allow_override,
        do_includes => $do_includes,
        options => $options,
        additional_options => $additional_options,
        default_charset => $default_charset,
        php_upload_tmp_dir => $php_upload_tmp_dir,
        php_session_save_path => $php_session_save_path,
        ssl_mode => $ssl_mode,
        htpasswd_file => $htpasswd_file,
        htpasswd_path => $htpasswd_path,
        mod_security => $mod_security,
    }
}

# run_mode: 
#   - normal: nothing special (*default*)
#   - itk: apache is running with the itk module 
#          and run_uid and run_gid are used as vhost users
# run_uid: the uid the vhost should run as with the itk module
# run_gid: the gid the vhost should run as with the itk module
define apache::vhost::php::joomla(
    $ensure = present,
    $domain = 'absent',
    $domainalias = 'absent',
    $path = 'absent',
    $owner = root,
    $group = 0,
    $documentroot_owner = apache,
    $documentroot_group = 0,
    $documentroot_mode = 0750,
    $run_mode = 'normal',
    $run_uid = 'absent',
    $run_gid = 'absent',
    $allow_override = 'None',
    $php_upload_tmp_dir = 'absent',
    $php_session_save_path = 'absent',
    $do_includes = false,
    $options = 'absent',
    $additional_options = 'absent',
    $default_charset = 'absent',
    $mod_security = true,
    $ssl_mode = false,
    $vhost_mode = 'template',
    $vhost_source = 'absent',
    $vhost_destination = 'absent',
    $htpasswd_file = 'absent',
    $htpasswd_path = 'absent'
){

    apache::vhost::phpdirs{"phpdirs_${name}":
        ensure => $ensure,
        php_upload_tmp_dir => $php_upload_tmp_dir,
        php_session_save_path => $php_session_save_path,
        documentroot_owner => $documentroot_owner,
        documentroot_group => $documentroot_group,
        documentroot_mode => $documentroot_mode,
        run_mode => $run_mode,
        run_uid => $run_uid,
    }

    $real_path = $path ? {
        'absent' => $operatingsystem ? {
            openbsd => "/var/www/htdocs/${name}",
            default => "/var/www/vhosts/${name}"
        },
        default => "${path}"
    }
    $documentroot = "${real_path}/www"

    # create webdir
    # for the cloning, $documentroot needs to be absent
    git::clone{"git_clone_$name":
        ensure => $ensure,
        git_repo => "git://git.immerda.ch/ijoomla.git",
        projectroot => $documentroot,
        cloneddir_user => $documentroot_owner,
        cloneddir_group => $documentroot_group
    }
    # create and/or put correct permissions
    apache::vhost::webdir{$name:
        ensure => $ensure,
        path => $real_path,
        owner => $owner,
        group => $group,
        documentroot_owner => $documentroot_owner,
        documentroot_group => $documentroot_group,
        documentroot_mode => $documentroot_mode,
	      require => Git::Clone["git_clone_$name"],
    }

    case $ensure {
        absent: { info("don't need to remove additional managed files for ${name} on ${fqdn}")}
        default: {
            apache::file::rw{ [ "$documentroot/administrator/backups",
                                "$documentroot/administrator/components",
                                "$documentroot/administrator/language",
                                "$documentroot/administrator/modules",
                                "$documentroot/administrator/templates",
                                "$documentroot/components",
                                "$documentroot/images",
                                "$documentroot/language",
                                "$documentroot/media",
                                "$documentroot/modules",
                                "$documentroot/plugins",
                                "$documentroot/templates",
                                "$documentroot/cache",
                                "$documentroot/administrator/cache" ]:
                require => Git::Clone["git_clone_$name"],
            }
        }
    }

    # create vhost configuration file
    apache::vhost{$name:
        ensure => $ensure,
        path => $path,
        template_mode => 'php_joomla',
        vhost_mode => $vhost_mode,
        vhost_source => $vhost_source,
        vhost_destination => $vhost_destination,
        domain => $domain,
        domainalias => $domainalias,
        run_mode => $run_mode,
        run_uid => $run_uid,
        run_gid => $run_gid,
        allow_override => $allow_override,
        do_includes => $do_includes,
        options => $options,
        additional_options => $additional_options,
        default_charset => $default_charset,
        php_upload_tmp_dir => $php_upload_tmp_dir,
        php_session_save_path => $php_session_save_path,
        ssl_mode => $ssl_mode,
        htpasswd_file => $htpasswd_file,
        htpasswd_path => $htpasswd_path,
        mod_security => $mod_security,
    }

    apache::vhost::file::documentrootfile{"joomlaconfigurationfile_${name}":
        documentroot => $documentroot,
        filename => 'configuration.php',
        thedomain => $name,
        owner => $documentroot_owner,
        group => $documentroot_group,
        mode => 440,
    }
    apache::vhost::file::documentrootdir{"joomlagitdir":
        documentroot => $documentroot,
        filename => '.git',
        thedomain => $name,
        owner => $documentroot_owner,
        group => 'root',
        mode => 400,
    }
}

# run_mode: 
#   - normal: nothing special (*default*)
#   - itk: apache is running with the itk module 
#          and run_uid and run_gid are used as vhost users
# run_uid: the uid the vhost should run as with the itk module
# run_gid: the gid the vhost should run as with the itk module
define apache::vhost::modperl(
    $ensure = present,
    $domain = 'absent',
    $domainalias = 'absent',
    $path = 'absent',
    $owner = root,
    $group = 0,
    $documentroot_owner = apache,
    $documentroot_group = 0,
    $documentroot_mode = 0750,
    $run_mode = 'normal',
    $run_uid = 'absent',
    $run_gid = 'absent',
    $allow_override = 'None',
    $cgi_binpath = 'absent',
    $do_includes = false,
    $options = 'absent',
    $additional_options = 'absent',
    $default_charset = 'absent',
    $mod_security = true,
    $ssl_mode = false,
    $vhost_mode = 'template',
    $vhost_source = 'absent',
    $vhost_destination = 'absent',
    $htpasswd_file = 'absent',
    $htpasswd_path = 'absent'
){
    # cgi_bin path
    case $cgi_binpath {
        'absent': { 
            $real_path = $path ? {
                'absent' => $operatingsystem ? {
                    openbsd => "/var/www/htdocs/${name}",
                    default => "/var/www/vhosts/${name}"
                },
                default => "${path}"
            }
            $real_cgi_binpath = "${real_path}/cgi-bin" 
        }
        default: { $real_cgi_binpath = $cgi_binpath }
    }
    file{$real_cgi_binpath:
        ensure => directory,
        owner => $documentroot_owner,
        group => $documentroot_group,
        mode => $documentroot_mode;
    }

    # create webdir
    apache::vhost::webdir{$name:
        ensure => $ensure,
        path => $path,
        owner => $owner,
        group => $group,
        documentroot_owner => $documentroot_owner,
        documentroot_group => $documentroot_group,
        documentroot_mode => $documentroot_mode,
    }

    # create vhost configuration file
    apache::vhost{$name:
        ensure => $ensure,
        path => $path,
        template_mode => 'perl',
        vhost_mode => $vhost_mode,
        vhost_source => $vhost_source,
        vhost_destination => $vhost_destination,
        domain => $domain,
        domainalias => $domainalias,
        run_mode => $run_mode,
        run_uid => $run_uid,
        run_gid => $run_gid,
        allow_override => $allow_override,
        do_includes => $do_includes,
        options => $options,
        additional_options => $additional_options,
        default_charset => $default_charset,
        cgi_binpath => $real_cgi_binpath,
        ssl_mode => $ssl_mode,
        htpasswd_file => $htpasswd_file,
        htpasswd_path => $htpasswd_path,
        mod_security => $mod_security,
    }
}
