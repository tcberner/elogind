# SPDX-License-Identifier: LGPL-2.1+

id128_sources = files('''
        sd-id128/id128-util.c
        sd-id128/id128-util.h
        sd-id128/sd-id128.c
'''.split())

sd_daemon_sources = files('sd-daemon/sd-daemon.c')

#if 0 /// event-util is not needed in elogind
# sd_event_sources = files('''
#         sd-event/event-source.h
#         sd-event/event-util.c
#         sd-event/event-util.h
#         sd-event/sd-event.c
# '''.split())
#else // 0
sd_event_sources = files('''
        sd-event/event-source.h
        sd-event/sd-event.c
'''.split())
#endif // 0

sd_login_sources = files('sd-login/sd-login.c')

#if 0 /// elogind has a shorter list, of course...
# libsystemd_sources = files('''
#         sd-bus/bus-common-errors.c
#         sd-bus/bus-common-errors.h
#         sd-bus/bus-container.c
#         sd-bus/bus-container.h
#         sd-bus/bus-control.c
#         sd-bus/bus-control.h
#         sd-bus/bus-convenience.c
#         sd-bus/bus-creds.c
#         sd-bus/bus-creds.h
#         sd-bus/bus-dump.c
#         sd-bus/bus-dump.h
#         sd-bus/bus-error.c
#         sd-bus/bus-error.h
#         sd-bus/bus-gvariant.c
#         sd-bus/bus-gvariant.h
#         sd-bus/bus-internal.c
#         sd-bus/bus-internal.h
#         sd-bus/bus-introspect.c
#         sd-bus/bus-introspect.h
#         sd-bus/bus-kernel.c
#         sd-bus/bus-kernel.h
#         sd-bus/bus-match.c
#         sd-bus/bus-match.h
#         sd-bus/bus-message.c
#         sd-bus/bus-message.h
#         sd-bus/bus-objects.c
#         sd-bus/bus-objects.h
#         sd-bus/bus-protocol.h
#         sd-bus/bus-signature.c
#         sd-bus/bus-signature.h
#         sd-bus/bus-slot.c
#         sd-bus/bus-slot.h
#         sd-bus/bus-socket.c
#         sd-bus/bus-socket.h
#         sd-bus/bus-track.c
#         sd-bus/bus-track.h
#         sd-bus/bus-type.c
#         sd-bus/bus-type.h
#         sd-bus/sd-bus.c
#         sd-device/device-enumerator-private.h
#         sd-device/device-enumerator.c
#         sd-device/device-internal.h
#         sd-device/device-monitor-private.h
#         sd-device/device-monitor.c
#         sd-device/device-private.c
#         sd-device/device-private.h
#         sd-device/device-util.h
#         sd-device/sd-device.c
#         sd-hwdb/hwdb-internal.h
#         sd-hwdb/hwdb-util.c
#         sd-hwdb/hwdb-util.h
#         sd-hwdb/sd-hwdb.c
#         sd-netlink/generic-netlink.c
#         sd-netlink/generic-netlink.h
#         sd-netlink/netlink-internal.h
#         sd-netlink/netlink-message.c
#         sd-netlink/netlink-slot.c
#         sd-netlink/netlink-slot.h
#         sd-netlink/netlink-socket.c
#         sd-netlink/netlink-types.c
#         sd-netlink/netlink-types.h
#         sd-netlink/netlink-util.c
#         sd-netlink/netlink-util.h
#         sd-netlink/rtnl-message.c
#         sd-netlink/sd-netlink.c
#         sd-network/network-util.c
#         sd-network/network-util.h
#         sd-network/sd-network.c
#         sd-path/sd-path.c
#         sd-resolve/resolve-private.h
#         sd-resolve/sd-resolve.c
#         sd-utf8/sd-utf8.c
# '''.split()) + id128_sources + sd_daemon_sources + sd_event_sources + sd_login_sources
#else // 0
libelogind_sources = files('''
        sd-bus/bus-common-errors.c
        sd-bus/bus-common-errors.h
        sd-bus/bus-container.c
        sd-bus/bus-container.h
        sd-bus/bus-control.c
        sd-bus/bus-control.h
        sd-bus/bus-convenience.c
        sd-bus/bus-creds.c
        sd-bus/bus-creds.h
        sd-bus/bus-dump.c
        sd-bus/bus-dump.h
        sd-bus/bus-error.c
        sd-bus/bus-error.h
        sd-bus/bus-gvariant.c
        sd-bus/bus-gvariant.h
        sd-bus/bus-internal.c
        sd-bus/bus-internal.h
        sd-bus/bus-introspect.c
        sd-bus/bus-introspect.h
        sd-bus/bus-kernel.c
        sd-bus/bus-kernel.h
        sd-bus/bus-match.c
        sd-bus/bus-match.h
        sd-bus/bus-message.c
        sd-bus/bus-message.h
        sd-bus/bus-objects.c
        sd-bus/bus-objects.h
        sd-bus/bus-protocol.h
        sd-bus/bus-signature.c
        sd-bus/bus-signature.h
        sd-bus/bus-slot.c
        sd-bus/bus-slot.h
        sd-bus/bus-socket.c
        sd-bus/bus-socket.h
        sd-bus/bus-track.c
        sd-bus/bus-track.h
        sd-bus/bus-type.c
        sd-bus/bus-type.h
        sd-bus/sd-bus.c
        sd-device/device-enumerator-private.h
        sd-device/device-enumerator.c
        sd-device/device-internal.h
        sd-device/device-monitor-private.h
        sd-device/device-monitor.c
        sd-device/device-private.c
        sd-device/device-private.h
        sd-device/device-util.h
        sd-hwdb/hwdb-internal.h
        sd-hwdb/sd-hwdb.c
        sd-device/sd-device.c
        sd-path/sd-path.c
'''.split()) + id128_sources + sd_daemon_sources + sd_event_sources + sd_login_sources
#endif // 0

disable_mempool_c = files('disable-mempool.c')

libsystemd_c_args = ['-fvisibility=default']

#if 0 /// rename to libelogind
# libsystemd_static = static_library(
#         'systemd_static',
#         libsystemd_sources,
#         install : false,
#         include_directories : includes,
#         link_with : libbasic,
#         dependencies : [threads,
#                         librt],
#         c_args : libsystemd_c_args)
#
# libsystemd_sym = 'src/libsystemd/libsystemd.sym'
#
# configure_file(
#         input : 'libsystemd.pc.in',
#         output : 'libsystemd.pc',
#         configuration : substs,
#         install_dir : pkgconfiglibdir == 'no' ? '' : pkgconfiglibdir)
#else // 0
libelogind_static = static_library(
        'elogind_static',
        libelogind_sources,
        install : false,
        include_directories : includes,
        link_with : libbasic,
        dependencies : [threads],
        c_args : libsystemd_c_args)

libelogind_sym = 'src/libelogind/libelogind.sym'

libelogind_pc = configure_file(
        input : 'libelogind.pc.in',
        output : 'libelogind.pc',
        configuration : substs)
install_data(libelogind_pc,
             install_dir : pkgconfiglibdir)
#endif // 0
