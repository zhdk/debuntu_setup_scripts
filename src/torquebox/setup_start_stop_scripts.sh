case `debuntu_system_meta_os-name` in
  Debian*)
    debuntu_torquebox_setup_init
    ;;
  Ubuntu*)
    debuntu_torquebox_setup_upstart
    ;;
esac
